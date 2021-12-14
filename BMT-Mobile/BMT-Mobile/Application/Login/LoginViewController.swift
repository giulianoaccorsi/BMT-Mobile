//
//  HomeViewController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 22/05/21.
//

import UIKit
import FormTextField
import CBFlashyTabBarController

class LoginViewController: UIViewController {
    
    var controller: LoginController = LoginController()
    
    let imageLogo: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "bmtImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .black
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
    
    let passwordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .black
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 15)
        button.setTitle("Esqueceu sua senha?", for: .normal)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Novo Aqui? Cadastre-se", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 15)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
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
        
        let highlightsVC = HighlightsViewController(token: token)
        highlightsVC.tabBarItem = UITabBarItem(title: "Destaques", image: #imageLiteral(resourceName: "comprar30").withRenderingMode(.alwaysOriginal), tag: 0)
        let adVC = AdViewController(token: token)
        adVC.tabBarItem = UITabBarItem(title: "Anúncios", image: #imageLiteral(resourceName: "announce30"), tag: 0)
        let sairVC = LeaveViewController()
        sairVC.tabBarItem = UITabBarItem(title: "Sair", image: #imageLiteral(resourceName: "leave25").withRenderingMode(.alwaysOriginal), tag: 0)
        
        
        let tabBarController = CBFlashyTabBarController()
        tabBarController.viewControllers = [highlightsVC, adVC, sairVC]
        tabBarController.tabBar.tintColor = .black
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true)
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
        view.addSubview(loginButton)
        view.addSubview(imageLogo)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(forgotPasswordButton)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageLogo.heightAnchor.constraint(equalToConstant: 150),
            imageLogo.widthAnchor.constraint(equalToConstant: 150),
            
            emailLabel.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: imageLogo.leadingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 40),
            emailLabel.widthAnchor.constraint(equalToConstant: 80),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: imageLogo.leadingAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: 40),
            passwordLabel.widthAnchor.constraint(equalToConstant: 80),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: imageLogo.leadingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 30),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 10),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            
            registerButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            registerButton.heightAnchor.constraint(equalToConstant: 30),
            registerButton.widthAnchor.constraint(equalToConstant: 180),
            
            
        ])
    }
    
    func setUpAdditionalConfiguration() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        self.view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    
}

extension LoginViewController: RegisterViewControllerDelegate {
    func getEmailForLogin(email: String) {
        self.emailTextField.text = email
    }
}

