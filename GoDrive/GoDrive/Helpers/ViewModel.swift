//
//  ViewModel.swift
//
//  Created by Rithik Kumar on 7/27/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Firebase
import CoreLocation

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import CoreLocation

class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var counter: Int = 0
    @Published var userLocation: CLLocation?
    
    private var db = Firestore.firestore()
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        fetchCounter()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }

    func fetchCounter() {
        // Listen for real-time updates to the counter
        db.collection("counters").document("globalCounter").addSnapshotListener { documentSnapshot, error in
            if let document = documentSnapshot, document.exists {
                self.counter = document.get("count") as? Int ?? 0
            } else {
                print("Document does not exist or failed to fetch counter")
            }
        }
    }

    func incrementCounter() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // Handle the case when the user is not authenticated
            return
        }
        
        // Get the current location
        guard let location = self.userLocation else {
            print("Location not available yet")
            return
        }

        let db = Firestore.firestore()
        let timestamp = Timestamp(date: Date())
        let geoPoint = GeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let counterData: [String: Any] = [
            "createdAt": timestamp,
            "location": geoPoint // Storing the user's location as GeoPoint
        ]
        
        db.collection("locations").document(currentUserUID).collection("counter").addDocument(data: counterData) { error in
            if let error = error {
                print("Error adding data: \(error.localizedDescription)")
            } else {
                print("Counter and location successfully saved!")
            }
        }
        
    }
}
