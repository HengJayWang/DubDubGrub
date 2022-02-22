//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/9.
//

import SwiftUI

struct LocationCell: View {
    
    let location: DDGLocation
    let profiles: [DDGProfile]
    
    var body: some View {
        HStack {
            Image(uiImage: location.createSquareImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                if profiles.isEmpty {
                    Text("Nobody's Checked In")
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                } else {
                    HStack {
                        ForEach(profiles.indices, id: \.self) { index in
                            if index <= 3 {
                                AvatarView(image: profiles[index].createAvatarImage(), size: 35)
                                    .shadow(color: .secondary, radius: 3, y: 1)
                            } else if index == 4 {
                                AdditionalProfilesView(number: profiles.count - 4)
                                    .shadow(color: .secondary, radius: 3, y: 1)
                            }
                        }
                    }
                }
            }
            .padding(.leading)
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: DDGLocation(record: MockData.location), profiles: [])
    }
}

struct AdditionalProfilesView: View {
    
    var number: Int
    
    var body: some View {
        Text("+\(number)")
            .font(.system(size: 14, weight: .semibold))
            .frame(width: 35, height: 35)
            .foregroundColor(.white)
            .background(Color.brandPrimary)
            .clipShape(Circle())
    }
}
