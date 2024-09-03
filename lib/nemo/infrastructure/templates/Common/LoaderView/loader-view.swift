import UIKit

class LoaderView: UIView {
    
    public let activityIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()
        return loadingIndicator
    }()
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        var constraints = [NSLayoutConstraint]()
        self.backgroundColor = .white
        self.addSubview(activityIndicator)
        
        constraints.append(activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}