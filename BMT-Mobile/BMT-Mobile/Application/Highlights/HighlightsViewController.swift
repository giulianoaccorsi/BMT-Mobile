//
//  HighlightsViewController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 01/10/21.
//


import UIKit

class HighlightsViewController: UIViewController {
    
    let welcomeLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .black
        return text
    }()
    
    let imageLogo: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "bmtImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundLightGray
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner]
        return view
    }()
    
    let controller: HighlightsController = HighlightsController()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var dataSource = HighlightsDataSource(tableView: self.tableView)
    
    var token: String
    
    init(token: String) {
        self.token = token
        self.welcomeLabel.text = "Bem vindo, Giuliano!"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller.getImmobile(token: token)
        tableView.reloadData()
        
    }
}

extension HighlightsViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(imageLogo)
        view.addSubview(welcomeLabel)
        view.addSubview(backgroundView)
        backgroundView.addSubview(tableView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            imageLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageLogo.widthAnchor.constraint(equalToConstant: 85),
            imageLogo.heightAnchor.constraint(equalToConstant: 85),
            
            welcomeLabel.centerYAnchor.constraint(equalTo: imageLogo.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: imageLogo.trailingAnchor, constant: 8),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            backgroundView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8),
            tableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
    }
    
    func setUpAdditionalConfiguration() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        controller.delegate = self
    }
    
    
}

extension HighlightsViewController: HighlightsControllerDelegate {
    func show(immobile: [Immobile]) {
        dataSource.updateImmobileSale(immobiles: immobile)
    }
}
