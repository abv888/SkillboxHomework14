//
//  StartViewController.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "Choose Task"
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

