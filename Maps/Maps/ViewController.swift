//
//  ViewController.swift
//  Maps
//
//  Created by RuiJun haung on 2021/3/13.
//

import UIKit
import MapKit
class ViewController: UIViewController,MKMapViewDelegate{

    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let latitude: CLLocationDegrees = 40.7
        let longitude: CLLocationDegrees = -73.9
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
    }


}

