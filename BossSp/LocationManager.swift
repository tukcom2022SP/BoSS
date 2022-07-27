import Foundation
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    static let defaultDistance: CLLocationDistance = 1000000
    
    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.0422448, longitude: -102.0079053),
        //span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        latitudinalMeters: LocationManager.defaultDistance,
        longitudinalMeters: LocationManager.defaultDistance
    )

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            //self.location = location.coordinate
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                //span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                latitudinalMeters: Self.defaultDistance,
                longitudinalMeters: Self.defaultDistance
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Handle any errors here...
        print (error)
    }
}
