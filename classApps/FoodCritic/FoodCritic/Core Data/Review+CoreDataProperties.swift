//

//   Review+CoreDataProperties.swift
//   FoodCritic
//
//  Created by: CSC214 Instructor on 12/9/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var details: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var reviewID: String?
}
