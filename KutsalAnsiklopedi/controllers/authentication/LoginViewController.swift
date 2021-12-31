//
//  LoginViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var dontHaveAnAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        //signUp button attributedString
        dontHaveAnAccountButton.setAttributedTitle(NSAttributedString().attributedString(first: "Don't have an account? ", second: "Sign Up"), for: .normal)
    }
}
