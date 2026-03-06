import Vapor

struct ErrorPageMiddleware: AsyncMiddleware {
    func respond(to req: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        do {
            return try await next.respond(to: req)
        } catch {
            let status: HTTPResponseStatus
            if let abort = error as? any AbortError {
                status = abort.status
            } else {
                status = .internalServerError
                req.logger.error("Unhandled error: \(String(reflecting: error))")
            }

            let context = ErrorPageContext(
                title: "\(status.code) | FC Software Studio",
                activePage: "",
                statusCode: status.code,
                statusReason: status.reasonPhrase,
                message: self.message(for: status)
            )
            let view = try await req.view.render("error", context).get()
            let response = try await view.encodeResponse(for: req)
            response.status = status
            return response
        }
    }

    private func message(for status: HTTPResponseStatus) -> String {
        switch status.code {
        case 404:
            return "The page you requested does not exist."
        case 401, 403:
            return "You do not have permission to access this page."
        case 500 ... 599:
            return "Something went wrong on our side. Please try again in a moment."
        default:
            return "The request could not be completed."
        }
    }
}

private struct ErrorPageContext: Content {
    let title: String
    let activePage: String
    let statusCode: UInt
    let statusReason: String
    let message: String
}
