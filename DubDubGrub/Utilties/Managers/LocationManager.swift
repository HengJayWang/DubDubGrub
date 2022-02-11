//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/11.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
