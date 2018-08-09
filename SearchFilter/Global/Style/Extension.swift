//
//  Extension.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 09/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
