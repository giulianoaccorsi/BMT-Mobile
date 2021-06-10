//
//  FortgotPasswordViewController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 27/05/21.
//

import UIKit
import FormTextField

class FortgotPasswordViewController: UIViewController {
    
    var controller: ForgotPasswordController = ForgotPasswordController()
    
    let backgroundUIImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "giuphone_giu")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let forgotPasswordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Esqueceu a Senha"
        label.textColor = .background
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .background
        label.numberOfLines = 0
        return label
    }()
    
    lazy var emailTextField:FormTextField = {
        let textField = FormTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.backgroundColor = .white
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.inputType = .email
        
        var validation = Validation()
        validation.minimumLength = 1
        validation.format = "[\\w._%+-]+@[\\w.-]+\\.\\w{2,}"
        let inputValidator = InputValidator(validation: validation)
        textField.inputValidator = inputValidator
        
        return textField
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .black
        button.setTitle("Enviar", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        emailTextField.text = "a@a.com"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func forgotPasswordTapped() {
        let validEmail = emailTextField.validate()
        if  validEmail {
            // Chamada Controller
        }
    }
    
    func successToLogin(token: String) {
        let logged = LoggeViewController(token: token)
        logged.modalPresentationStyle = .fullScreen
        self.present(logged, animated: true)
    }
    
    func failedToLogin(error: NSError) {
        let alertController = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

extension FortgotPasswordViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(backgroundUIImageView)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(forgotPasswordButton)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundUIImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundUIImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            forgotPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 60),
            
            emailLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: forgotPasswordLabel.leadingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 40),
            emailLabel.widthAnchor.constraint(equalToConstant: 80),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 60),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 180)
            
            
        ])
    }
    
    func setUpAdditionalConfiguration() {
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        self.view.backgroundColor = .background
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    
}

