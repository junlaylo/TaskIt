//
//  ViewController.swift
//  TaskIt
//
//  Created by Jacky Poon on 2014-12-27.
//  Copyright (c) 2014 somedev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func AddButtonPressed(sender: UIBarButtonItem)
    {
        println("Add button pressed!")
        performSegueWithIdentifier("showAddTask", sender: self)
    }
    
    //var taskArray : [Dictionary<String, String>] = []
    var notCompletedArray : [TaskModel] = []
    var completedArray : [TaskModel] = []
    
    var baseArray : [[TaskModel]] = []
    
    // called on when it loads the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: Date.from(year: 2014, month: 12, day: 12), completed: false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: Date.from(year: 2015, month: 01, day: 12), completed: false)
        let task3 = TaskModel(task: "Gym", subTask: "Leg Day", date: Date.from(year: 2015, month: 01, day: 01), completed: false)
        
        let task4 = TaskModel(task: "Code", subTask: "Task Project", date: Date.from(year: 2015, month: 01, day: 02), completed: true)
        
        //dictionary is like a hashtable and can be indexed using the key
        /*let task1 : Dictionary<String, String> = ["task" : "Study French", "subtask" : "Verbs", "date":  "12/12/14"]
        let task2 : Dictionary<String, String> = ["task" : "Eat Dinner", "subtask" : "Burgers", "date": "01/01/15"]
        let task3 : Dictionary<String, String> = ["task" : "Gym", "subtask" : "Leg Day", "date": "01/02/15"]
*/
        notCompletedArray = [task1, task2, task3]
        completedArray = [task4]
        baseArray = [notCompletedArray, completedArray]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // refresh the table when view reappears
    override  func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       baseArray[0] = baseArray[0].sorted(sortByDate) // this is a function pointer used to sort and we are passing a date compare to 2 dates
       baseArray[1]  = baseArray[1].sorted(sortByDate)
       // baseArray = [notCompletedArray, completedArray]
        tableView.reloadData()
    }
    
    // need to return the number of sections in the table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    // need to indicae the height of the section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do"
        }
        else {
            return "Completed"
        }
        
        
    }
    
    // detect the editing of rows with a swipe
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        if indexPath.section == 0
        {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true) // create a new task, mark it as completed
            baseArray[indexPath.section].removeAtIndex(indexPath.row)
            baseArray[1].append(newTask)
        }
        else
        {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false) // create a new task, mark it as completed
            baseArray[indexPath.section].removeAtIndex(indexPath.row)
            baseArray[0].append(newTask)
            
        }
        
        baseArray[0] = baseArray[0].sorted(sortByDate) // this is a function pointer used to sort and we are passing a date compare to 2 dates
        baseArray[1]  = baseArray[1].sorted(sortByDate)
        
        tableView.reloadData()
    }
    
    // table view data source - returns the number of rows based on the current section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // it appears in ios8 that when it detects the count has changed tht it does a redraw
        return baseArray[section].count // return the number of elements in the section
    }

    // called when redrawing the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        println("Selected Section \(indexPath.section) and Selected Row \(indexPath.row)")
        let currentItem : TaskModel = baseArray[indexPath.section][indexPath.row]
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell // the class representing the cel is configured in the storyboard
        cell.dateLabel.text = Date.toString(date: currentItem.date)
        cell.taskLabel.text = currentItem.task
        cell.subtaskLabel.text = currentItem.subTask
        return cell
    }
    
    // table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println("A row is selected \(indexPath.row) in section \(indexPath.section)")
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showTaskDetail")
        {
            var detailVC : TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            var currentIndexPath = tableView.indexPathForSelectedRow()
            var currentModel = baseArray[currentIndexPath!.section][currentIndexPath!.row]
            // pass the data model into the controller.  Cannot manipulate UI at this point directly using UI elements because view not created
            detailVC.detailTaskModel = currentModel
            detailVC.mainVC = self
        }
        else if (segue.identifier == "showAddTask")
        {
            var addTaskVC : AddTaskViewController = segue.destinationViewController as AddTaskViewController
            // used as an easy way to access variables in the main vc... but there are other ways of passing
            // data around
            addTaskVC.mainVC = self
        }
    }
    
    func sortByDate(taskOne: TaskModel, taskTwo: TaskModel) -> Bool {
        if (taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970) {
            return true
        }
        return false
    }

}

