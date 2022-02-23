//
//  CustomModifiers.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/9.
//

import SwiftUI

struct ProfileNameText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold, design: .rounded))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
    }
}
