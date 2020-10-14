//
//  ViewControllerExtension.swift
//  goalpost-app
//
//  Created by Mac on 10/11/20.
//  Copyright © 2020 Caleb Stultz. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func showDetails(viewController: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewController, animated: false, completion: nil)
    }
    func presentSecondaryVC(_ presentedVc : UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        guard let presentedViewController = presentedViewController else{return}
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(presentedVc, animated: false, completion: nil)
        }
    }
    func dismissDetails(viewController: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
