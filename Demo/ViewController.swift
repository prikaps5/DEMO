//
//  ViewController.swift
//  Demo
//
//  Created by Admin on 04/07/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK: OUTLETS
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var homePhoneTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    //MARK: VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registration"
        self.setTextViewProperty()
        self.initializeHideKeyboard()
        self.setDelegates()
        // Do any additional setup after loading the view.
    }
    
    func setTextViewProperty() {
        addressTextView.text = "Address"
        addressTextView.textColor = UIColor.lightGray
        addressTextView.layer.borderWidth = 0.3
        addressTextView.layer.cornerRadius = 5
        addressTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //MARK: BUTTON ACTIONS
    
    @IBAction func submutBtnClicked(_ sender: UIButton) {
        
        if nameTextField.text == "" {
            self.showAlert(str: "Please enter name.")
            return
        } else if !emailTextField.text!.isValidEmail {
            self.showAlert(str: "Please enter valid email.")
            return
        }
        let userData = UserData(name: nameTextField.text ?? "", email: emailTextField.text ?? "", mobile: mobileTextField.text ?? "", homeNumber: homePhoneTextField.text ?? "", zipCode: zipCodeTextField.text ?? "", address: addressTextView.text)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC
        vc?.user = userData
        self.navigationController?.pushViewController(vc!, animated: true)
 
    }
    
    func setDelegates() {
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.homePhoneTextField.delegate = self
        self.mobileTextField.delegate = self
        self.zipCodeTextField.delegate = self
        self.addressTextView.delegate = self

    }
    
    func showAlert(str:String) {
        
        // create the alert
            let alert = UIAlertController(title: "Demo", message: str, preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
    }
    
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }

}

extension ViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField || textField == emailTextField {
            return self.textLimit(existingText: textField.text,
                                      newText: string,
                                      limit: 25)
        } else if textField == homePhoneTextField || textField == mobileTextField {
            return self.textLimit(existingText: textField.text,
                                      newText: string,
                                      limit: 10)
        } else if textField == zipCodeTextField {
            return self.textLimit(existingText: textField.text,
                                      newText: string,
                                      limit: 6)
        }
        return false
    }
    
}

extension ViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        return self.textLimit(existingText: textView.text,
                              newText: text,
                              limit: 100)
    }
}

extension String {
    
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
     }
    
}

extension ViewController {
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}

