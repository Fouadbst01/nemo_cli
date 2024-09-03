import Foundation
import Alamofire

struct Headers {
    
    static let loginHeader = [
        HTTPHeaderKey.cacheControl: HTTPHeaderValue.noStore,
        HTTPHeaderKey.pragma: HTTPHeaderValue.noCache,
        HTTPHeaderKey.contentType: HTTPHeaderValue.urlEncodedType
    ]

    static let refreshTokenHeader = [
        HTTPHeaderKey.accept: HTTPHeaderValue.acceptAny,
        HTTPHeaderKey.contentType: HTTPHeaderValue.urlEncodedType
    ]
    
    static var headerWithToken: HTTPHeaders {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
//        if let accessToken = UserSession.shared.accessToken {
//            headers[HTTPHeaderKey.authorization] = "Bearer \(accessToken)"
//        }
        
        return headers
    }
}
