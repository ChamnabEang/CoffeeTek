//
//  ViewMenuTableViewController.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 6/3/21.
//

import UIKit
import SVProgressHUD
import Alamofire
import Kingfisher
import SkeletonView

struct MenuModel:Decodable {
    let _id: String
    let name: String
    let image: String
    let price: Double
    let status: Int
    let __v:Int
}

class ViewMenuTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var titleLABEL: UILabel!
    @IBAction func backButton(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    var titileTable = ""
    var activityIndicator: UIActivityIndicatorView!
    var dataMenu: [MenuModel] = []
    override func viewDidLoad() {
//        titleLABEL.showAnimatedGradientSkeleton()
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        getData()
        self.titleLABEL.text = titileTable
        
    }
    func getData() {
        let request = AF.request("https://coffeetek.herokuapp.com/menu")
        request.responseDecodable(of: [MenuModel].self) { (response) in
            guard let films = response.value else {
        //    print("fail == \(response.debugDescription)")
                return
            }
            self.dataMenu = films
            self.tableView.reloadData()
        //     print("Count===\(films.count)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        if dataMenu != nil {
            cell.hideSkeleton()
//            cell.imageCell.hideSkeleton()
//            cell.labelCell.hideSkeleton()
            let model = dataMenu[indexPath.row]
            let imgURL = URL(string: model.image)
            cell.imageCell.kf.setImage(with: imgURL)
            cell.labelCell.text = model.name
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "segue", sender: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let newController = storyboard.instantiateViewController(withIdentifier: "PreferenceViewController") as! PreferenceViewController
        self.navigationController?.pushViewController(newController, animated: true)
        
        let models = dataMenu[indexPath.row]
        newController.nameTITLE = models.name
        newController.dataModel = models
   
    }
}

