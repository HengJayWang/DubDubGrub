//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/11.
//

import MapKit
import CloudKit

final class LocationMapViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID : Int] = [:]
    @Published var isShowingDetailView = false
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516,
                                                                              longitude: -121.891054),
                                               span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                      longitudeDelta: 0.01))
 
    func getLocations(for locationManager: LocationManager) {
        CloudKitManager.shared.getLocations { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
    
    func getCheckedInCounts() {
        CloudKitManager.shared.getCheckedInProfilesCount { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkedInProfiles):
                    self.checkedInProfiles = checkedInProfiles
                case .failure(_):
                    //alertItem = AlertContext.unableToGetLocations
                    break
                }
            }
        }
    }
}
