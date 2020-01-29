//
//  File.swift
//  
//
//  Created by jingjing on 1/29/20.
//

import UIKit

private var viewIndicators: [UIView: UIActivityIndicatorView] = [:]

extension UIActivityIndicatorView.Style {
    public static var defaultStyle: UIActivityIndicatorView.Style {
        if #available(iOS 13.0, *) {
            return .medium
        } else {
            return .gray
        }
    }
}

extension UIView {
    public func showActivityIndicator(style: UIActivityIndicatorView.Style = .defaultStyle, center: CGPoint? = nil) {
        if let activityIndicator = viewIndicators[self] {
            activityIndicator.startAnimating()
        } else {
            let activityIndicator = UIActivityIndicatorView(style: style)
            if let center = center {
                activityIndicator.center = center
            } else if let scrollView = self as? UIScrollView {
                activityIndicator.center = CGPoint(x: frame.width / 2, y: (frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom) / 2)
            } else {
                activityIndicator.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
            }
            activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
            viewIndicators[self] = activityIndicator
            addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }

    public func hideActivityIndicator() {
        guard let activityIndicator = viewIndicators[self], activityIndicator.superview == self else { return }

        viewIndicators.removeValue(forKey: self)
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    public var isActivityIndicatorAnimating: Bool {
        guard let activityIndicator = viewIndicators[self], activityIndicator.superview == self else { return false }

        return activityIndicator.isAnimating
    }

    public func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.flatMap { $0.superview(of: type) }
    }

    public func subview<T>(of type: T.Type) -> T? {
        if self is T {
            return self as? T
        }

        return subviews.compactMap { $0.subview(of: type) }.first
    }

    public func fadeIn(from fromAlpha: CGFloat = 0, to toAlpha: CGFloat = 1, completion: ((_ finished: Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }

        alpha = fromAlpha
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = toAlpha
        }, completion: completion)
    }

    public func fadeIn(withDuration duration: TimeInterval, completion: ((_ finished: Bool) -> Void)?) {
        if isHidden {
            isHidden = false
        }

        alpha = 0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }

    public func fadeOut(to alpha: CGFloat = 0, completion: ((_ finished: Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = alpha
        }, completion: { finished in
            if self.alpha == 0 {
                self.isHidden = true
            }
            if completion != nil {
                completion!(finished)
            }
        })
    }

    public func fadeOut(withDuration duration: TimeInterval, completion: ((_ finished: Bool) -> Void)?) {
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction], animations: {
            self.alpha = 0
        }, completion: { finished in
            if self.alpha == 0 {
                self.isHidden = true
            }
            completion?(finished)
        })
    }

    @discardableResult public func addTopSeparator(color: UIColor, leadingMargin: CGFloat = 0, trailingMargin: CGFloat = 0, height: CGFloat = 0.5) -> UIView {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = color
        addSubview(separator)

        let views = ["separator": separator]
        NSLayoutConstraint.constraints(withVisualFormat: "|-\(leadingMargin)-[separator]-\(trailingMargin)-|", options: [], metrics: nil, views: views).forEach { $0.isActive = true }
        NSLayoutConstraint.constraints(withVisualFormat: "V:|[separator(\(height))]", options: [], metrics: nil, views: views).forEach { $0.isActive = true }
        return separator
    }

    @discardableResult public func addBottomSeparator(color: UIColor, leadingMargin: CGFloat = 0, trailingMargin: CGFloat = 0, height: CGFloat = 0.5) -> UIView {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = color
        addSubview(separator)

        let views = ["separator": separator]
        NSLayoutConstraint.constraints(withVisualFormat: "|-\(leadingMargin)-[separator]-\(trailingMargin)-|", options: [], metrics: nil, views: views).forEach { $0.isActive = true }
        NSLayoutConstraint.constraints(withVisualFormat: "V:[separator(\(height))]|", options: [], metrics: nil, views: views).forEach { $0.isActive = true }
        return separator
    }
}
