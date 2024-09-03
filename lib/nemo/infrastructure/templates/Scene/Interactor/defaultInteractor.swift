import Foundation
import Alamofire

protocol <%= @scene_name %>InteractorProtocol {
    func getLatestLaunch() async throws -> LaunchResponse
}

final class <%= @scene_name %>Interactor: <%= @scene_name %>InteractorProtocol, @unchecked Sendable {
    private let networkManager: any NetworkManagerProtocol

    init(networkManager: some NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func getLatestLaunch() async throws -> LaunchResponse {
        let task = networkManager.request(
            Constants.API.latestLaunch,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default
            //headers: Headers.headerWithToken
        ).serializingDecodable(LaunchResponse.self)
        return try await task.value
    }
}
