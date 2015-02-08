//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Jacky Poon on 2015-01-03.
//  Copyright (c) 2015 somedev. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskLabel: UITextField!
    
    @IBOutlet weak var subTaskLabel: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var detailTaskModel : TaskModel!
    var mainVC : ViewController!
    
    var completedTask : Bool!
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        //  because there is a navigation controller we can access it
        // to pop the stack.  Other functions are available to navigate to other screens if needed
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskLabel.text = detailTaskModel.task
        subTaskLabel.text = detailTaskModel.subTask
        datePicker.setDate(detailTaskModel.date, animated: true)
        completedTask = detailTaskModel.completed
        //var dateFormatter = NSDateFormatter()
        //dateFormatter.dateFormat = "MM-dd-yyyy"
        
        //var date = dateFormatter.dateFromString(detailTaskModel.date)
        //datePicker.setDate(date!, animated: true)
    }

    @IBAction func doneButtonPressed(sender: UIBarButtonItem)
    {
        var updatedTask = TaskModel(task : taskLabel.text, subTask: subTaskLabel.text, date: datePicker.date, completed: completedTask)
        var currentSelectedRow : Int? = mainVC.tableView.indexPathForSelectedRow()?.row
        var currentSelectedSection : Int? = mainVC.tableView.indexPathForSelectedRow()?.section
        println("Done button pressed for section \(currentSelectedSection) and row \(currentSelectedRow)")
        if (currentSelectedRow != nil && currentSelectedSection != nil)
        {
           // mainVC.taskArray[currentSelectedRow!] = updatedTask
            mainVC.baseArray[currentSelectedSection!][currentSelectedRow!] = updatedTask
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
