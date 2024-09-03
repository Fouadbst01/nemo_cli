import UIKit

extension UIView {
    private func addLoader(clearBackground: Bool) {
        self.clearLoaders()
        let loader = LoaderView(frame: self.bounds)
        if clearBackground { loader.layer.backgroundColor = UIColor.clear.cgColor }
        loader.fixInView(self)
    }
    
    private func clearLoaders(){
        var loaders = self.subViews(type: LoaderView.self)
        guard loaders.isEmpty else {
            loaders.forEach{ loader in
                loader.removeFromSuperview()
            }
            return loaders.removeAll()
        }
    }
    
    public func displayLoader(showInViewExt isVisible: Bool, clearBackground: Bool = false) {
        isVisible ? addLoader(clearBackground: clearBackground) : self.clearLoaders()
    }
}