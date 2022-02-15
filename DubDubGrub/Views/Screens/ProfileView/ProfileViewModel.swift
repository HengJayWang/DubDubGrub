//
//  ProfileViewModel.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/15.
//

import CloudKit

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName            = ""
    @Published var lastName             = ""
    @Published var companyName          = ""
    @Published var bio                  = ""
    @Published var avatar               = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var alertItem: AlertItem?
    
    func isValidProfile() -> Bool {
        
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        // Step.1 Create our CKRecord from the profile view
        let profileRecord = createProfileRecord()
        
        // Step.2 Get our UserRecordID from the Container
        // Step.3 Get UserRecord from the Public Database
        guard let userRecord = CloudtKitManager.shared.userRecord else {
            // show an alert
            return
        }
        
        // Step.4 Create reference on UserRecord to the DDGProfile we created
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        
        // Step.5 Create a CKOperation to save our User and Profile Records
        CloudtKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            switch result {
            case .success(_):
                // show alert
                break
            case .failure(_):
                // show alert
                break
            }
        }
    }
    
    func getProfile() {
        
        guard let userRecord = CloudtKitManager.shared.userRecord else {
            // show an alert
            return
        }
        
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
            return
        }
        
        let profileRecordID = profileReference.recordID
        
        CloudtKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async {  [self] in
                switch result {
                case .success(let record):
                    let profile = DDGProfile(record: record)
                    firstName   = profile.firstName
                    lastName    = profile.lastName
                    companyName = profile.companyName
                    bio         = profile.bio
                    avatar      = profile.createAvatarImage()
                case .failure(_):
                    // show alert
                    break
                }
            }
        }
    }
    
    private func  createProfileRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName]    = firstName
        profileRecord[DDGProfile.kLastName]     = lastName
        profileRecord[DDGProfile.kCompanyName]  = companyName
        profileRecord[DDGProfile.kBio]          = bio
        profileRecord[DDGProfile.kAvatar]       = avatar.convertToCKAsset()
        return profileRecord
    }
}
