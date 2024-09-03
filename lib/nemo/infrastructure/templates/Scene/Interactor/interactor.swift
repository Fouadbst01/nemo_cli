import Foundation
import Alamofire

protocol <%= @scene_name %>InteractorProtocol {
    // Declare interactor methods
}

final class <%= @scene_name %>Interactor: <%= @scene_name %>InteractorProtocol, @unchecked Sendable {
    private let networkManager: any NetworkManagerProtocol

    init(networkManager: some NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}

