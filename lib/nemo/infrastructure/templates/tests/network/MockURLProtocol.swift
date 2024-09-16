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
        
        guard MockURLProtocol.requestHandler != nil else {
            XCTFail("No request handler provided.")
            return
        }

        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}