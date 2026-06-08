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
                #expect(res.body.string.contains("LuminaVault"))
                #expect(res.body.string.contains("AI Memory"))
            })
        }
    }

    @Test("Test Bookmarks Route")
    func bookmarks() async throws {
        try await withApp(configure: configure) { app in
            try await app.testing().test(.GET, "bookmarks", afterResponse: { res async in
                #expect(res.status == .ok)
                #expect(res.body.string.contains("Knowledge Graph"))
            })
        }
    }

    @Test("Test Graph API")
    func graphAPI() async throws {
        try await withApp(configure: configure) { app in
            try await app.testing().test(.GET, "api/graph", afterResponse: { res async in
                #expect(res.status == .ok)
                #expect(res.headers.contentType == .json)
            })
        }
    }
}
