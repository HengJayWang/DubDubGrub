//
//  ProfileModalView.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/16.
//

import SwiftUI

struct ProfileModalView: View {
    
    @Binding var isShowingProfileModal: Bool
    var profile: DDGProfile
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    withAnimation { isShowingProfileModal = false }
                } label: {
                    XDismissButton()
                        .shadow(color: .secondary.opacity(0.7), radius: 5, x: 0, y: 5)
                }
            }
            
            Text(profile.firstName + " " + profile.lastName)
                .bold()
                .font(.title2)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            
            Text(profile.companyName)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .foregroundColor(.secondary)
            
            Text(profile.bio)
                .lineLimit(3)
                .padding()
            
            Spacer()
        }
        .frame(width: 300, height: 230)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.brandPrimary, lineWidth: 3)
        }
        .overlay {
            Image(uiImage: profile.createAvatarImage())
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(color: .secondary.opacity(0.7), radius: 5, x: 0, y: 6)
                .offset(y: -140)
        }
    }
}

struct ProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView(isShowingProfileModal: .constant(true),
                         profile: DDGProfile(record: MockData.profile))
            .preferredColorScheme(.dark)
    }
}
