//
//  EntryListTableViewController.swift
//  Journal-CloudKit
//
//  Created by iljoo Chae on 6/29/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
   

    @IBAction func addBtnTapped(_ sender: Any) {
        
        
    }
    // MARK: - Table view data source

    
    func loadData() {
        EntryController.shared.fetchEntriesWith { (result) in
            switch result {
             case .success(let entries):
                EntryController.shared.entries = entries ?? []
                self.updateViews()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]

        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.dateAsString()
        
        return cell
    }
    



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //identifier
        if segue.identifier == "toDetailView" {
            guard let index = tableView.indexPathForSelectedRow else {return}
            let destinationVC = segue.destination as? EntryDetailViewController
            let entry = EntryController.shared.entries[index.row]
            destinationVC?.entry = entry
        }
    }
    

}
