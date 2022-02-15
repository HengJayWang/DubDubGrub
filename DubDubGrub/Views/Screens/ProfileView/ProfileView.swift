//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/8.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                ZStack {
                    AvatarView(image: viewModel.avatar, size: 84)
                    EditImage()
                }
                .onTapGesture { viewModel.isShowingPhotoPicker = true }
                
                VStack(alignment: .leading, spacing: 2) {
                    TextField("First Name", text: $viewModel.firstName).profileNameStyle()
                    TextField("Last Name", text: $viewModel.lastName).profileNameStyle()
                    TextField("Company Name", text: $viewModel.companyName)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .padding(.horizontal)
            
            VStack {
                HStack {
                    
                    CharactersRemainView(bioCount: viewModel.bio.count)
                    
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
                
                TextEditor(text: $viewModel.bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(.secondary, lineWidth: 2))
            }
            .padding()
            
            Spacer()
            
            Button {
                viewModel.profileContext == .create ? viewModel.createProfile() : viewModel.updateProfile()
            } label: {
                DDGButton(title: viewModel.profileContext == .create ? "Create Profile" : "Update Profile",
                          color: .brandPrimary)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
            
        }
        .overlay {
            if viewModel.isLoading { LoadingView() }
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear { viewModel.getProfile() }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
        }
        
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
