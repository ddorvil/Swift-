//
//  AddItemVC.swift
//  FoodCritic
//
//  Created by CSC214 Instructor on 8/14/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import UIKit

class AddReviewVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceField: UITextField!
    
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var detailsTextView: UITextView!
    
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet var foodImageView: UIImageView!
    
    @IBOutlet weak var addItemBtn: UIButton!
    
    var reviews: ReviewDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageBtn.setTitle(NSLocalizedString("str_addImage", comment: ""), for: .normal)
        nameLabel.text = NSLocalizedString("str_name", comment: "")
        priceLabel.text = NSLocalizedString("str_price", comment: "")
        detailsLabel.text = NSLocalizedString("str_details", comment: "")
        addItemBtn.setTitle(NSLocalizedString("str_addItem", comment: ""), for: .normal)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage  {
            foodImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func onAddItem(_ sender: UIButton) {
        
        if let review = reviews.newReview() {
            review.name = nameField.text!
            review.price = Double(priceField.text!) ?? 0
            review.details = detailsTextView.text!
            
            if let image = foodImageView.image {
                guard let imageData = image.jpegData(compressionQuality: 1) else {
                    print("UIImageJPEGRepresentation Error")
                    return
                }
                review.image = imageData
            } else {
                review.image = UIImage(named: "placeholder")!.jpegData(compressionQuality: 1)
            }
            reviews.save()
            
            let alert = UIAlertController(title: NSLocalizedString("str_done", comment: ""),
                                          message: NSLocalizedString("str_reviewWasSaved", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("str_ok", comment: ""), style: .default))
            
            present(alert, animated: true)
        } else {
            print("Couldn't add item!")
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onCameraBtn(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
            ? .camera
            : .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
}
