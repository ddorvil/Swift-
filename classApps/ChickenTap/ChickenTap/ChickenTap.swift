//

//   ChickenTap.swift
//   ChickenTap
//
//  Created by: CSC214 Instructor on 9/26/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import Foundation
import UIKit

class ChickenTap {
    
    var secretLocation = CGPoint.zero
    var gameOver = true
    var score = 0

    // MARK: - Game Logic
    
    func startGame(with gameRect: CGRect, chickenSize: CGSize) {        
        secretLocation = CGPoint(x: randomCGFloat(for: gameRect.width - chickenSize.width),
                                 y: randomCGFloat(for: gameRect.height - chickenSize.height))
        secretLocation = secretLocation.offset(dx: chickenSize.width / 2, dy: chickenSize.height / 2)
        gameOver = false
        score = 0
    }

    func tryLocation(_ point: CGPoint) -> (Bool, Int, UIColor) {
        let dist = distance(between: point, and: secretLocation)
        gameOver = dist <= 50.0
        score += 1
        return (gameOver, score, colorForDistance(dist))
    }
    
    // MARK - Utility

    func randomCGFloat(for upperBound: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(upperBound)))
    }

    func distance(between pointA: CGPoint, and pointB: CGPoint) -> CGFloat {
        let x = pow(Double(pointB.x - pointA.x), 2)
        let y = pow(Double(pointB.y - pointA.y), 2)
        return CGFloat((x + y).squareRoot())
    }

    func colorForDistance(_ distance: CGFloat) -> UIColor {
        switch distance {
        case 0..<50:
            return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case 50..<100:
            return UIColor(red: 0.8, green: 0.0, blue: 0.2, alpha: 1.0)
        case 100..<150:
            return UIColor(red: 0.6, green: 0.0, blue: 0.4, alpha: 1.0)
        case 150..<200:
            return UIColor(red: 0.4, green: 0.0, blue: 0.6, alpha: 1.0)
        case 200..<250:
            return UIColor(red: 0.2, green: 0.0, blue: 0.8, alpha: 1.0)
        default: return UIColor.blue
        }
    }
}

// MARK: - CGPoint Extension

extension CGPoint {
    mutating func offset(dx: CGFloat, dy: CGFloat) -> CGPoint {
        x += dx
        y += dy
        return self
    }
}
