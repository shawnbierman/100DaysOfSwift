//
//  ViewController.swift
//  Project16
//
//  Created by Shawn Bierman on 4/19/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let capitals = [Capital(title: "Washington, D.C.", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667),
                            info: "Named after George himself.", url: "https://en.wikipedia.org/wiki/Washington,_D.C."),
                    Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                            info: "Home to the 2012 Summer Olypmics", url: "https://en.wikipedia.org/wiki/London"),
                    Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75),
                            info: "Founded over a thousand years ago.", url: "https://en.wikipedia.org/wiki/Oslo"),
                    Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508),
                            info: "Often called the City of Light", url: "https://en.wikipedia.org/wiki/Paris"),
                    Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5),
                            info: "Has a whole country inside it.", url: "https://en.wikipedia.org/wiki/Rome") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View", style: .plain, target: self, action: #selector(handleMapView))
        
        mapView.addAnnotations(capitals)
    }
    
    @objc fileprivate func handleMapView() {
        
        let ac = UIAlertController(title: "Map Settings", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self] (action) in
            self?.mapView.mapType = .satellite
        }))
        
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self] (action) in
            self?.mapView.mapType = .hybrid
        }))
        
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self] (action) in
            self?.mapView.mapType = .standard
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .green
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.capital = capital
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
