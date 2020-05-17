//
//  ViewController.swift
//  ChickenTap
//
//  Created by CSC214 Instructor on 9/26/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chickenImageView: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var scoreDescLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let chickenTap = ChickenTap()
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn?.setTitle(NSLocalizedString("str_start", comment: ""), for: .normal)
        scoreDescLabel?.text = NSLocalizedString("str_score", comment: "")
        scoreLabel?.text = String(describing: chickenTap.score)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        chickenTap.gameOver = true
        handleGameOver()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    // MARK: - Utility
    
    func handleGameOver() {
        chickenImageView?.isHidden = false
        startBtn?.isHidden = false
    }
    
    // MARK: - Actions
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        if chickenTap.gameOver { return }
        
        let point = sender.location(in: self.view)
        let (gameOver, score, backgroundColor) = chickenTap.tryLocation(point)
        view.backgroundColor = backgroundColor
        scoreLabel?.text = String(describing: score)
        if gameOver == true {
            handleGameOver()
        }
    }

    @IBAction func onStartBtn(_ sender: UIButton) {
        view.backgroundColor = .blue
        chickenTap.startGame(with: self.view.frame, chickenSize: chickenImageView?.frame.size ?? CGSize.zero)
        chickenImageView?.center = chickenTap.secretLocation
        chickenImageView?.isHidden = true
        startBtn?.isHidden = true
    }
}
