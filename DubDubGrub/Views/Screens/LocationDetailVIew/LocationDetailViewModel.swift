//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/16.
//

import SwiftUI
import MapKit

final class LocationDetailViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    let location: DDGLocation
    
    init(location: DDGLocation) {
        self.location = location
    }
    
    func getDirectionsToLocations() {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapitem = MKMapItem(placemark: placemark)
        mapitem.name = location.name
        mapitem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    func callLocation() {
        guard let url = URL(string: "tel://\(location.phoneNumber)") else {
            alertItem = AlertContext.invalidPhoneNumber
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // if device not support phone call: show some alert
            alertItem = AlertContext.notSupportPhoneCall
        }
    }
}
