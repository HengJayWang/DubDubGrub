//
//  DDGLocation.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/10.
//

import Foundation
import CloudKit

struct DDGLocation {
    static let kName        = "name"
    static let kDescription = "description"
    static let kSquareAsset = "squareAsset"
    static let kBannerAsset = "bannerAsset"
    static let kAddress     = "address"
    static let kLocation    = "location"
    static let kWebsiteURL  = "websiteURL"
    static let kPhoneNumber = "phoneNumber"

    let ckRecordID: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset!
    let bannerAsset: CKAsset!
    let address: String
    let location: CLLocation
    let websiteURL: String
    let phoneNuber: String
    
    init(record: CKRecord) {
        ckRecordID  = record.recordID
        name        = record[DDGLocation.kName] as? String ?? "N/A"
        description = record[DDGLocation.kDescription] as? String ?? "N/A"
        squareAsset = record[DDGLocation.kSquareAsset] as? CKAsset
        bannerAsset = record[DDGLocation.kBannerAsset] as? CKAsset
        address     = record[DDGLocation.kAddress] as? String ?? "N/A"
        location    = record[DDGLocation.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL  = record[DDGLocation.kWebsiteURL] as? String ?? "N/A"
        phoneNuber  = record[DDGLocation.kPhoneNumber] as? String ?? "N/A"
    }
}
