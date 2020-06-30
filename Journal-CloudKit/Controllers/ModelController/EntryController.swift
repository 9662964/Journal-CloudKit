//
//  EntryController.swift
//  Journal-CloudKit
//
//  Created by iljoo Chae on 6/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    //Shared instance
    static let shared = EntryController()
    
    //SOT
    var entries: [Entry] = []
    
    var privateDB = CKContainer.default().privateCloudDatabase
    
    
    func createEntryWith(title: String, body:String, completion: @escaping(Result<Entry,EntryError>) -> Void) {
        
        
        let newEntry = Entry(body: body, title: title)
        let entryRecord = CKRecord(entry: newEntry)
        
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                print("There was an error saving an Entry : \(error) - \(error.localizedDescription)")
                return completion(.failure(.ckError(error)))
            }
            guard let record = record,
                let savedEntry = Entry(ckRecord: record) else {return completion(.failure(.couldNotUnwrap))}
            
                print("Saved Entry Successfully")
            completion(.success(savedEntry))
            
        }
    }
    
    func fetchEntriesWith(completion: @escaping (Result<[Entry]?,EntryError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.recordType, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("There was an error fetching all Entries - \(error) - \(error.localizedDescription)")
                return completion(.failure(.ckError(error)))
                
            }
            
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            print("Fetched Entery successfully")
            
            let fetchedEntries = records.compactMap{Entry(ckRecord: $0)}
            completion(.success(fetchedEntries))
        }
    }
    
    
    
}
