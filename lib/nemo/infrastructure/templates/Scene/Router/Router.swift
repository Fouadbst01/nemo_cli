import Foundation

protocol  <%= @scene_name %>RouterProtocol {
    func navigateToNewScene()
}

final class  <%= @scene_name %>Router: BaseRouter,  <%= @scene_name %>RouterProtocol {

    func navigateToNewScene() {
//        let someVC = DependencyContainer.shared.makeSomeViewController()
//        push(someVC)
    }
}
