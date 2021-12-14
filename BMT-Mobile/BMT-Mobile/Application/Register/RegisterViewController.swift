//
//  RegisterViewController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 22/05/21.
//


import UIKit
import FormTextField

protocol RegisterViewControllerDelegate {
    func getEmailForLogin(email: String)
}

class RegisterViewController: UIViewController {
    
    var controller: RegisterController = RegisterController()
    var delegate: RegisterViewControllerDelegate?
    
    let imageLogo: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "bmtImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome Completo"
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .background
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nameTextField:FormTextField = {
        let textField = FormTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nome Completo"
        textField.inputType = .name
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
    
    let passwordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .background
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
    
    let registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.background.cgColor
        button.setTitleColor(.background, for: .normal)
        button.setTitle("Cadastrar", for: .normal)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if passwordTextField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
    
    @objc func registerTapped() {
        let completeName = nameTextField.validate()
        let validEmail = emailTextField.validate()
        let password = passwordTextField.validate()
        if completeName && validEmail && password {
            
            let user = User(fullName: nameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", telephone: "TODO")
            controller.registerUser(user: user)
        }
    }
    
}

extension RegisterViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(imageLogo)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageLogo.heightAnchor.constraint(equalToConstant: 150),
            imageLogo.widthAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: imageLogo.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 40),
            emailLabel.widthAnchor.constraint(equalToConstant: 80),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: 40),
            passwordLabel.widthAnchor.constraint(equalToConstant: 80),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.widthAnchor.constraint(equalToConstant: 150)
            
            
        ])
    }
    
    func setUpAdditionalConfiguration() {
        
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        controller.delegate = self
        
        // Redesign Keyboard
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        // UpView Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.isEqual(nameTextField) {
            emailTextField.becomeFirstResponder()
        }else if textField.isEqual(emailTextField) {
            passwordTextField.becomeFirstResponder()
        }
        passwordTextField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController: RegisterControllerDelegate {
    func sucessRegistration(result: Bool) {
        let alertController = UIAlertController(title: "Válido!", message: "Seu cadastro foi feito com sucesso", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Fechar", style: .default, handler: { _ in
            self.delegate?.getEmailForLogin(email: self.emailTextField.text ?? "")
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func failedToRegister(error: NSError) {
    
        let alertController = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
