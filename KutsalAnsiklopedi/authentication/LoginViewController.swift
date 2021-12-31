//
//  LoginViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dontHaveAnAccountButton: UIButton!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        dontHaveAnAccountButton.setAttributedTitle(NSAttributedString().attributedString(first: "Don't have an account? ", second: "Sign Up"), for: .normal)
        
        
    }
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
}
