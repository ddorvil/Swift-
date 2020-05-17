//
//  ViewController.swift
//  FoodCritic
//
//  Created by CSC214 Instructor on 8/14/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var numReviewsLabel: UILabel!

    let reviewDataSource = ReviewDataSource()

    var reviewsObservation: NSKeyValueObservation!

    func updateStats() {
        OperationQueue.main.addOperation {
            let reviewsString = NSLocalizedString("str_reviews", comment: "") + ": " + self.reviewDataSource.reviews.count.description
            self.numReviewsLabel.text = reviewsString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = reviewDataSource
        reviewsObservation = reviewDataSource.observe(\.reviews, options: [.initial, .new]) { [unowned self] object, changes in
            self.updateStats()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Navigation
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditReviewSegue" {
            let newReviewVC = segue.destination as! AddReviewVC
            newReviewVC.reviews = reviewDataSource
        } else if segue.identifier == "ViewReviewSegue" {
            
            if let reviewDetailVC = segue.destination as? ReviewDetailVC {
                
                reviewDetailVC.delegate = self
                
                if let idx = collectionView.indexPathsForSelectedItems?.first,
                    let cell = collectionView.cellForItem(at: idx) as? ReviewCell,
                    let review = reviewDataSource.findReview(with: cell.reviewID) {
                    reviewDetailVC.currentReview = review
                }
            }
        }
    }
}

extension ViewController: ReviewDetailDelegate {
    
    func deleteReview(review: Review) {
        reviewDataSource.deleteReview(review: review)
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
}

