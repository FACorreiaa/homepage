import Leaf
import Vapor

/// A custom Leaf tag that renders content without HTML escaping.
/// Usage in templates: #unsafeRaw(variable)
struct UnsafeRawTag: UnsafeUnescapedLeafTag {
    func render(_ ctx: LeafContext) throws -> LeafData {
        guard let body = ctx.parameters.first else {
            throw Abort(.internalServerError, reason: "#unsafeRaw requires a parameter")
        }
        return body
    }
}
