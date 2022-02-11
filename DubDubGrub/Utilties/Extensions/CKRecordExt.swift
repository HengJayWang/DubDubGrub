//
//  CKRecordExt.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/11.
//

import CloudKit

extension CKRecord {
    func convertToDDGLocation() -> DDGLocation { DDGLocation(record: self) }
    func convertToDDGProfile() -> DDGProfile { DDGProfile(record: self) }
}
