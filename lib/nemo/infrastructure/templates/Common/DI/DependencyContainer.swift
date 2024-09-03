import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    func makeNemoViewController() -> NemoViewController {
        let interactor = NemoInteractor()
        let router = NemoRouter()
        let presenter = NemoPresenter(interactor: interactor, router: router)
        let viewController = NemoViewController(presenter: presenter)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }
}