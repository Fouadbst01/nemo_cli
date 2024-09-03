import UIKit


class BaseVC : UIViewController {

    //MARK: Outlets
    @IBOutlet weak var uv_body: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
}

extension BaseVC : ProtocolBaseView {
    @objc
    func updateLoader(isVisible: Bool){
        //dismiss keyBoard before displaying the loader
        dismissMyKeyboard()
        self.uv_body?.displayLoader(showInViewExt: isVisible)
    }

    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}
