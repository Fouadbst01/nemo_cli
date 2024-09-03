import UIKit

protocol <%= @scene_name %>ViewProtocol: ProtocolBaseView {
    func launchRetrieved(launch: LaunchViewModel)
}

class <%= @scene_name %>ViewController: BaseVC {

    //MARK: Outlets
    @IBOutlet weak var ul_launchDate: UITextField!
    @IBOutlet weak var ul_launchName: UITextField!

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
    func launchRetrieved(launch: LaunchViewModel) {
        ul_launchDate.text = launch.dateLocal
        ul_launchName.text = launch.name
    }
}