//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/9.
//

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        
        VStack(spacing: 12) {
            BannerImageView(image: viewModel.location.createBannerImage())
            
            HStack {
                AddressView(address: viewModel.location.address)
                Spacer()
            }
            .padding(.horizontal)
            
            DescriptionView(text: viewModel.location.description)
            
            ZStack {
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(.secondarySystemBackground) )

                HStack(spacing: 16) {
                    Button {
                        viewModel.getDirectionsToLocations()
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                    }
                    Link(destination: URL(string: viewModel.location.websiteURL)!) {
                        LocationActionButton(color: .brandPrimary, imageName: "network")
                    }
                    Button {
                        viewModel.callLocation()
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                    }
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .pink, imageName: "person.fill.checkmark")
                    }
                }
            }
            .padding(.horizontal)
            
            Text("Who's Here ?")
                .bold()
                .font(.title2)
            
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "firstName")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "firstName")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "firstName")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "firstName")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "firstName")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "firstName")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "firstName")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "firstName")
                }
            }
            
            Spacer()
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Dismiss") {
                    
                }
            }
        }
        
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation(record: MockData.location) ) )
        }
    }
}

struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
            Image(systemName: imageName)
                .foregroundColor(.white)
                .imageScale(.large)
        }
    }
}

struct FirstNameAvatarView: View {
    
    var image: UIImage
    let firstName: String
    
    var body: some View {
        VStack {
            AvatarView(image: image, size: 64)
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {
    
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(height: 120)
    }
}

struct AddressView: View {
    
    let address: String
    
    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct  DescriptionView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}