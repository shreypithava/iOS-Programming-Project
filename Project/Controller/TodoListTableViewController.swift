//
//  TodoListTableViewController.swift
//  Project
//
//  Created by Shrey Pithava on 5/2/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import CoreData

class TodoListTableViewController: UITableViewController {
    
    var allItems = [Item]()
    var defaults = UserDefaults.standard
    var uncheckedItem = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categorySelected : Category? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.bool(forKey: "ListArray") as? Bool {
            uncheckedItem = item
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allItems.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)

        // Configure the cell...
        
        let item = allItems[indexPath.row]
        
        cell.textLabel?.text = item.itemName
        
        cell.accessoryType = item.status ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        allItems[indexPath.row].status = !allItems[indexPath.row].status
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.itemName = textField.text!
            newItem.status = false
            newItem.toCategory = self.categorySelected
            
            self.allItems.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "Add Item here"
            textField = alerttextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        do {
            try context.save()
            saveUserDefaults()
        } catch {
            print("Save error \n\(error)\n")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()

        request.predicate = NSPredicate(format: "toCategory.categoryName MATCHES %@", categorySelected!.categoryName!)
        
        do {
            allItems = try context.fetch(request)
        } catch {
            print("Load error \n\(error)\n")
        }
        saveUserDefaults()
        tableView.reloadData()
    }
    
    func checkForUncheck() -> Bool {
        for items in allItems {
            if !items.status {
                return false
            }
        }
        return true
    }
    
    func saveUserDefaults() {
        
        uncheckedItem = checkForUncheck()
        defaults.set(uncheckedItem, forKey: "ListArray")
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
