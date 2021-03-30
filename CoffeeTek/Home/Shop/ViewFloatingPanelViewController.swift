//
//  ViewFloatingPanelViewController.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 5/3/21.
//

import UIKit
import SVProgressHUD

class ViewFloatingPanelViewController: UIViewController {
    @IBOutlet weak var viewMenuRadia: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var callback: (() -> Void)?
    @IBAction func buttomViewMune(_ sender: AnyObject) {
        SVProgressHUD.show(withStatus: "Loading...!")
        SVProgressHUD.dismiss(withDelay: 0.5)
            callback!()
        
    }
    var finalModel:[DataModels] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMenuRadia.layer.cornerRadius = 25
    }
}
