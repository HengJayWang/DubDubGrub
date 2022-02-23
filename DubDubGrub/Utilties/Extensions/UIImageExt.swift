//
//  UIImageExt.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/14.
//

import CloudKit
import UIKit

extension UIImage {
    
    func convertToCKAsset() -> CKAsset? {
        // Step.1 Get our apps base document directory url
        guard let urlPath   = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        // Step.2 Append some unique identifier for our profile image
        let fileUrl         = urlPath.appendingPathComponent("selectedAvartarImage")
        // Step.3 Write the image data to the location the address point to
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        // Step.4 Create our CKAsset with that fileURL
        do {
            try imageData.write(to: fileUrl)
            return CKAsset(fileURL: fileUrl)
        } catch {
            return nil
        }
    }
}
