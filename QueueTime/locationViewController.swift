//
//  locationViewController.swift
//  
//
//  Created by Tim van der Zee on 13/11/2018.
//

import UIKit
import MapKit
import GeoFire





class locationViewController: UIViewController, CLLocationManagerDelegate {

    // Outlet voor de kaart
    @IBOutlet weak var map: MKMapView!
    
    
    //Outlet voor de knop waarmee gebeld kan worden //IVO
    @IBOutlet weak var callButtonOutlet: UIButton!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    // Location manager
    var locationManager = CLLocationManager()
    var geoFire: GeoFire!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Hier word de knop om mee te bellen in de juiste vorm gezet //IVO
        callButtonOutlet.layer.masksToBounds = true
        callButtonOutlet.layer.cornerRadius = 43
        
        //Hier wordt het label met de huidige locatie in de goede vorm gezet // TIM
        labelView.layer.cornerRadius = 43
        
        
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
        
        // GeoCoder zet de coördinaten om naar leesbare locatie in label
        //TIM
        CLGeocoder().reverseGeocodeLocation(userLocation!) { (placemark, error) in
            if error != nil
            {
                print("Error :(")
            }
            else
            {
                // Als locatie gelijk is aan laatste locatie...
                //TIM
                if let place = placemark?[0]
                {
                    // Zet label om naar tekst van laatste locatie
                    //TIM
                    self.locationLabel.text = "\(String(describing: place.thoroughfare!)) \n\(String(describing: place.locality!))"
                    
                    
                    
                   
                }
            }
        }
        
    }


}
