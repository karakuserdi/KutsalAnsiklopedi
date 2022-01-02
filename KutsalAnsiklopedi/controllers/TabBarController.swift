//
//  TabBarController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    
    var user: User?{
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let home = nav.viewControllers.first as? HomeViewController else {return}
            
            home.user = user
        }
    }
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 56 / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //cikisyap()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Check user log in and fetch if user already log in !
        Auth.auth().currentUser != nil ? fetchUser() : print("Giriş yapılmadı")
    }
    
    func configureUI(){
        view.addSubview(addButton)
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    @objc func addButtonPressed(){
        authenticateUserAndConfigUI()
    }
    
    //MARK: - api
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigUI(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
        }else {
            let strocyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let openVC = strocyboard.instantiateViewController(withIdentifier: "openTitle") as! OpenTitleViewController
            
            present(openVC, animated: true, completion: nil)
        }
    }
    
    func cikisyap(){
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
