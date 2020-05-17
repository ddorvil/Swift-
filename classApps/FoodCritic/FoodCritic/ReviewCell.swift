//
//  ReviewViewCell.swift
//  FoodCritic
//
//  Created by CSC214 Instructor on 8/14/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var reviewName: UILabel!
    @IBOutlet var reviewPrice: UILabel!

    var reviewID: String!
}
