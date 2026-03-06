import Vapor

actor BlogTracker {
    static let shared = BlogTracker()

    struct Stats: Codable {
        var totalViews: Int = 0
        var uniqueIPs: Set<String> = []
        var flags: [String: Int] = [:]  // CountryCode -> Count
    }

    private var stats: Stats
    private let fileURL = URL(fileURLWithPath: DirectoryConfiguration.detect().workingDirectory)
        .appendingPathComponent("blog_stats.json")

    private init() {
        if let data = try? Data(contentsOf: fileURL),
            let decoded = try? JSONDecoder().decode(Stats.self, from: data)
        {
            self.stats = decoded
        } else {
            self.stats = Stats()
        }
    }

    func recordVisit(req: Request) async {
        stats.totalViews += 1

        let ip =
            req.headers.first(name: "X-Forwarded-For")?.split(separator: ",").first.map(String.init)
            ?? req.remoteAddress?.ipAddress ?? "unknown"

        if ip != "unknown" && !stats.uniqueIPs.contains(ip) {
            stats.uniqueIPs.insert(ip)

            // Skip loopback addresses
            if ip != "127.0.0.1" && ip != "::1" {
                // Fetch Country Code from IP-API asynchronously
                // We use Task to run it in background so it doesn't block the request response
                Task {
                    struct IPAPIResponse: Content {
                        let status: String
                        let countryCode: String?
                    }

                    do {
                        let response = try await req.client.get("http://ip-api.com/json/\(ip)")
                        if let ipData = try? response.content.decode(IPAPIResponse.self),
                            ipData.status == "success",
                            let code = ipData.countryCode
                        {
                            await self.addCountryCode(code)
                        }
                    } catch {
                        req.logger.warning("Failed to fetch IP country code: \(error)")
                    }
                }
            } else {
                // Localhost testing mock
                await self.addCountryCode("US")
            }
        }

        save()
    }

    // Called by the detached Task
    func addCountryCode(_ code: String) {
        stats.flags[code, default: 0] += 1
        save()
    }

    func getDisplayStats() -> (views: Int, flagList: [(flag: String, count: Int)]) {
        let sortedFlags = stats.flags.sorted { $0.value > $1.value }.map {
            (flag: countryCodeToEmoji($0.key), count: $0.value)
        }
        return (stats.totalViews, sortedFlags)
    }

    private func save() {
        if let data = try? JSONEncoder().encode(stats) {
            try? data.write(to: fileURL)
        }
    }

    private func countryCodeToEmoji(_ countryCode: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for scalar in countryCode.uppercased().unicodeScalars {
            if let emojiScalar = UnicodeScalar(base + scalar.value) {
                s.append(String(emojiScalar))
            }
        }
        return s.isEmpty ? "🌍" : s
    }
}
