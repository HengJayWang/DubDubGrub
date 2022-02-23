//
//  LocationListViewModel.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/22.
//

import Foundation
import CloudKit

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID : [DDGProfile]] = [:]
    
    func getCheckedINProfilesDictionary() {
        CloudKitManager.shared.getCheckedInProfilesDictionary { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkedInProfiles):
                    self.checkedInProfiles = checkedInProfiles
                case .failure(_):
                    print("Error getting back dictionary")
                }
            }
        }
    }
}
