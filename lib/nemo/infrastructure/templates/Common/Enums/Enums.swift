import Foundation

enum HTTPHeaderKey {
    static let cacheControl = "Cache-Control"
    static let pragma = "Pragma"
    static let contentType = "Content-Type"
    static let accept = "Accept"
    static let authorization = "Authorization"
}

enum HTTPHeaderValue {
    static let noStore = "no-store"
    static let noCache = "no-cache"
    static let urlEncodedType = "application/x-www-form-urlencoded"
    static let acceptAny = "*/*"
}