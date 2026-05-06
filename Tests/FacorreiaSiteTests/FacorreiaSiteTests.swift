@testable import FacorreiaSite
import VaporTesting
import Testing

@Suite("App Tests")
struct FacorreiaSiteTests {
    @Test("Test Projects Route")
    func projects() async throws {
        try await withApp(configure: configure) { app in
            try await app.testing().test(.GET, "projects", afterResponse: { res async in
                #expect(res.status == .ok)
                #expect(res.body.string.contains("StockPlan"))
                #expect(res.body.string.contains("portfolio tracker backend"))
            })
        }
    }
}
