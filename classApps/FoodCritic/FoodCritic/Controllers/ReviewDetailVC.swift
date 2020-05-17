//
//  ReviewDetailVC.swift
//  FoodCritic
//
//  Created by CSC214 Instructor on 8/14/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import UIKit

protocol ReviewDetailDelegate: class {
    func deleteReview(review: Review)
}

class ReviewDetailVC: UIViewController {
    
    @IBOutlet weak var reviewID: UILabel!
    @IBOutlet weak var reviewTextField: UITextView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceField: UITextField!
    
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    weak var delegate: ReviewDetailDelegate?
    
    var currentReview: Review?
    
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceLabel.text = NSLocalizedString("str_price", comment: "")
        deleteBtn.setTitle(NSLocalizedString("str_delete", comment: ""), for: .normal)
        
        if currentReview != nil {
            
            self.title = currentReview?.name
            reviewID.text = currentReview?.reviewID
            reviewTextField.text = currentReview?.details
            if let p = currentReview?.price {
                priceField.text = formatAsCurrency(p)
            } else {
                priceField.text = formatAsCurrency(0)
            }
            
            if let imageData = currentReview?.image {
                let image = UIImage(data: imageData)
                self.foodImageView.image = image
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func onDelete(_ sender: UIButton) {
        
        self.delegate?.deleteReview(review: self.currentReview!)
        self.navigationController?.popViewController(animated: true)
    }
}
