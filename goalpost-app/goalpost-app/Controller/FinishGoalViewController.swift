//
//  FinishGoalViewController.swift
//  goalpost-app
//
//  Created by Mac on 10/12/20.
//  Copyright © 2020 Caleb Stultz. All rights reserved.
//

import UIKit

class FinishGoalViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var createGoalBtn : UIButton!
    @IBOutlet weak var goalCountTextField : UITextField!
    var goalDescription : String!
    var goalType : GoalType!
    
    func initGoalData(description: String , goalType : GoalType){
        self.goalType = goalType
        self.goalDescription = description
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindKeyBoard()
        self.goalCountTextField.delegate = self
    }
    
    @IBAction func createGoal(){
        // pass data to create goal
        if goalCountTextField.text != ""{
            self.save { (complete) in
                if complete{
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        
    }
    @IBAction func backBtn(){
        dismissDetails(viewController: self)
    }
    func save (completion:(_ finished : Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        // create object of goal and it the managed context
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(goalCountTextField.text!)!
        goal.goalProgress = Int32(0)
        do{
            try managedContext.save()
            
            print("successfully saved")
            completion(true)
        }catch{
            debugPrint("couldn't save : \(error.localizedDescription)")
            completion(false)
        }
    }
}
