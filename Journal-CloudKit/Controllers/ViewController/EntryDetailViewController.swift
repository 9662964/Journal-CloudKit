//
//  EntryDetailViewController.swift
//  Journal-CloudKit
//
//  Created by iljoo Chae on 6/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry? {
        didSet {
            updateViews()
            loadViewIfNeeded()
        }
    }
    
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
    }
    
    func updateViews() {
        if let entry = entry {
            titleTextField.text = entry.title
            bodyTextView.text = entry.body
        }
    }
    
    
    @IBAction func mainViewTapped(_ sender: Any) {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
    
    @IBAction func clearBtnTapped(_ sender: Any) {
        bodyTextView.text = ""
        titleTextField.text = ""
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        guard let title = titleTextField.text,!title.isEmpty else {return}
        guard let body = bodyTextView.text,!body.isEmpty else {return}
        
        EntryController.shared.createEntryWith(title: title, body: body) {(result) in
            switch result {
            case .success(let entry):
                EntryController.shared.entries.insert(entry, at: 0)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print(error.errorDescription)
                
                
            }
            
        }
        
    }
    
    
}



extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


