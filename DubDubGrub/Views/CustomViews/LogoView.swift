//
//  LogoView.swift
//  DubDubGrub
//
//  Created by M200_Macbook_Pro on 2022/2/13.
//

import SwiftUI

struct LogoView: View {
    
    let frameWidth: CGFloat
    
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(frameWidth: 250)
    }
}
