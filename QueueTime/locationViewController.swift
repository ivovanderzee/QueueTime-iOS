//
//  locationViewController.swift
//  
//
//  Created by Tim van der Zee on 13/11/2018.
//

import UIKit
import MapKit


class locationViewController: UIViewController, CLLocationManagerDelegate {

    // Outlet voor de kaart
    @IBOutlet weak var map: MKMapView!
    
    // Location manager
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        
        // If statement voor als locatie is aangezet en geaccepteerd
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    // Functie die wordt aangeroepen om elke keer de locatie op te vragen
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.map.setRegion(viewRegion, animated: true)
        
        self.map.showsUserLocation = true
    }


}
