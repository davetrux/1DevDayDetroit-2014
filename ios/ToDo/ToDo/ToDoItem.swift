//
//  ToDoItem.swift
//  ToDo
//
//  Created by David Truxall on 11/10/14.
//  Copyright (c) 2014 Hewlett-Packard Company. All rights reserved.
//

import Foundation
import CoreData

class ToDoItem: NSManagedObject {

    @NSManaged var itemName: String
    @NSManaged var due: NSDate

}
