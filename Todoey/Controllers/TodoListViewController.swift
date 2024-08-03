//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    
    var itemArray = ["Find Mike", "Buy eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ UITableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
                return cell
        
    }
    
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemName = itemArray[indexPath.row]
        
        // if selected item is checked, uncheck
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            print("Unchecked \(itemName)")
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            print("Checked \(itemName)")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what will happen once the user clicks the Add Item on our UIAlert
            if let text = textField.text {
                let capitalizedText = text.capitalized //makes sure that entries are uniform
                self.itemArray.append(capitalizedText) //appends to the itemArray
                print("data appended")
                
                //reloads the rows and sections in the tableview
                self.tableView.reloadData()
                
                //adds new entries to the user defaults
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
                print("data reloaded")
            }
        }

        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    
        print("Prompt successful")
    }
    
  
   }
    

