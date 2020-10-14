//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Caleb Stultz on 7/31/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit
import CoreData
let appDelegate = UIApplication.shared.delegate as? AppDelegate
class GoalsVC: UIViewController {
    //outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoButton : UIButton!
    @IBOutlet weak var undoMainView : UIView!
    //properties
    var goalsArray:[Goal] = []
    var undoArray : [Goal] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        undoMainView .isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateData()
         tableView.reloadData()
    }
    func updateData(){
        self.fetch { (complete) in
            if complete{
                if goalsArray.count >= 1{
                    self.tableView.isHidden = false
                     
                }
            }else{
                  self.tableView.isHidden = true
            }
        }
    }
    
    func reloadData(){
        if goalsArray.count >= 1{
            self.tableView.isHidden = false
        }else{
            self.tableView.isHidden = true
        }
    }
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("button was pressed")
        guard let goalVcCreator = storyboard?.instantiateViewController(withIdentifier: "CreateGoalViewController") else{
            return
        }
        self.navigationController?.pushViewController(goalVcCreator, animated: true)
    }
    @IBAction func undoAction(){
        self.undoActionData()
        print("\(goalsArray.count)")
        self.updateData()
        self.tableView.reloadData()
       
        self.undoMainView.animHide()
        
    }
    
}
extension GoalsVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let goal = goalsArray[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalsTableViewCell", for: indexPath) as? GoalsTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(goal: goal)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.removeObject(with: indexPath)
            self.undoArray.append(self.goalsArray[indexPath.row])
          //  self.goalsArray.remove(at: indexPath.row)
            self.updateData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.undoMainView.isHidden = false
            
        }
        let addAction = UITableViewRowAction(style: .default, title: "Add 1") { (rowAction, indexPath) in
            self.setProgressForGoal(indexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
        deleteAction.backgroundColor = .red
        addAction.backgroundColor = .orange
        return [deleteAction,addAction]
    }
}

extension GoalsVC{
    func undoActionData(){
       guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
       
        managedContext.undoManager?.undo()
    
    }
    func setProgressForGoal(indexPath : IndexPath){
        // update data
         guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        var chosenGoal = goalsArray[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue{
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        }else{
            return
        }
        do{
            try managedContext.save()
            print("SuccessFully updated")
        }catch{
            debugPrint("\(error.localizedDescription)")
        }
    }
    func removeObject(with indexPath : IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        //undoManager must be created once its deleted
        managedContext.undoManager = UndoManager()
        managedContext.delete(goalsArray[indexPath.row])
        
        do{
            // update managed object after delete
            try managedContext.save()
            print("deleted successfully")
        }catch{
            debugPrint("\(error.localizedDescription)")
        }
    }
    func fetch (completion : (_ completion:Bool  ) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do{
            //fetch return array of goals
            self.goalsArray = try managedContext.fetch(fetchRequest)
            
            completion(true)
        }catch{
            debugPrint("couldn't fetch")
            completion(false)
        }
    }
}

