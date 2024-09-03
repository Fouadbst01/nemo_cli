import Foundation
import Alamofire

class NetworkManager: SessionDelegate, NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    var manager: Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 720 // seconds
        configuration.timeoutIntervalForResource = 720
        
        if let infoDict = Bundle.main.infoDictionary, let isSSLEnabled = infoDict["USE_SSL_PINNING"] as? NSString, isSSLEnabled.boolValue {
            
            //TODO: check this line
            self.manager = Alamofire.Session(
                configuration: configuration,
                serverTrustManager: ServerTrustManager(
                    evaluators: ["test.test.com": PinnedCertificatesTrustEvaluator(validateHost: true)]
                )
            )
            
        } else {
            self.manager = Alamofire.Session(configuration: configuration)
        }
    }
    
    func request(
        _ url: Alamofire.URLConvertible,
        method: Alamofire.HTTPMethod = .get,
        parameters: Alamofire.Parameters? = nil,
        encoding: Alamofire.ParameterEncoding = URLEncoding.default,
        headers: Alamofire.HTTPHeaders? = nil
    ) -> Alamofire.DataRequest {
        manager.request(
            url,
            method: method,
            parameters:parameters,
            encoding: encoding,
            headers: headers
        ).validate(statusCode: 200..<299)
    }
}

protocol NetworkManagerProtocol {
    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?
    ) -> DataRequest
}

extension NetworkManagerProtocol {
    func request(
        _ url: Alamofire.URLConvertible,
        method: Alamofire.HTTPMethod = .get,
        parameters: Alamofire.Parameters? = nil,
        encoding: Alamofire.ParameterEncoding = URLEncoding.default,
        headers: Alamofire.HTTPHeaders? = nil
    ) -> Alamofire.DataRequest {
        request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
}