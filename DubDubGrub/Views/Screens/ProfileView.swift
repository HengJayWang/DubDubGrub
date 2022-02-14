//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/8.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName            = ""
    @State private var lastName             = ""
    @State private var companyName          = ""
    @State private var bio                  = ""
    @State private var avatar               = PlaceholderImage.avatar
    @State private var isShowingPhotoPicker = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                ZStack {
                    AvatarView(image: avatar, size: 84)
                    EditImage()
                }
                .onTapGesture { isShowingPhotoPicker = true }
                
                VStack(alignment: .leading, spacing: 2) {
                    TextField("First Name", text: $firstName)
                        .profileNameStyle()
                    TextField("Last Name", text: $lastName)
                        .profileNameStyle()
                    TextField("Company Name", text: $companyName)
                }
                
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .padding(.horizontal)
            
            VStack {
                HStack {
                    
                    CharactersRemainView(bioCount: bio.count)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Label("Check Out", systemImage: "mappin.and.ellipse")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
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
                createProfile()
            } label: {
                DDGButton(title: "Create Profile", color: .brandPrimary)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
            
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(image: $avatar)
        }
        
    }
    
    func isValidProfile() -> Bool {
        
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count < 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        // Create our profile send it to cloudkit
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}


struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .foregroundColor(.white)
            .imageScale(.small)
            .offset(y: 30)
    }
}

struct CharactersRemainView: View {
    
    var bioCount: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundColor(.secondary)
        +
        Text("\(100 - bioCount)")
            .bold()
            .font(.callout)
            .foregroundColor(bioCount <= 100 ? .brandPrimary : Color(.systemPink))
        +
        Text(" characters remain")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}
