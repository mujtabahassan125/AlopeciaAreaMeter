//
//  SideMenuPresentationController.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 24/03/2024.
//

import UIKit

class SideMenuPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        
        let frame = CGRect(x: containerView.bounds.width / 2, y: 0, width: containerView.bounds.width / 2, height: containerView.bounds.height)
        return frame
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView, let presentedView = presentedView else { return }
        
        containerView.addSubview(presentedView)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let presentedView = presentedView else { return }
        
        presentedView.removeFromSuperview()
    }
}
