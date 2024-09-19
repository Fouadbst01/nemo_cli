import Foundation
import XCTest

class MockURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    static var shouldFail = false
    static var requestHandler: ( (URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override func startLoading() {
        if MockURLProtocol.shouldFail {
            let error = NSError(domain: "com.MovieApp", code: 42)
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("No request handler provided.")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            XCTFail("Error handling the request: \(error)")
        }
    }
    
    override func stopLoading() {}
}