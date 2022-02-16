//
//  ProfileModalView.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/16.
//

import SwiftUI

struct ProfileModalView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    XDismissButton()
                }
            }
            
            Text("Sean Allen")
                .bold()
                .font(.title2)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            
            Text("Test Company")
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .foregroundColor(.secondary)
            
            Text("This is my sample bio. Let's keep typing to see how long we can make this to padding 3 lines ...")
                .lineLimit(3)
                .padding()
            
            Spacer()
        }
        .frame(width: 300, height: 230)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .overlay {
            Image(uiImage: PlaceholderImage.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                .offset(y: -140)
        }
    }
}

struct ProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView()
    }
}
