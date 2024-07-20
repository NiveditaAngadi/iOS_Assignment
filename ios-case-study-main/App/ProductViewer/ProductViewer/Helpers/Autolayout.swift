//
//  Copyright © 2015 Target. All rights reserved.
//

import UIKit

extension CGFloat {
    static var singlePixel: CGFloat { 1 / UIScreen.main.scale }
}

extension UILayoutPriority {
    /// UILayoutPriority.required - 1 (999)
    public static let almostRequired = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
}

extension NSLayoutConstraint {
    /// Useful for setting priority when creating and activating a constraint all at once.
    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

/// All-to-common utility for pinning a subviews edges to it's parentview edges.
public extension UIView {
    /// Prepares the UIView to have constraints added
    func prepareForAutolayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Adds a subview to the superview and constrains the subview's center to the superview's center.
    /// Optionally, when `constrainToEdges` is `true` (the default), this method also constrains the subview
    /// to stay within the superview's edges.
    ///
    /// - Parameters:
    ///   - subview: The subview to add and pin to the superview's center.
    ///   - constrainToEdges: `true` to add constraints to contain the subview within the superview's edges.
    ///     `false` to add your own constraints to avoid an ambiguous layout. Default: `false`.
    func addAndCenterSubview(_ subview: UIView, constrainToEdges: Bool = false) {
        addSubview(subview)
        centerSubview(subview, constrainToEdges: constrainToEdges)
    }
    
    func addAndPinSubview(_ subview: UIView, edges: UIRectEdge = .all, insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        pinSubview(subview, edges: edges, insets: insets)
    }
    
    func pinSubview(_ subview: UIView, edges: UIRectEdge = .all, insets: UIEdgeInsets = .zero) {
        subview.prepareForAutolayout()
        var pin = [NSLayoutConstraint]()
        if edges.contains(.top) {
            pin.append(subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top))
        }
        if edges.contains(.left) {
            pin.append(subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left))
        }
        if edges.contains(.right) {
            pin.append(subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right))
        }
        if edges.contains(.bottom) {
            pin.append(subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom))
        }
        NSLayoutConstraint.activate(pin)
    }
    
    func addAndPinSubviewToMargins(_ subview: UIView, edges: UIRectEdge = .all) {
        addSubview(subview)
        pinSubviewToMargins(subview, edges: edges)
    }
    
    func centerSubview(_ subview: UIView, constrainToEdges: Bool) {
        subview.prepareForAutolayout()
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        if constrainToEdges {
            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
                subview.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                subview.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
                subview.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            ])
        }
    }
    
    func pinSubviewToMargins(_ subview: UIView, edges: UIRectEdge = .all) {
        subview.prepareForAutolayout()
        var pin = [NSLayoutConstraint]()
        if edges.contains(.top) {
            pin.append(subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor))
        }
        if edges.contains(.left) {
            pin.append(subview.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor))
        }
        if edges.contains(.right) {
            pin.append(subview.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor))
        }
        if edges.contains(.bottom) {
            pin.append(subview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor))
        }
        NSLayoutConstraint.activate(pin)
    }
    
    // in case the views are related, but not super/sub views
    func pinView(to view: UIView) {
        view.prepareForAutolayout()
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

extension UIViewController {
    public func pinRootSubview(_ subview: UIView) {
        subview.prepareForAutolayout()
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            subview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            subview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    public func addAndPinRootSubview(_ subview: UIView) {
        view.addSubview(subview)
        pinRootSubview(subview)
    }
}

extension UIView {
    @objc open func height(for width: CGFloat) -> CGFloat {
        // Set width and height to allow aspect ratio to work.
        // Height needs to be a large value or `systemLayoutSizeFitting`
        // can overshoot on height.
        bounds = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: UIView.layoutFittingExpandedSize.height
        )
        
        layoutIfNeeded()
        
        let desiredSize = CGSize(width: width, height: 0)
        
        let size = systemLayoutSizeFitting(
            desiredSize,
            withHorizontalFittingPriority: UILayoutPriority.required,
            verticalFittingPriority: UILayoutPriority.fittingSizeLevel
        )
        
        return size.height
    }
    
    @objc open func width(for height: CGFloat) -> CGFloat {
        bounds = CGRect(x: 0, y: 0, width: UIScreen.main.nativeBounds.width, height: height)
        layoutIfNeeded()
        
        let desiredSize = CGSize(width: 0, height: height)
        let size = systemLayoutSizeFitting(
            desiredSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
        
        return size.width
    }
}
