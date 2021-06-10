//
//  LoggedViewController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import UIKit

class LoggeViewController: UIViewController {
    
    let controller: LoggedController = LoggedController()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let addImobilleButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "addFull"), for: .selected)
        return button
    }()
    
    let navBar: UIView = {
        let navBar = UIView(frame: .zero)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = UIColor.background2.withAlphaComponent(0.8)
        return navBar
    }()
    
    private lazy var dataSource = LoggedDataSource(tableView: self.tableView)
    
    var token: String
    
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        setUpView()
        self.navigationController?.view.tintColor = .orange
        addImobilleButton.addTarget(self, action: #selector(tappedAdd), for: .touchUpInside)
    }
    
    @objc func tappedAdd() {
        print("clicou")
        let createImmobileViewController = CreateImmobileViewController()
        createImmobileViewController.delegate = self
        present(createImmobileViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller.getImmobile(token: token)
        tableView.reloadData()
        
    }
}

extension LoggeViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(navBar)
        navBar.addSubview(addImobilleButton)
        view.addSubview(tableView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 100),
    
            addImobilleButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -8),
            addImobilleButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8),
            addImobilleButton.heightAnchor.constraint(equalToConstant: 40),
            addImobilleButton.widthAnchor.constraint(equalToConstant: 40),

            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setUpAdditionalConfiguration() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        controller.delegate = self
    }
    
    
}

extension LoggeViewController: LoggedControllerDelegate {
    func show(immobile: [Immobile]) {
        print(immobile.count)
        dataSource.updateImmobile(immobiles: immobile)
    }
}

extension LoggeViewController: CreateImmobileViewControllerDelegate {
    func sucessCreate() {
        controller.getImmobile(token: token)
        tableView.reloadData()
    }
}
