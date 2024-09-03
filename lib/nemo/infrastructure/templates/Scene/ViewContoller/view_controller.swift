import UIKit

protocol <%= @scene_name %>ViewProtocol: ProtocolBaseView {
    // Interface for updating the view
}

class <%= @scene_name %>ViewController: BaseVC {

    //MARK: Properties
    private var presenter: <%= @scene_name %>Presenter!

    init(presenter: <%= @scene_name %>Presenter) {
        self.presenter = presenter
        super.init(nibName: "<%= @scene_name %>ViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension <%= @scene_name %>ViewController: <%= @scene_name %>ViewProtocol {
    
}