//
//  OpenTitleViewController.swift
//  KutsalAnsiklopedi
//
//  Created by Riza Erdi Karakus on 2.01.2022.
//

import UIKit

class OpenTitleViewController: UIViewController {

    
    @IBOutlet weak var addTitleButton: UIButton!
    @IBOutlet weak var tarihTextField: UITextField!
    @IBOutlet weak var icerikTextField: UITextField!
    @IBOutlet weak var baslikTextField: UITextField!
    @IBOutlet weak var yorumTextView: UITextView!
    
    var pickerView:UIPickerView?
    var icerik = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerViewAndDate()
    }

    //MARK: - Helpers
    func configurePickerViewAndDate(){
        ///pickerView
        icerik = ["Gündem","Siyaset","Spor"]
        icerikTextField.text = icerik[0]
        icerikTextField.delegate = self
        pickerView = UIPickerView()
        icerikTextField.inputView = pickerView
        pickerView?.dataSource = self
        pickerView?.delegate = self
        
        ///date
        tarihTextField.isUserInteractionEnabled = false
        
        let today = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr")
        formatter.dateFormat = "dd MMMM yyyy"
        
        let date = formatter.string(from: today)
        tarihTextField.text = date
    }
    
    @IBAction func addTitleButtonPressed(_ sender: Any) {
        if let title = baslikTextField.text, let date = tarihTextField.text, let icerik = icerikTextField.text{
            TitleService.shared.uploadTitle(title: title, dateStamp: date, titleContent: icerik) { error, ref in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}


//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension OpenTitleViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return icerik.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return icerik[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        icerikTextField.text = icerik[row]
    }
}

extension OpenTitleViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
