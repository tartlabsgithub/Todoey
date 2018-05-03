//
//  ViewController.swift
//  Todoey
//
//  Created by Tart Labs on 22/04/18.
//  Copyright © 2018 Tart Labs. All rights reserved.
//

import UIKit
import RealmSwift

class TodolistViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory:Category? {
        didSet {
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let request:NSFetchRequest<Item> = Item.fetchRequest()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    //Mark TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    
    //MARK -> TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                    //item.done = !item.done
                }
            }catch {
                print("didselectrow error for realm \(error)")
            }
        }
        
        //        context.delete(itemArray[indexPath.row])
        //        todoItems.remove(at: indexPath.row);
        //        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        //        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch {
                    print("the error was Successfully Prnted \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print(alertTextField.text!)
            print("Now")
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    func loadItems() {
        todoItems =  selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
}

//Search bar methods in Functions
extension TodolistViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
       todoItems =  todoItems?.filter("title Contains[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
        }
    }
}




