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
              bio.count < 100 else { return false }
        
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
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            // Step.3 Get UserRecord from the Public Database
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                // Step.4 Create reference on UserRecord to the DDGProfile we created
                userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
                
                // Step.5 Create a CKOperation to save our User and Profile Records
                let operation = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
                    guard let savedRecords = savedRecords, error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    print("CloudKit savedRecords: \(savedRecords)")
                }
                
                CKContainer.default().publicCloudDatabase.add(operation)
            }
        }
    }
    
    func getProfile() {
        // Step.1
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            // Step.2
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                let profileReference = userRecord["userProfile"] as! CKRecord.Reference
                let profileRecordID = profileReference.recordID
                
                CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileRecordID) { profileRecord, error in
                    guard let profileRecord = profileRecord, error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    DispatchQueue.main.async {  [self] in
                        let profile = DDGProfile(record: profileRecord)
                        firstName   = profile.firstName
                        lastName    = profile.lastName
                        companyName = profile.companyName
                        bio         = profile.bio
                        avatar      = profile.createAvatarImage()
                    }
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
