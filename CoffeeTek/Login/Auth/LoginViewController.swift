//
//  LoginViewController.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 26/2/21.
//
import Alamofire
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var keyIcon: UIImageView!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var loginRadius: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        navigationController?.isNavigationBarHidden = false
        loginRadius.layer.cornerRadius = 25
//        navigationItem.backBarButtonItem = UIBarButtonItem(
//            title: "Login", style: .plain, target: nil, action: nil)
        
    }
    func setUpNavBar() {
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.brown
        self.navigationItem.title = "Login"
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
}
