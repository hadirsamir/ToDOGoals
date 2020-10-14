//
//  GoalsTableViewCell.swift
//  goalpost-app
//
//  Created by Mac on 10/7/20.
//  Copyright © 2020 Caleb Stultz. All rights reserved.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {
    @IBOutlet weak var  goalDescriptionLabel : UILabel!
    @IBOutlet weak var goalTypeLabel : UILabel!
    @IBOutlet weak var goalProgressAmountLabel : UILabel!
    @IBOutlet weak var completionView : UIView!
    
    func configCell(goal : Goal){
        self.goalTypeLabel.text = goal.goalType
        self.goalDescriptionLabel.text = goal.goalDescription
        self.goalProgressAmountLabel.text = String(goal.goalProgress)
        if goal.goalProgress == goal.goalCompletionValue{
            self.completionView.isHidden = false
        }else{
             self.completionView.isHidden = true
        }
    }
    

}
