//
//  LoginViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit

class LoginViewController: UIViewController{

    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dontHaveAnAccountButton: UIButton!
    @IBOutlet weak var continueAsAnonymousButton: UIButton!
    
    var isSuccess:Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (isSuccess){
            alertAction(title: "", mesaj: "Kayıt işlemi başarılı.")
            isSuccess = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegister"{
            let destinationVC = segue.destination as! RegisterViewController
            destinationVC.delegate = self
        }
    }
    
    func configureUI(){
        continueAsAnonymousButton.setAttributedTitle(NSAttributedString().attributedString(first: "Continue as ", second: "Anonymous!", color: UIColor.darkGray, fontSize: 13), for: .normal)
        dontHaveAnAccountButton.setAttributedTitle(NSAttributedString().attributedString(first: "Don't have an account? ", second: "Sign Up", color: UIColor.orange, fontSize: 16), for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func continueAsAnonymousButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension LoginViewController: RegisterViewControllerDelegate{
    func registerSuccesfully(succesfully: Bool, email: String) {
        isSuccess = succesfully
        emailTextField.text = email
    }
}

