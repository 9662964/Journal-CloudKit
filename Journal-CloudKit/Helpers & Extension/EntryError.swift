//
//  EntryError.swift
//  Journal-CloudKit
//
//  Created by iljoo Chae on 6/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "Unable to get this Entry.. "
        }
    }
}
