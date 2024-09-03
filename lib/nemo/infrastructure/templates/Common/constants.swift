import Foundation

struct Constants {
    //MARK: Endpoints
    struct API {
        static let BASE_URL: String = Bundle.main.infoDictionary!["BASE_URL"] as! String
        // This endpoint is only for example purposes.
        static let latestLaunch = BASE_URL + "launches/latest"
    }
}
