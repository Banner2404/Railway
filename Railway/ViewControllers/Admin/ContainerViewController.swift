//
//  ContainerViewController.swift
//  Spinn.coffee
//
//  Created by Insoft on 5/16/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol ContainerViewController {

    func move(from fromViewController: NSViewController, to toViewController: NSViewController, inContainerView containerView: NSView)

    func show(_ viewController: NSViewController, inContainerView containerView: NSView)
    func removeViewControllerFromContainerView(_ viewController: NSViewController?)

}

extension ContainerViewController where Self: NSViewController {
    
    func move(from fromViewController: NSViewController, to toViewController: NSViewController, inContainerView containerView: NSView) {
        addChildViewController(toViewController)
        
        let fromView = fromViewController.view
        let toView = toViewController.view
        
        toView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(toView)
        containerView.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: toView.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: toView.rightAnchor).isActive = true
        
        fromView.removeFromSuperview()
        fromViewController.removeFromParentViewController()
    }
    
    func show(_ viewController: NSViewController, inContainerView containerView: NSView) {
        addChildViewController(viewController)
        let childView = viewController.view
        
        containerView.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: childView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: childView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: childView.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: childView.bottomAnchor).isActive = true
    }
    
    func removeViewControllerFromContainerView(_ viewController: NSViewController?) {
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParentViewController()
        
    }
}
