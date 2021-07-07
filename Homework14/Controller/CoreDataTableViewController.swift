//
//  CoreDataTableViewController.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import UIKit

class CoreDataTableViewController: UITableViewController {
    
    private let coreDataManager: CoreDataManagerProtocol = CoreDataManager()
    
    private let cellID = "CoreDataCell"
    private var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tasks = coreDataManager.load()
        tableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "CoreData"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskButton))
    }
    
    @objc func addTaskButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Новое дело!", message: "Что Вам нужно сделать?", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Отмена", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        let addAction = UIAlertAction.init(title: "Добавить", style: .default) { (UIAlertAction) -> Void in
            let toDoTextField = (alertController.textFields?.first)! as UITextField
            let newTask = Task(context: CoreDataManager.shared.context)
            newTask.text = toDoTextField.text!
            self.tasks.append(newTask)
            self.coreDataManager.save()
            self.tableView.reloadData()
        }
        alertController.addTextField { _ in}
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .lightGray
        let newTask2 = tasks[indexPath.row]
        cell.textLabel?.text = newTask2.text
        cell.accessoryType = newTask2.isCompleted ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        tasks[indexPath.row].isCompleted = !tasks[indexPath.row].isCompleted
        coreDataManager.save()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let item = tasks[indexPath.row]
            tasks.remove(at: indexPath.row)
            coreDataManager.remove(task: item)
            coreDataManager.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
}
