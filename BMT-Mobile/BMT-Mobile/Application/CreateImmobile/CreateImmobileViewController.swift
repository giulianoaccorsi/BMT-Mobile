//
//  CreateImmobileViewController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 26/05/21.
//


import UIKit
import FormTextField

protocol CreateImmobileViewControllerDelegate {
    func sucessCreate()
}

class CreateImmobileViewController: UIViewController {
    
    var controller: CreateImmobileController = CreateImmobileController()
    var delegate: CreateImmobileViewControllerDelegate?
    var urlImage: String?
    
    let backgroundUIImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "giuphone_giu")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let addImageButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "addFull"), for: .selected)
        return button
    }()
    
    let imagemLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Imagem"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .background
        label.numberOfLines = 0
        return label
    }()
    
    let imagePoster: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleViewControllerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Cadastrar Imóvel"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = .background
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Título"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .background
        label.numberOfLines = 0
        return label
    }()
    
    lazy var titleTextField:FormTextField = {
        let textField = FormTextField()
        textField.placeholder = "Título do Imóvel"
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição"
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor = .background
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionTextField:FormTextField = {
        let textField = FormTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Descrição do Imóvel"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.backgroundColor = .white
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.inputType = .name
        
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
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .black
        button.setTitle("Cadastrar", for: .normal)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addImageButton.addTarget(self, action: #selector(tappedView), for: .touchUpInside)
        
    }
    @objc func tappedView(sender : UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Selecionar Foto", message: "De onde que você quer escolher a foto ?", preferredStyle: .actionSheet)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self](_) in
                guard let self = self else {return}
                self.selecPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de Fotos", style: .default) { [weak self](_) in
            guard let self = self else {return}
            self.selecPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photoAction = UIAlertAction(title: "Álbum de Fotos", style: .default) { [weak self](_) in
            guard let self = self else {return}
            self.selecPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photoAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func selecPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
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
            if descriptionTextField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }else if titleTextField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
    
    @objc func registerTapped() {
        let title = titleTextField.validate()
        let description = descriptionTextField.validate()
        if title && description {
            
            if let imgURL = self.urlImage {
                let immobileCreated = Immobile(createdAt: "", itemDescription: self.descriptionTextField.text ?? "", id: 0, imgURL: imgURL, title: self.titleTextField.text ?? "")
                controller.createImmobile(immobile: immobileCreated)
            }
        }
    }
}

extension CreateImmobileViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(backgroundUIImageView)
        view.addSubview(titleViewControllerLabel)
        view.addSubview(imagemLabel)
        view.addSubview(imagePoster)
        view.addSubview(addImageButton)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(registerButton)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundUIImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundUIImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleViewControllerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            titleViewControllerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleViewControllerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleViewControllerLabel.heightAnchor.constraint(equalToConstant: 60),
            
            imagemLabel.topAnchor.constraint(equalTo: titleViewControllerLabel.bottomAnchor, constant: 16),
            imagemLabel.leadingAnchor.constraint(equalTo: titleViewControllerLabel.leadingAnchor),
            imagemLabel.heightAnchor.constraint(equalToConstant: 35),
            
            imagePoster.topAnchor.constraint(equalTo: imagemLabel.bottomAnchor, constant: 4),
            imagePoster.leadingAnchor.constraint(equalTo: imagemLabel.leadingAnchor),
            imagePoster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            imagePoster.heightAnchor.constraint(equalToConstant: 150),
            
            addImageButton.centerYAnchor.constraint(equalTo: imagePoster.centerYAnchor),
            addImageButton.leadingAnchor.constraint(equalTo: imagePoster.leadingAnchor, constant: 8),
            addImageButton.heightAnchor.constraint(equalToConstant: 60),
            addImageButton.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: imagePoster.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: imagePoster.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 35),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 80),
            
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            descriptionTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.widthAnchor.constraint(equalToConstant: 150)
            
            
        ])
    }
    
    func setUpAdditionalConfiguration() {
        
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        view.backgroundColor = .background
        
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        controller.delegate = self
        
        // Redesign Keyboard
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        // UpView Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}

extension CreateImmobileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.isEqual(titleTextField) {
            descriptionTextField.becomeFirstResponder()
        }
        return true
    }
}

extension CreateImmobileViewController: CreateImmobileControllerDelegate {
    func sucessCreated() {
        let alertController = UIAlertController(title: "Válido!", message: "Seu anúncio foi feito com sucesso", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Fechar", style: .default, handler: { _ in
            self.delegate?.sucessCreate()
            self.dismiss(animated: true)
        })
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func failedCreated(error: NSError) {
        let alertController = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func completionUploadImgur(result: String) {
        self.urlImage = result
        print(result)
    }
    
}


extension CreateImmobileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            controller.uploadToImgur(image: image)
            imagePoster.image = image
        }
        self.addImageButton.isHidden = true
        
        dismiss(animated: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
