//
//  CloudtKitManager.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/11.
//

import CloudKit

struct CloudtKitManager {
    
    static func getLocations(completed: @escaping (Result<[DDGLocation], Error>) -> Void) {
        
        let sortDescriptor = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescriptor]

        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard error == nil else {
                completed(.failure(error!))
                return
            }
            
            guard let records = records else { return }
            
            let locations = records.map { $0.convertToDDGLocation() }
            
            completed(.success(locations))
        }
    }
}
