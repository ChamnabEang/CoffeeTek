//
//  PreferenceViewController.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 6/3/21.
//

import UIKit

class PreferenceViewController: UIViewController {
    @IBOutlet weak var namePreference: UILabel!
    @IBOutlet weak var imagePreference: UIImageView!
    @IBOutlet weak var addition2: UIImageView!
    @IBOutlet weak var addition1: UIImageView!
    @IBOutlet weak var suger0: UIImageView!
    @IBOutlet weak var suger1: UIImageView!
    @IBOutlet weak var suger2: UIImageView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var imageS1: UIImageView!
    @IBOutlet weak var imageS2: UIImageView!
    @IBOutlet weak var imageS3: UIImageView!
    @IBOutlet weak var LabelStepper: UILabel!
    @IBOutlet weak var addCartRadia: UIButton!
    @IBAction func buttomStepper(_ sender: UIStepper) {
        LabelStepper.text = String(Int(sender.value))
        let total = Float(sender.value) * (Float(pricePreference))
        totalPrice.text = "\(total)$"
    }
    @IBAction func buttomCart(_ sender: Any) {
//        CartTableViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartScreen = storyboard.instantiateViewController(withIdentifier: "CartViewController")
        self.navigationController?.pushViewController(cartScreen, animated: false)
    }
    @IBAction func backButtom(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    var nameTITLE = ""
    var pricePreference:Float = 1.0
    var tapGesture = UITapGestureRecognizer()
//    var preferenceMenu: [MenuModel] = []
    var dataModel:MenuModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        clearColorSize()
        clearColorSuger()
        clearColorAdditon()
        SizeCup()
        Sugercrame()
        Addition()
        addCartRadia.layer.cornerRadius = 25
        
        if let data = dataModel {
            let imgURL = URL(string: data.image)
            self.imagePreference.kf.setImage(with: imgURL)
            self.namePreference.text = data.name
            self.pricePreference = Float(data.price)
            totalPrice.text = "\(String(pricePreference))$"
        }
    }
    func SizeCup(){
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.Size1Tapped(_:)))
        imageS1.addGestureRecognizer(tapGesture)
        imageS1.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.Size2Tapped(_:)))
        imageS2.addGestureRecognizer(tapGesture)
        imageS2.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.Size3Tapped(_:)))
        imageS3.addGestureRecognizer(tapGesture)
        imageS3.isUserInteractionEnabled = true
    }
    func Sugercrame(){
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.Suger0Tapped(_:)))
        suger0.addGestureRecognizer(tapGesture)
        suger0.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.Suger1Tapped(_:)))
        suger1.addGestureRecognizer(tapGesture)
        suger1.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.Suger2Tapped(_:)))
        suger2.addGestureRecognizer(tapGesture)
        suger2.isUserInteractionEnabled = true
    }
    func Addition(){
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.Addition1Tapped(_:)))
        addition1.addGestureRecognizer(tapGesture)
        addition1.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.Addition2Tapped(_:)))
        addition2.addGestureRecognizer(tapGesture)
        addition2.isUserInteractionEnabled = true
        
    }
    @objc func Size1Tapped(_ sender:UITapGestureRecognizer){
        clearColorSize()
        imageS1.alpha = 1
        imageS2.alpha = 0.3
    }
    @objc func Size2Tapped(_ sender:UITapGestureRecognizer){
        clearColorSize()
        imageS2.alpha = 1
    }
    @objc func Size3Tapped(_ sender:UITapGestureRecognizer){
        clearColorSize()
        imageS3.alpha = 1
        imageS2.alpha = 0.3
    }
    @objc func Suger0Tapped(_ sender:UITapGestureRecognizer){
        clearColorSuger()
        suger0.alpha = 1
        suger1.alpha = 0.3
    }
    @objc func Suger1Tapped(_ sender:UITapGestureRecognizer){
        clearColorSuger()
        suger1.alpha = 1
    }
    @objc func Suger2Tapped(_ sender:UITapGestureRecognizer){
        clearColorSuger()
        suger2.alpha = 1
        suger1.alpha = 0.3
    }
    @objc func Addition1Tapped(_ sender:UITapGestureRecognizer){
        clearColorAdditon()
        if addition1.alpha == 0.3{
            addition1.alpha = 0.3
            print("true==1")
        }else{
            addition1.alpha = 1
            print("false==1")
        }
    }
    @objc func Addition2Tapped(_ sender:UITapGestureRecognizer){
        clearColorAdditon()
        if addition2.alpha == 0.3{
            addition2.alpha = 0.3
            print("true==2")
        }else{
            addition2.alpha = 1
            print("false==2")
        }
    }
    func clearColorSize(){
        imageS1.alpha = 0.3
        imageS2.alpha = 1
        imageS3.alpha = 0.3
    }
    func clearColorSuger(){
        suger0.alpha = 0.3
        suger1.alpha = 1
        suger2.alpha = 0.3
    }
    func clearColorAdditon(){
        addition1.alpha = 0.3
        addition2.alpha = 0.3
    }
}
