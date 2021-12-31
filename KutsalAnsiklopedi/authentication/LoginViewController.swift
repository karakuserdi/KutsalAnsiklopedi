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
    
    var isSuccess:Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (isSuccess){
            alertTimer(title: "", mesaj: "Kayıt işlemi başarılı.")
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
        dontHaveAnAccountButton.setAttributedTitle(NSAttributedString().attributedString(first: "Don't have an account? ", second: "Sign Up"), for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
}

extension LoginViewController: RegisterViewControllerDelegate{
    func kayitBasarili(basarili: Bool, email: String) {
        isSuccess = basarili
        emailTextField.text = email
    }
}

