//
//  ViewExt.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/9.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }
}
