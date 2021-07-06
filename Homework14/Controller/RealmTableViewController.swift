//
//  RealmTableViewController.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import UIKit
import RealmSwift

class TaskR: Object {
    @objc dynamic var task: String = ""
    @objc dynamic var isCompleted = false
}

class RealmTableViewController: UITableViewController {
    
    private let cellID = "realmCell"
    private var realm: Realm!
    
    private var toDoList: Results<TaskR> {
        get {
            return realm.objects(TaskR.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        realm = try! Realm()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "Realm"
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton(_:)))
    }
    
    @objc func addButton(_ sender: Any) {
        let alertVC = UIAlertController(title: "Новое дело!", message: "Что Вам нужно сделать?", preferredStyle: .alert)
        alertVC.addTextField { (UITextField) in}
        let cancelAction = UIAlertAction.init(title: "Отмена", style: .destructive, handler: nil)
        alertVC.addAction(cancelAction)
        let addAction = UIAlertAction.init(title: "Добавить", style: .default) { (UIAlertAction) -> Void in
            let toDoTextField = (alertVC.textFields?.first)! as UITextField
            let newTask = TaskR()
            newTask.task = toDoTextField.text!
            newTask.isCompleted = false
            try! self.realm.write({
                self.realm.add(newTask)
                self.tableView.insertRows(at: [IndexPath.init(row: self.toDoList.count - 1, section: 0)], with: .automatic)
            })
        }
        alertVC.addAction(addAction)
        present(alertVC, animated: true, completion: nil)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .lightGray
        let currentTask = toDoList[indexPath.row]
        cell.textLabel?.text = currentTask.task
        cell.accessoryType = currentTask.isCompleted == true ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentTask = toDoList[indexPath.row]
            try! self.realm.write({
                self.realm.delete(currentTask)
            })
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentTask = toDoList[indexPath.row]
        try! self.realm.write({
            currentTask.isCompleted = !currentTask.isCompleted
        })
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
