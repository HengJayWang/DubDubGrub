//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/16.
//

import SwiftUI
import MapKit
import CloudKit

enum CheckInStatus { case checkedIn, checkedOut }

final class LocationDetailViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var isShowingProfileModal = false
    
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
    
    func updateCheckInStatus(to checkedInStatus: CheckInStatus) {
        
        // Step 1. Retrieve the  DDGProfile
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            // show an alert that the user profile not been created
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
            case .success(let record):
                // Step 2. Create a reference to the location
                switch checkedInStatus {
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                }
                // Step 3. Save the updated profile to CloudKit
                CloudKitManager.shared.save(record: record) { result in
                    // update our checkedInProfile array
                    switch result {
                    case .success(_):
                        print("✅ Checked In/Out Successfully!")
                    case .failure(_):
                        print("⛔️ save record Failed!")
                    }
                }
            case .failure(_):
                print("⛔️ fetch record Failed!")
            }
        }
    }
}
