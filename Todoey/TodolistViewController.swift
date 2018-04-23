//
//  ViewController.swift
//  Todoey
//
//  Created by Tart Labs on 22/04/18.
//  Copyright © 2018 Tart Labs. All rights reserved.
//

import UIKit

class TodolistViewController: UITableViewController {
    
    let itemArray = ["Find Mike","Buy Egos","Destroy Demodorgon"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Mark TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK -> TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
