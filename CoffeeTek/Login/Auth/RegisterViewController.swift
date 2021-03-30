//
//  RegisterViewController.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 26/2/21.
//

import UIKit
import RealmSwift
import Alamofire
struct Object {
    let phone: String
    let password:String
}
class RegisterViewController: UIViewController {

    @IBOutlet weak var textPhoneNumber: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textConfirmPassword: UITextField!
    @IBOutlet weak var registerRadius: UIButton!
    
    @IBOutlet weak var LabelInvalidConfirmPass: UILabel!
    @IBOutlet weak var LabelInvalidPassword: UILabel!
    @IBOutlet weak var LabelInvalidPhoneNumber: UILabel!
    
    @IBOutlet weak var btnworringConfirmPass: UIButton!
    @IBOutlet weak var btnworringPhoneNum: UIButton!
    @IBOutlet weak var btnworrringPass: UIButton!
  
    @IBAction func buttonRegister(_ sender: Any) {
//       isHidden()
        let phoneNumber = isValidPhone(phone: textPhoneNumber.text!)
        let password = isValidPassword(Pass: textPassword.text!)
        let confirmPass = isValidPassword(Pass: textConfirmPassword.text!)
        
        if (phoneNumber == false){
            LabelInvalidPhoneNumber.isHidden = false
            btnworringPhoneNum.isHidden = false
        }else if(password == false){
            LabelInvalidPassword.isHidden = false
            btnworrringPass.isHidden = false
        }
        else if(confirmPass == false){
            LabelInvalidConfirmPass.isHidden = false
            btnworringConfirmPass.isHidden = false
        
        }
        
    }
    private let realm = try! Realm()
    private var data = [Object]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHidden()
        setUpNavBar()
        navigationController?.isNavigationBarHidden = false
        registerRadius.layer.cornerRadius = 25
    }
    func isHidden(){
        LabelInvalidPassword.isHidden = true
        LabelInvalidConfirmPass.isHidden = true
        LabelInvalidPhoneNumber.isHidden = true
        
        btnworringPhoneNum.isHidden = true
        btnworrringPass.isHidden = true
        btnworringConfirmPass.isHidden = true
    }
    
    func isValidPassword(Pass: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{6,16}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    func isValidPhone(phone: String) -> Bool {
//        let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
        let phoneRegex = "^((\\+)|(00))[0-9]{6,14}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return  predicate.evaluate(with: self)
    }
    
    
    func setUpNavBar() {
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.brown
        self.navigationItem.title = "Register"
    }

    
}

