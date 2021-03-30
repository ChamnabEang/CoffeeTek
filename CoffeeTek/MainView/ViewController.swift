//
//  ViewController.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 25/2/21.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var loginButtonRadius: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let imaArr = [UIImage(named: "artwork"),UIImage(named: "artwork"),UIImage(named: "artwork")]
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
//        self.navigationController?.view.backgroundColor = UIColor.white
        
        loginButtonRadius.layer.cornerRadius = 25
        registerButton.layer.cornerRadius = 25
        loginButtonRadius.layer.borderWidth = 1
        loginButtonRadius.layer.borderColor = UIColor.brown.cgColor
        pageControl.numberOfPages = imaArr.count
        
    }
//    func configureNavigationBar(){
//        navigationController?.navigationBar.barTintColor = .white
//        navigationItem.title = "Category"
//    }
   
}
extension ViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        pageControl.currentPage = currentIndex
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imaArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell
        cell?.image = imaArr[indexPath.row]
            return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
