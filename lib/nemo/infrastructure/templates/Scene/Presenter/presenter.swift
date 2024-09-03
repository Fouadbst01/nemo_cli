import Foundation

protocol <%= @scene_name %>PresenterProtocol {
    func viewDidLoad()
}

final class <%= @scene_name %>Presenter: <%= @scene_name %>PresenterProtocol {
    
    weak var view: <%= @scene_name %>ViewProtocol?
    private let interactor: <%= @scene_name %>InteractorProtocol
    private let router: <%= @scene_name %>RouterProtocol
    
    init(interactor: <%= @scene_name %>InteractorProtocol, router: <%= @scene_name %>RouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    @MainActor
    func viewDidLoad() {
        Task {
            do {
                view?.updateLoader(isVisible: true)
                // call ur interactor to get data 
            } catch {
                view?.updateLoader(isVisible: false)
            }
        }
    }
}