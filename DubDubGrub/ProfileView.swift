//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/8.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName    = ""
    @State private var lastName     = ""
    @State private var companyName  = ""
    @State private var bio          = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                ZStack {
                    AvatarView(size: 84)
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.white)
                        .imageScale(.small)
                        .offset(y: 30)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    TextField("First Name", text: $firstName)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    TextField("Last Name", text: $lastName)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    TextField("Company Name", text: $lastName)
                }
                
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .padding(.horizontal)
            
            VStack {
                HStack {
                    Text("Bio: ")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    +
                    Text("\(100 - bio.count)")
                        .bold()
                        .font(.callout)
                        .foregroundColor(bio.count <= 100 ? .brandPrimary : Color(.systemPink))
                    +
                    Text(" characters remain")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Label("Check Out", systemImage: "mappin.and.ellipse")
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.pink)
                            .cornerRadius(4)
                    }
                }

                TextEditor(text: $bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(.secondary, lineWidth: 2))
            }
            .padding()
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Save Profile")
                    .bold()
                    .frame(width: 280, height: 44)
            }
            .buttonStyle(.borderedProminent)
            
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
