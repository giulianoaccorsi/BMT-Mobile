//
//  HomeViewController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 22/05/21.
//

import UIKit
import FormTextField

class LoginViewController: UIViewController {
    
    var controller: LoginController = LoginController()
    
    let loginLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Login"
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
    
    let backgroundUIImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "giuphone_giu")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
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
    
    let passwordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .background
        label.text = "Password"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var passwordTextField:FormTextField = {
        let textField = FormTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Senha"
        textField.inputType = .password
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.backgroundColor = .white
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        var validation = Validation()
        validation.minimumLength = 1
        let inputValidator = InputValidator(validation: validation)
        textField.inputValidator = inputValidator
        return textField
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.background, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 15)
        button.setTitle("Esqueceu sua senha?", for: .normal)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle("Novo Aqui? Cadastre-se", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 15)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .black
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func loginTapped() {
        let validEmail = emailTextField.validate()
        let password = passwordTextField.validate()
        if  validEmail && password {
            controller.isTokenActive(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { token,error  in
                if let tokenAPI = token {
                    self.successToLogin(token: tokenAPI)
                    return
                }else {
                    self.failedToLogin(error: error!)
                }
            }
        }
    }
    
    @objc func registerTapped() {
        print("Tocou Register")
        let registerViewController = RegisterViewController()
        registerViewController.delegate = self
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc func forgotPasswordTapped() {
        print("Tocou Forget")
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

extension LoginViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(backgroundUIImageView)
        view.addSubview(loginButton)
        view.addSubview(loginLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(forgotPasswordButton)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundUIImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundUIImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginLabel.heightAnchor.constraint(equalToConstant: 60),
            loginLabel.widthAnchor.constraint(equalToConstant: 150),
            
            emailLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 40),
            emailLabel.widthAnchor.constraint(equalToConstant: 80),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: 40),
            passwordLabel.widthAnchor.constraint(equalToConstant: 80),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.centerYAnchor),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            registerButton.heightAnchor.constraint(equalToConstant: 30),
            registerButton.widthAnchor.constraint(equalToConstant: 180),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 30),
            
            
        ])
    }
    
    func setUpAdditionalConfiguration() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        self.view.backgroundColor = .background
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    
}

extension LoginViewController: RegisterViewControllerDelegate {
    func getEmailForLogin(email: String) {
        self.emailTextField.text = email
    }
}

