//
//  Entry.swift
//  Journal-CloudKit
//
//  Created by iljoo Chae on 6/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CloudKit


struct EntryConstants{
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static let recordType = "Entry"
}

class Entry {
    var body: String
    var title: String
    var timestamp: Date
    
    
    init(body: String, title: String, timestamp: Date = Date()) {
        self.body = body
        self.title = title
        self.timestamp = timestamp
    }
}

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.TitleKey] as? String,
        let body = ckRecord[EntryConstants.BodyKey] as? String,
        let timestamp = ckRecord[EntryConstants.TimestampKey] as? Date
                else {return nil}
 
        self.init(body: body, title: title, timestamp: timestamp)
    }
}



extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.recordType)
        self.setValuesForKeys([
            EntryConstants.TitleKey: entry.title,
            EntryConstants.BodyKey: entry.body,
            EntryConstants.TimestampKey: entry.timestamp
        ])
    }
}



