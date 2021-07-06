//
//  StartViewController.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - View controllers
    
    let userDefaultsVC = UserDefaultsViewController()
    let realmVC = RealmTableViewController()
    let coreDataVC = CoreDataTableViewController()
    let weatherVC = WeatherTableViewController()
    
    // MARK: - View elements
    
    private let taskChoosingStackView = UIStackView()
    private let userDefaultsButton = UIButton()
    private let realmButton = UIButton()
    private let coreDataButton = UIButton()
    private let weatherButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        setupButtons(buttons: [userDefaultsButton,
                               realmButton,
                               coreDataButton,
                               weatherButton])
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "Choose Task"
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupButtons(buttons: [UIButton]) {
        let buttonNamesArray = ["UserDefaults",
                                "Realm",
                                "CoreData",
                                "Weather"]
        view.addSubview(taskChoosingStackView)
        taskChoosingStackView.translatesAutoresizingMaskIntoConstraints = false
        taskChoosingStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        taskChoosingStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        taskChoosingStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        taskChoosingStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        taskChoosingStackView.axis = .vertical
        taskChoosingStackView.distribution = .fillEqually
        taskChoosingStackView.spacing = 10
        taskChoosingStackView.backgroundColor = .lightGray
        for (index, button) in buttons.enumerated() {
            button.setTitle(buttonNamesArray[index], for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .darkGray
            button.layer.cornerRadius = 40
            button.tag = index
            button.addTarget(self, action: #selector(pushToControllers(sender:)), for: .touchUpInside)
            taskChoosingStackView.addArrangedSubview(button)
        }
    }
    
    @objc func pushToControllers(sender: UIButton!) {
        switch sender.tag {
        case 0:
            navigationController?.pushViewController(userDefaultsVC, animated: true)
        case 1:
            navigationController?.pushViewController(realmVC, animated: true)
        case 2:
            navigationController?.pushViewController(coreDataVC, animated: true)
        case 3:
            navigationController?.pushViewController(weatherVC, animated: true)
        default:
            return
        }
    }
    
}

