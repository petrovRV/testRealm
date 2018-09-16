//
//  ViewController.swift
//  testRealm
//
//  Created by Mac on 9/16/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController {
    
    let cellId = "cellId"
    var categoryList: Results<Category>?
    
    let table = UITableView()
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        prepareTable()
        prepareUI()
        
    }
    
    private func prepareTable() {
    
        view.addSubview(table)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        table.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        table.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        table.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        table.dataSource = self
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    private func prepareUI() {
        let button = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func addItem() {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            guard let text = textField.text else { return }
            
            let newCategory = Category()
            newCategory.name = text
            self.save(category: newCategory)
            
        }
    
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    private func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category: \(error)")
        }
        
        table.reloadData()
        
    }
    
    private func loadCategories() {
        
        categoryList = realm.objects(Category.self)
        
        table.reloadData()
        
    }


}

//MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = categoryList?[indexPath.row].name ?? "No Categories Added yet"
        return cell
    }
    
    
}
