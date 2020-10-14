//
//  UIExtension.swift
//  goalpost-app
//
//  Created by Mac on 10/12/20.
//  Copyright © 2020 Caleb Stultz. All rights reserved.
//

import Foundation
import UIKit
// function to bind button above keyboard
extension UIView{
    func bindKeyBoard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChangePosition(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
    }
    
    
    @objc func keyBoardWillChangePosition(notification : NSNotification){
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        // speed of animation
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        // deltaY is the diff between the startind and end of keyboard frame
        let deltaY = endingFrame.origin.y - startingFrame.origin.y
        UIView.animate(withDuration: duration,delay: 0.0,options: UIViewAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
    // hide view
    func animHide(){
           UIView.animate(withDuration: 0.6, delay: 0, options: [.curveLinear],
                          animations: {
                           self.center.y += 200
                           self.layoutIfNeeded()

           },  completion: {(_ completed: Bool) -> Void in
           self.isHidden = true
               })
       }
    //show view
    func animShowView(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= 200
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
}
extension UIButton{
    func btnSelected(){
        self.backgroundColor = UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)
    }
    
    func btnDeselected(){
        self.backgroundColor = UIColor(red: 178/255, green: 221/255, blue: 175/255, alpha: 1)
    }
}
