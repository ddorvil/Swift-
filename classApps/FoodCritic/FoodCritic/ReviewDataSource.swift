//
//  ReviewDataSource.swift
//  FoodCritic
//
//  Created by CSC214 Instructor on 8/14/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import UIKit
import CoreData

@objcMembers
class ReviewDataSource: NSObject, UICollectionViewDataSource {
        
    dynamic var reviews = [Review]()
    var managedContext: NSManagedObjectContext!
    
    override init() {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            managedContext = context
            let fetchRequest = NSFetchRequest<Review>(entityName: "Review")
            do {
                reviews = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Failed to load persistent data: \(error)")
            }
        }
        super.init()
    }

    func findReview(with uid: String) -> Review? {
        for review in reviews {
            if review.reviewID == uid {
                return review
            }
        }
        return nil
    }
    
    func newReview() -> Review? {
        if let entity = NSEntityDescription.entity(forEntityName: "Review", in: managedContext!) {
            let review = Review(entity: entity, insertInto: managedContext)
            reviews.append(review)
            return review
        }
        return nil
    }
    
    func deleteReview(review: Review) {
        if let index = reviews.firstIndex(of: review) {
            managedContext?.delete(review)
            reviews.remove(at: index)
        }
        save()
    }
    
    func save() {
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Failed to save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewViewCell", for: indexPath) as! ReviewCell
        
        let review = reviews[indexPath.row]
        
        if let imageData = review.image {
            let image = UIImage(data: imageData)
            cell.imageView.image = image
        }
        
        cell.reviewID = review.reviewID
        cell.reviewName.text = review.name
        cell.reviewPrice.text = formatAsCurrency(review.price)

        return cell
    }
}
