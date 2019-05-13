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

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()

        view.backgroundColor = .white
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

        UIView.animate(withDuration: 1) {

            if let id = id { dump("Found \(id)") }

            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                self.beaconIdLabel.text = id?.uuidString

            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                self.beaconIdLabel.text = id?.uuidString

            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                self.beaconIdLabel.text = id?.uuidString

            default:
                self.view.backgroundColor = .white
                self.distanceReading.text = "UNKNOWN"
                self.beaconIdLabel.text = ""
            }
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
