//
//  ViewController.swift
//  TodoApp
//
//  Created by Ravi Tripathi on 12/02/18.
//  Copyright © 2018 Ravi Tripathi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    //MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        print("1: viewWillAppear: Disappeared -> Appearing or Disappearing -> Appearing")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("1: viewDidAppear: Appearing -> Appeared")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("1: viewWillDisappear: Appeared -> Disappearing or Appearing -> Disappearing")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("1: viewDidDisappear: Disappearing -> Disappeared")
    }
    
    
    override func viewDidLoad() {
        print("1: viewDidLoad")
        super.viewDidLoad()
        loadItems()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        //Causes the cell to be re-used. Retains the property
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        //Checks cell based on property
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK: -  TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Inverts selections
        itemArray[indexPath.row].done  = !itemArray[indexPath.row].done
      
        //Deselects current Item
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveItems()
    }
    
    

//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            // delete item at indexPath
//            self.itemArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            print(self.itemArray)
//            self.saveItems()
//        }
//        let share = UITableViewRowAction(style: .normal, title: "Share") { (action, indexPath) in
//            print("I want to share: \(self.itemArray[indexPath.row])")
//        }
//
//        let meow = UITableViewRowAction(style: .normal, title: "meow") { (action, indexPath) in
//            print("I want to meow: \(self.itemArray[indexPath.row])")
//        }
//
//        share.backgroundColor = UIColor.lightGray
//
//        return [delete,share,meow]
//    }
    
    //for slide options
    //Added in ios 11
    override func tableView(_ tableView: UITableView,
    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
    let closeAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
        self.itemArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
//        print(self.itemArray)
        self.saveItems()
    success(true)
    })
    
    return UISwipeActionsConfiguration(actions: [closeAction])
    
    }
    
    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.editItem(item: self.itemArray[indexPath.row].title, loc: indexPath.row)
            success(true)
        })
//        modifyAction.image = UIImage(named: "hammer")
//        modifyAction.backgroundColor = .blue
//
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        
        let action = UIAlertAction(title: "Add Item" , style: .default) { (action) in
            //When user clicks add item
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    
    func editItem(item: String, loc: Int){
        let alert = UIAlertController(title: "Edit Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        
        let action = UIAlertAction(title: "Ok" , style: .default) { (action) in
            //When user clicks add item
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.remove(at: loc)
            self.itemArray.insert(newItem, at: loc)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.text = item
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                try itemArray = decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding array")
            }
        }
    }
    
}

