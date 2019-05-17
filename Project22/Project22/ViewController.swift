//
//  ViewController.swift
//  Project22
//
//  Created by Shawn Bierman on 5/12/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var beaconIdLabel: UILabel!

    var locationManager: CLLocationManager?
    var beaconDetected: Bool = false {
        didSet {
            showAlert(title: "Beacon Detected", message: "We've found our first beacon. Hoora!")
        }
    }

    let circle: UIView = {
        let circle = UIView()
            circle.layer.cornerRadius = 128
            circle.layer.borderColor = UIColor.black.cgColor
            circle.layer.borderWidth = 1
            circle.backgroundColor = UIColor.clear
            circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()

        view.backgroundColor = .white

        view.addSubview(circle)

        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circle.widthAnchor.constraint(equalToConstant: 256),
            circle.heightAnchor.constraint(equalToConstant: 256)
            ])
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // can this device detect if a beacon exists or not?
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                // can we detect how far away a beacon is from us?
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }

    func startScanning() {
        let uuid1 = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let uuid2 = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!
        let uuid3 = UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!

        let beaconRegion1 = CLBeaconRegion(proximityUUID: uuid1, major: 123, minor: 456, identifier: "beaconRegion1")
        let beaconRegion2 = CLBeaconRegion(proximityUUID: uuid2, major: 123, minor: 456, identifier: "beaconRegion2")
        let beaconRegion3 = CLBeaconRegion(proximityUUID: uuid3, major: 123, minor: 456, identifier: "beaconRegion3")

        locationManager?.startMonitoring(for: beaconRegion1)
        locationManager?.startRangingBeacons(in: beaconRegion1)

        locationManager?.startMonitoring(for: beaconRegion2)
        locationManager?.startRangingBeacons(in: beaconRegion2)

        locationManager?.startMonitoring(for: beaconRegion3)
        locationManager?.startRangingBeacons(in: beaconRegion3)
    }

    func update(distance: CLProximity, id: UUID?) {

            if let id = id { dump("Found \(id)") }

            switch distance {
            case .far:
                animateCircle(with: .blue, for: "FAR", having: id?.uuidString, duration: 2)

            case .near:
                animateCircle(with: .orange, for: "NEAR", having: id?.uuidString, duration: 1.0)

            case .immediate:
                animateCircle(with: .red, for: "RIGHT HERE", having: id?.uuidString, duration: 0.2)

            default:
                animateCircle(with: .white, for: "UNKNOWN", having: nil, duration: nil)
        }
    }

    fileprivate func animateCircle(with color: UIColor, for distance: String, having uuid: String?, duration: Double?) {

        if let id = uuid {
            self.beaconIdLabel.text = id
        } else {
            self.beaconIdLabel.text = ""
        }

        self.distanceReading.text = distance
        self.view.backgroundColor = color

        if let duration = duration {
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: { [weak self] in
                self?.circle.transform = CGAffineTransform(scaleX: 2, y: 2)
            })
            self.circle.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        beacons.forEach { (beacon) in
            if beacon.proximity != .unknown {
                update(distance: beacon.proximity, id: beacon.proximityUUID)
            } else {
                update(distance: .unknown, id: nil)
            }
        }
    }

    fileprivate func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}
