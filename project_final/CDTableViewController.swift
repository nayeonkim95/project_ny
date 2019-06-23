//
//  CDTableViewController.swift
//  
//
//  Created by SWUCOMPUTER on 14/06/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class CDTableViewController: UITableViewController {

    var memo: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // View가 보여질 때 자료를 DB에서 가져오도록 한다
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        let context = self.getContext()
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Memo")
    do {
    memo = try context.fetch(fetchRequest)
    } catch let error as NSError {
    print("Could not fetch. \(error), \(error.userInfo)") }
    self.tableView.reloadData() }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return memo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Memo Cell", for: indexPath) // Configure the cell...
        let memos = memo[indexPath.row]
        var display: String = ""
        if let nameLabel = memos.value(forKey: "name") as? String {
            display = nameLabel }
        if let importantLabel = memos.value(forKey: "important") as? String {
            display = display + " // " + importantLabel
        }
        cell.textLabel?.text = display
        cell.detailTextLabel?.text = memos.value(forKey: "title") as? String
        return cell
    }
    
   
}
