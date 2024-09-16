import Foundation
import Alamofire
@testable import LibApp

class NetworkManagerMock: NetworkManagerProtocol {
    static var shared: NetworkManagerProtocol = NetworkManagerMock()
    var manager: Alamofire.Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 720 // seconds
        configuration.timeoutIntervalForResource = 720
        configuration.protocolClasses = [MockURLProtocol.self]
        self.manager = Alamofire.Session(configuration: configuration)
    }
    
    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?
    ) -> DataRequest {
        manager.request(
            url,
            method: method,
            parameters:parameters,
            encoding: encoding,
            headers: headers
        ).validate(statusCode: 200..<299)
    }
}