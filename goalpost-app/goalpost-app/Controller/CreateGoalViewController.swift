//
//  CreateGoalViewController.swift
//  goalpost-app
//
//  Created by Mac on 10/11/20.
//  Copyright © 2020 Caleb Stultz. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var goalTxtView: UITextView!
    @IBOutlet weak var longTermBtn : UIButton!
    @IBOutlet weak var shortTermBtn : UIButton!
     @IBOutlet weak var nextBtn : UIButton!
    var goalType : GoalType = .shortTerm
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindKeyBoard()
        shortTermBtn.btnSelected()
        longTermBtn.btnDeselected()
        self.goalTxtView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func longTermPressed(){
         longTermBtn.btnSelected()
         shortTermBtn.btnDeselected()
        goalType = .longTerm
    }
    @IBAction func shortTermPressed(){
        shortTermBtn.btnSelected()
        longTermBtn.btnDeselected()
        goalType = .shortTerm
    }
    @IBAction func nextBtnPressed(){
        if goalTxtView.text != "" && goalTxtView.text != "What is your goal?"{
            guard let FinshGoalVc = storyboard?.instantiateViewController(withIdentifier: "FinishGoalViewController") as? FinishGoalViewController else{
                return
            }
            FinshGoalVc.initGoalData(description: self.goalTxtView.text, goalType: self.goalType)
            // present vc from the first vc by dissmissing th in between VC
            //presentingViewController?.presentSecondaryVC(FinshGoalVc)
            self.navigationController?.pushViewController(FinshGoalVc, animated: true)
        }
    }
    @IBAction func backBtnPressed(){
        self.dismissDetails(viewController: self)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
       func textViewDidBeginEditing(_ textView: UITextView) {
            goalTxtView.text = "" //clear previous txt
            goalTxtView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //color black
        }
    }
}
