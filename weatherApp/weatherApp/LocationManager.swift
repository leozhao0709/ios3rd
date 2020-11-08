//
// Created by Lei Zhao on 11/6/20.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {

    private var locationManager: CLLocationManager = CLLocationManager()
    static var manager: LocationManager?

    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        // ask permission
        self.locationManager.requestWhenInUseAuthorization()

        // request location once
        self.locationManager.requestLocation()

//        self.locationManager.startUpdatingLocation()
    }

    static func sharedInstance() -> LocationManager {
        guard let manager = self.manager else {
            return LocationManager()
        }
        return manager
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        print("....location update...")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}
