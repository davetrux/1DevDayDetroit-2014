//
//  ViewController.swift
//  ToDo
//
//  Created by David Truxall on 11/3/14.
//  Copyright (c) 2014 Hewlett-Packard Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var toDoText: UITextField!
    @IBOutlet weak var addToDo: UIButton!
    @IBOutlet weak var toDoList: UITableView?
    
    let cellIdentifier = "cellIdentifier"
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the UITableViewCell class with the tableView
        self.toDoList?.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        // Setup temporary table data
//        for index in 0...100 {
//            self.tableData.append("Item \(index)")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func handleAdd(sender: UIButton) {
        self.toDoText.endEditing(true)
        var newItem = self.toDoText.text
        
        self.toDoText.text = ""
        self.toDoText.endEditing(true)
        
        tableData.append(newItem)
        
        self.toDoList?.reloadData()
    }
    
    // UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        
        cell.textLabel.text = self.tableData[indexPath.row]
        
        return cell
    }
    
    // UITableViewDelegate methods
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
      
        let alert = UIAlertController(title: "Item selected", message: "You selected item \(indexPath.row)", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {
                (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)

        tableData.removeAtIndex(indexPath.row)
        self.toDoList?.reloadData()
    }
}

