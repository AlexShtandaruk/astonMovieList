import UIKit

public class CoreAnimation {
    
    public init() {}
    
    public func basicButtonAnimation(_ button: UIButton) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.1,
            options: .curveEaseIn,
            animations: { button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    usingSpringWithDamping: 0.1,
                    initialSpringVelocity: 2,
                    options: .curveEaseIn,
                    animations: { button.transform = CGAffineTransform(scaleX: 1, y: 1) },
                    completion: nil
                )
        })
    }
}
