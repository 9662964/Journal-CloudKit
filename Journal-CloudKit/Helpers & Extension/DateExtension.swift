//
//  DateExtension.swift
//  Journal-CloudKit
//
//  Created by iljoo Chae on 6/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
extension Date {
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
