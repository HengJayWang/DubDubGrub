//
//  MockData.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/10.
//

import CloudKit

struct MockData {
    
    static var location: CKRecord {
        let record                          = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName]           = "Sean's Bar and Grill"
        record[DDGLocation.kAddress]        = "123 Main Street"
        record[DDGLocation.kDescription]    = "This is a testing description. Isn't it awesome. Not sure how long to make it to test the 3 lines limit."
        record[DDGLocation.kWebsiteURL]     = "https://seanallen.co"
        record[DDGLocation.kLocation]       = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber]    = "111-222-3333"
        
        return record
    }
    
    
    static var profile: CKRecord {
        let record                      = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName]   = "Sean"
        record[DDGProfile.kLastName]    = "Allen"
        record[DDGProfile.kCompanyName] = "Best Company."
        record[DDGProfile.kBio]         = "This is my sample bio. Let's keep typing to see how long we can make this to padding 3 lines ..."
        
        return record
    }
    
}
