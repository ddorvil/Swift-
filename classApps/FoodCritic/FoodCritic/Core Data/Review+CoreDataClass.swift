//

//   Review+CoreDataClass.swift
//   FoodCritic
//
//  Created by: CSC214 Instructor on 12/9/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Review)
public class Review: NSManagedObject {

    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        if reviewID == nil {
            reviewID = UUID().uuidString
        }
    }
}
