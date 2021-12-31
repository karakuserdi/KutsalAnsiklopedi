//
//  RegisterViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit
import Firebase

protocol RegisterViewControllerDelegate{
    func kayitBasarili(basarili: Bool)
}

class RegisterViewController: UIViewController{
    
    //MARK: - Properties
    
    var delegate:RegisterViewControllerDelegate?
    
    //imagepicker
    private let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    @IBOutlet weak var alreadyHaveAnAccountButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    func configureUI(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
                
        profileImageView.layer.cornerRadius = 75
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        alreadyHaveAnAccountButton.setAttributedTitle(NSAttributedString().attributedString(first: "Already have an account? ", second: "Log In"), for: .normal)
    }
    
    
    //MARK: - Actions
    @IBAction func profilePhotoButtonPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let profileImage = profileImageView.image else {
            print("profil foto seçiniz")
            return
        }
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let repassword = repasswordTextField.text else {return}
        guard let username = usernameTextField.text else {return}
    
        if password != repassword{
            alertTimer(title: "", mesaj: "Şifreler uyuşmuyor")
            return
        }
        
        let user = User(email: email, password: password, username: username, profileImage: profileImage)
        
        AuthService.shared.registerUser(user: user) { error,ref in
            self.delegate?.kayitBasarili(basarili: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
  
    
    @IBAction func alreadyHaveAnAccountButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        profileImageView.layer.borderColor = UIColor.orange.cgColor
        profileImageView.layer.borderWidth = 5
        self.profileImageView.image = profileImage
        dismiss(animated: true, completion: nil)
        
    }
}
