//
//  UiViewControllerExtension.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 18/03/2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    func instantiateViewController<T: UIViewController>(fromNib nibName: String) -> T? {
        let nib = UINib(nibName: nibName, bundle: nil)
        let viewController = nib.instantiate(withOwner: nil, options: nil).first as? T
        return viewController
    }
    
    func navigateToViewController<T: UIViewController>(storyboardName: String, viewControllerIdentifier: String, viewModel: BaseViewModel, configure: @escaping (T, BaseViewModel) -> T?) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerIdentifier) { coder in
            guard let vc = T(coder: coder) else { return nil }
            return configure(vc, viewModel)
        }
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func setRootViewController<T: UIViewController>(storyboardName: String, viewControllerIdentifier: String, viewModel: BaseViewModel, configure: @escaping (T, BaseViewModel) -> T?) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerIdentifier) { coder in
            guard let vc = T(coder: coder) else { return nil }
            return configure(vc, viewModel)
        }
        
        // No need to check if viewController is nil, as it will always return a UIViewController instance
        viewController.modalPresentationStyle = .fullScreen
        
        // Create a new navigation controller with the viewController as root
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // Setting the new navigation controller as the rootViewController of the UIWindow
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            
            // Optional: Animate the transition to the new root view controller
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion: nil)
        }
    }


}

