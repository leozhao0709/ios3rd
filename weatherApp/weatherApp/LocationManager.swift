//
// Created by Lei Zhao on 11/6/20.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {

    private var locationManager: CLLocationManager = CLLocationManager()
    static let sharedInstance: LocationManager = LocationManager()

    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    private override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        // ask permission
        self.locationManager.requestWhenInUseAuthorization()

        // request location once
        self.locationManager.requestLocation()

//        self.locationManager.startUpdatingLocation()
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
