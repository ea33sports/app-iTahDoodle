//
//  TodoList.swift
//  iTahDoodle
//
//  Created by Eric Andersen on 7/12/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    private let fileURL: URL = {
        let documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("todolist.items")
    }()
    
    private var items: [String] = []
    
    var getCellInfo: (cellClass: AnyClass, reuseIdentifier: String) {
        return (UITableViewCell.self, "Cell")
    }
    
    override init() {
        super.init()
        loadItems()
    }
    
    func saveItems() {
        let itemsArray = items as NSArray
        
        print("Saving items to \(fileURL)")
        if !itemsArray.write(to: fileURL, atomically: true) {
            print("Could not save to-do list")
        }
    }
    
    func loadItems() {
        if let itemsArray = NSArray(contentsOf: fileURL) as? [String] {
            items = itemsArray
        }
    }
    
    func add(_ item: String) {
        items.append(item)
        saveItems()
    }
    
    func removeItem(_ index: Int) {
        items.remove(at: index)
        saveItems()
    }
    
    func removeItemAtIndex(index: Int) {
        guard items.indices.contains(index) else {
            return
        }
        items.remove(at: index)
        saveItems()
    }
}

extension TodoList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel!.text = item
        
        return cell
    }

}
