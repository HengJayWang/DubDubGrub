//
//  MapBalloon.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/22.
//

import SwiftUI

struct MapBalloon: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.minY))
        
        return path
    }
}

struct MapBalloon_Previews: PreviewProvider {
    static var previews: some View {
        MapBalloon()
            .frame(width: 300, height: 240)
            .foregroundColor(.brandPrimary)
    }
}
