//
//  shopsVC.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 16.02.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit
import MapKit

var bigMap = MKMapView()
let locationManager = CLLocationManager()
let shopNameLabel = UILabel()
let shopSheduleLabel = UILabel()
let shopPhone = UILabel()
let shopButton = UIButton()
let bottomPanelView = UIView()



class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubtitle:String, pinCoordinate:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubtitle
        self.coordinate = pinCoordinate
        
    }
    //code here
}





class shopsVC: UIViewController {

    var shopCoorAr :[[String]] = [["Хользунова","Пн-Вс 8:30-22:00","51.70312162848","39.183273211639"],
     ["Вл.Невского","Пн-Вс 8:30-22:00","51.716144118003","39.170564628311"],
     ["Моисеева","Пн-Вс 8:30-22:00","51.652903373396","39.180129662671"],
     ["Ленинский","Пн-Вс 8:30-22:00","51.64092236671","39.235838508598"]
    ]
    
    
    func addMapAnnotation(zoom:Double) {//add all pins on map
        //code here
        
        
        //var trackerCoordinate:[[String]] = resulty
        
        let location = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 51.660283, longitude: locationManager.location?.coordinate.longitude ?? 39.199101)
        
        locationManager.location?.coordinate.latitude ?? 51.0
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom))
        bigMap.setRegion(region, animated: true)
        
     
        
        
        
        if shopCoorAr.count>0 {
            for index2 in 0..<shopCoorAr.count {
                let smallCoorAr = shopCoorAr[index2]
                
                let lat = Double(smallCoorAr[2])
                let long = Double(smallCoorAr[3])
                let loci = CLLocationCoordinate2D(latitude: lat ?? 51.0,  longitude: long ?? 39.0)
                print(loci)
           
                let pini = customPin(pinTitle: smallCoorAr[0], pinSubtitle: smallCoorAr[1], pinCoordinate: loci)
               
                bigMap.addAnnotation(pini)
    
            }
        }
        
    }
    
    func createBottomPart() {
        
     //   bottomPanelView.frame = CGRect(x: 5, y: self.view.frame.height-150, width: view.frame.width-10, height: 160)
        //MARK:  show bottom  panel with labels
        bottomPanelView.backgroundColor = .black
        bottomPanelView.layer.opacity = 0.5
        bottomPanelView.layer.cornerRadius = 10
        view.addSubview(bottomPanelView)
        bottomPanelView.layer.masksToBounds = true
        bottomPanelView.translatesAutoresizingMaskIntoConstraints = false
        bottomPanelView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        bottomPanelView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        //bottomPanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55).isActive = true
        bottomPanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        bottomPanelView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        bottomPanelView.isHidden = true
        
        
      //  shopNameLabel.layer.frame = CGRect(x: 15, y: self.view.frame.height-150, width: 200, height: 50)
        shopNameLabel.layer.masksToBounds = true
        shopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        shopNameLabel.textColor = .white
        view.addSubview(shopNameLabel)
        
        shopNameLabel.topAnchor.constraint(equalTo: bottomPanelView.topAnchor, constant: 5).isActive = true
        shopNameLabel.leftAnchor.constraint(equalTo: bottomPanelView.leftAnchor, constant: 10).isActive = true
        shopNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        shopNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
               
        
     //   shopSheduleLabel.layer.frame = CGRect(x: 15, y: self.view.frame.height-130, width: 200, height: 50)
        shopSheduleLabel.textColor = .lightGray
        view.addSubview(shopSheduleLabel)
        shopSheduleLabel.layer.masksToBounds = true
        shopSheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        shopSheduleLabel.topAnchor.constraint(equalTo: shopNameLabel.bottomAnchor, constant: 0).isActive = true
        shopSheduleLabel.leftAnchor.constraint(equalTo: bottomPanelView.leftAnchor, constant: 10).isActive = true
        shopSheduleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        shopSheduleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
            
        shopPhone.layer.frame = CGRect(x: 15, y: self.view.frame.height-110, width: 200, height: 50)
        shopPhone.textColor = .lightGray
        view.addSubview(shopPhone)
        
        shopPhone.layer.masksToBounds = true
        shopPhone.translatesAutoresizingMaskIntoConstraints = false
        shopPhone.topAnchor.constraint(equalTo: shopSheduleLabel.bottomAnchor, constant: 0).isActive = true
        shopPhone.leftAnchor.constraint(equalTo: bottomPanelView.leftAnchor, constant: 10).isActive = true
        shopPhone.widthAnchor.constraint(equalToConstant: 200).isActive = true
        shopPhone.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        //MARK: add button on botton panel
        shopButton.layer.frame = CGRect(x: self.view.frame.width-160, y: self.view.frame.height-130, width: 150, height: 50)
        shopButton.setTitle("Оставить отзыв", for: .normal)
        shopButton.setTitleColor(.white, for: .normal)
        shopButton.layer.borderColor = CGColor(srgbRed: 255, green: 255, blue: 255, alpha: 1)
        shopButton.layer.borderWidth  = 2
        shopButton.addTarget(self, action: #selector(shopButtonAction), for: .touchDown)
        view.addSubview(shopButton)
        
        shopButton.layer.masksToBounds = true
        shopButton.translatesAutoresizingMaskIntoConstraints = false
        shopButton.topAnchor.constraint(equalTo: bottomPanelView.topAnchor, constant: 10).isActive = true
        shopButton.rightAnchor.constraint(equalTo: bottomPanelView.rightAnchor, constant: -10).isActive = true
        shopButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        shopButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
              
        shopButton.isHidden = true
    }
    
    
    @objc func shopButtonAction() {
        print("action")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   bigMap.frame = CGRect(x: 0, y: 60, width: view.frame.width, height: view.frame.height-200)
        bigMap.layer.masksToBounds = true
        bigMap.translatesAutoresizingMaskIntoConstraints  = false
        view.addSubview(bigMap)
         bigMap.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
         bigMap.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 1).isActive = true
         bigMap.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1).isActive = true
         bigMap.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
//
        createBottomPart()
        
        bigMap.delegate = self
    
        
        addMapAnnotation(zoom:0.15)
        
        //get current position
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        bigMap.showsUserLocation = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension shopsVC:MKMapViewDelegate {
     func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationTitle = view.annotation?.title
               {
                    bottomPanelView.isHidden = false
                    shopButton.isHidden = false
                    shopNameLabel.text = annotationTitle
                    shopSheduleLabel.text = "Пн-Вс, 8:30-22:00"
                    shopPhone.text = "Тел: 207-45-85"
              //     print("User tapped on annotation with title: \(annotationTitle!)")
               }

    }
  
}
