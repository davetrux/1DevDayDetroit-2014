//
//  ViewController.swift
//  ToDo
//
//  Created by David Truxall on 11/3/14.
//  Copyright (c) 2014 Hewlett-Packard Company. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var toDoText: UITextField!
    @IBOutlet weak var addToDo: UIButton!
    
    @IBOutlet weak var toDoList: UITableView!
    
    let cellIdentifier = "cellIdentifier"
    
 
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the UITableViewCell class with the tableView
        self.toDoList?.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
    
    func fetch() -> [ToDoItem] {
        let fetchRequest = NSFetchRequest(entityName: "ToDoItem")
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ToDoItem] {
            
            return fetchResults
        } else {
            return [ToDoItem]()
        }
    }
    
    @IBAction func handleAdd(sender: UIButton) {
        self.toDoText.endEditing(true)
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("ToDoItem", inManagedObjectContext: self.managedObjectContext!) as ToDoItem

        newItem.itemName = self.toDoText.text

        self.toDoText.text = ""
        self.toDoText.endEditing(true)
        
        self.save()
        
        self.toDoList?.reloadData()
    }
    
    // UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchResults = self.fetch()
        return fetchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell

        let fetchResults = self.fetch()
        
        if fetchResults.count > 0 {
            
            cell.textLabel.text = fetchResults[indexPath.row].itemName
            
        }
        
        return cell
    }
    
    // UITableViewDelegate methods
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {


        let fetchResults = self.fetch()
        
        if fetchResults.count > 0 {
            let itemToDelete = fetchResults[indexPath.row]
            
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(itemToDelete)
            self.save()
        }

        self.toDoList?.reloadData()
    }
}

