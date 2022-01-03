//
//  TabBarController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 31.12.2021.
//

import UIKit
import Firebase

class TabBarController: UITabBarController{
    
    //MARK: - Properties
    let pickerTextField = UITextField(frame: CGRect(x: 0, y: 50, width: 200, height: 100))
    var pickerData = [String]()
    
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

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //logout()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Check user log in and fetch if user already log in !
        Auth.auth().currentUser != nil ? fetchUser() : print("Giriş yapılmadı")
    }
    
    //MARK: - Configure
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
    
    //MARK: - API
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    //MARK: - Helper functions
    func authenticateUserAndConfigUI(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
        }else {
            addNewTitle()
        }
    }
    
    func addNewTitle(){
        pickerData = ["Genel","Spor","Siyaset"]
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 200,height: 200)
        let titleTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let pickerView = UIPickerView()
        
        pickerTextField.inputView = pickerView
        pickerTextField.placeholder = "Select a content"
        pickerTextField.delegate = self
        
        titleTextField.placeholder = "Enter a title"
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(titleTextField)
        vc.view.addSubview(pickerTextField)
        
        let editRadiusAlert = UIAlertController(title: "Create a new title", message: "", preferredStyle: UIAlertController.Style.alert)
        
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            if let title = titleTextField.text, let icerik = self.pickerTextField.text{
                if title.isEmpty || icerik.isEmpty {
                    return
                }else{
                    TitleService.shared.uploadTitle(title: title, titleContent: icerik) { error, ref in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }))
        
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: { alert in
            self.pickerTextField.text = ""
            titleTextField.text = ""
            
            self.pickerTextField.placeholder = "Select a content"
            titleTextField.placeholder = "Enter a title"
        }))
        self.present(editRadiusAlert, animated: true)
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
extension TabBarController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
