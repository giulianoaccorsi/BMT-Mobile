//
//  ViewController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 22/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .black
        button.setTitle("Começar!", for: .normal)
        return button
    }()
    
    let imageLogo: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "BMT-Mobile")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let backgroundUIImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "giuphone_giu")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.view.backgroundColor = .background
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func buttonTapped() {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    
}

extension HomeViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(backgroundUIImageView)
        view.addSubview(loginButton)
        view.addSubview(imageLogo)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundUIImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundUIImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -16),
            imageLogo.widthAnchor.constraint(equalToConstant: 250),
            imageLogo.heightAnchor.constraint(equalToConstant: 250),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setUpAdditionalConfiguration() {
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    
}

