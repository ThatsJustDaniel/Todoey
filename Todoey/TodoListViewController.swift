//
//  ViewController.swift
//  Todoey
//
//  Created by Daniel Ortiz on 12/20/18.
//  Copyright © 2018 Daniel Ortiz. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find mike", "Buy Eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            
            itemArray = items
        }
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

        
    }

    // Mark - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the add item button on our UIAlert
            
            self.itemArray.append(textField.text!)
            
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

