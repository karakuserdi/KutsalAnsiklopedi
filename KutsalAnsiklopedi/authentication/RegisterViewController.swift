//
//  RegisterViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Properties
    
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
        print("sign up button pressed")
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
