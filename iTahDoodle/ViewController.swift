//
//  ViewController.swift
//  iTahDoodle
//
//  Created by Eric Andersen on 7/12/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    let todoList = TodoList()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
        tableView.delegate = self
        
        let cellInfo = todoList.getCellInfo
        tableView.register(cellInfo.cellClass, forCellReuseIdentifier: cellInfo.reuseIdentifier)
        
        tableView.dataSource = todoList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoList.removeItem(indexPath.row)
        itemTextField.text = ""

        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
//        print("Add to-do item: \(itemTextField.text)")
        guard let todo = itemTextField.text else {
            return
        }
        if todo != "" {
            todoList.add(todo)
            itemTextField.text = ""
            tableView.reloadData()
        }
    }
}
