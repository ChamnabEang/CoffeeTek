//
//  MapScreenViewController.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 4/3/21.
//

import Alamofire
import UIKit
import GoogleMaps
import GooglePlaces
import FloatingPanel
import SVProgressHUD

struct DataModels:Decodable {
    let _id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let status: Int
    let __v: Int
    
    //    let distanceInMeters:String
}

class MapScreenViewController: UIViewController, CLLocationManagerDelegate,FloatingPanelControllerDelegate,GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    let loadingView = CircularLoadingView(frame:CGRect.zero)
    var currentLocationMarker: GMSMarker?
    var locationManager = CLLocationManager()
    var dataModel: [DataModels] = []
    var arrayMarker : [GMSMarker] = []
    var floatPanel: ViewFloatingPanelViewController? = nil
    var coordinate =  CLLocationCoordinate2D ()
    
    var distanceInMeters = CLLocationDistance()
    var coordinate0 = CLLocation()
    var coordinate1 = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        self.mapView.delegate = self
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // index data from API
        guard let index = arrayMarker.firstIndex(of: marker) else { return true }
        let tappedState = dataModel[index]
        
        marker.icon =  #imageLiteral(resourceName: "Pin 1 ")
        let camera = GMSCameraPosition.camera(
            withLatitude: marker.position.latitude,
            longitude: marker.position.longitude, zoom: 5.0)
        mapView.animate(to: camera)
        
        arrayMarker.forEach { pin in
            pin.icon = #imageLiteral(resourceName: "Pin 2")
        }
        if floatPanel == nil {
            buttomSheet()
            
            self.floatPanel!.addressLabel.text = tappedState.address
            self.floatPanel!.titleLabel.text = tappedState.name
            // self.floatPanel?.kmLabel.text = "\(format: " %.01fkm", distanceInMeters) km"
            
            coordinate0 = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
            
            // calculator
            self.distanceInMeters = coordinate0.distance(from: coordinate1)/1000.0
            self.floatPanel?.kmLabel.text = "\(distanceInMeters) km"
            
            marker.icon =  #imageLiteral(resourceName: "Pin 1 ")
            let camera = GMSCameraPosition.camera(
                withLatitude: marker.position.latitude,
                longitude: marker.position.longitude, zoom: 17.5)
            mapView.animate(to: camera)
        } else {
            self.floatPanel?.addressLabel.text = tappedState.address
            self.floatPanel?.titleLabel.text = tappedState.name
    
            //  self.distanceInMeters = Float(coordinate0.distance(from: coordinate1)/1000.0)
            //  self.floatPanel?.kmLabel.text = "\(distanceInMeters) km"
            
            marker.icon =  #imageLiteral(resourceName: "Pin 1 ")
            let camera = GMSCameraPosition.camera(
                withLatitude: marker.position.latitude,
                longitude: marker.position.longitude, zoom: 17.5)
            
            mapView.animate(to: camera)
        }
        return true
    }
//    let progressIndicator = CircularLoadingView(frame: CGRect.zero)
    func getData() {
        let request = AF.request("https://coffeetek.herokuapp.com/shop")
        request.responseDecodable(of: [DataModels].self) { (response) in
//            DispatchQueue.main.async {
//                self.progressIndicator.progress = CGFloat(response.serializationDuration)
//            }
            guard let films = response.value else { return
            }
            self.dataModel = films
            self.dataModel.forEach{ data in
                // get latitude and longitude
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(
                    latitude:  data.latitude,
                    longitude: data.longitude)
                marker.map = self.mapView
                marker.icon =  #imageLiteral(resourceName: "Pin 2")
                marker.appearAnimation = .pop
                
                self.arrayMarker.append(marker)
                
            }
        }
    }
    
    func buttomSheet() {
        let floatingPanel = FloatingPanelController()
            floatingPanel.delegate = self
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        floatPanel = storyboard.instantiateViewController(withIdentifier: "ViewFloatingPanelViewController") as? ViewFloatingPanelViewController
        floatPanel?.finalModel = dataModel
        floatingPanel.set(contentViewController: floatPanel!)
        floatingPanel.addPanel(toParent: self)
        // floatingPanel.isRemovalInteractionEnabled = true
        
        floatPanel?.callback = {
//            self.progressIndicator.reveal()
//            SVProgressHUD.show(withStatus: "Loading...!")
//            SVProgressHUD.dismiss(withDelay: 0.5)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newController = storyboard.instantiateViewController(withIdentifier: "ViewMenuTableViewController") as! ViewMenuTableViewController
            self.navigationController?.pushViewController(newController, animated: true)
            // send title to table
            newController.titileTable = self.floatPanel?.titleLabel.text ?? ""
        }
        
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 2.0, bearing: 0.0, viewingAngle:0.0)
            locationManager.stopUpdatingLocation()
            coordinate = location.coordinate
            print("=====\(coordinate)====")
        }
    }
}
class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 50.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.0, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 100.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
