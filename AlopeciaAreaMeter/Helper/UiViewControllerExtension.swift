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
}

