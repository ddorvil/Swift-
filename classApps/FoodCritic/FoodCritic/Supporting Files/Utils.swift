//
//   Utils.swift
//   ForSale
//
//  Created by: CSC214 Instructor on 11/12/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import Foundation

func formatAsCurrency(_ price: Double) -> String {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD"
    return formatter.string(from: NSNumber(value: price)) ?? ""
}

