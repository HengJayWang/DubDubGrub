//
//  AppTabView.swift
//  DubDubGrub
//
//  Created by M100-M1MacMini on 2022/2/8.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject private var viewModel = AppTabViewModel()
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
    }
    
    var body: some View {
        TabView {
            LocationMapView()
                .tabItem { Label("Map", systemImage: "map") }
            LocationListView()
                .tabItem { Label("Locations", systemImage: "building") }
            NavigationView { ProfileView() }
                .tabItem { Label("Profile", systemImage: "person") }
                .navigationViewStyle(StackNavigationViewStyle())
        }
        .onAppear {
            CloudKitManager.shared.getUserRecord()
            viewModel.runStartupChecks()
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView,
               onDismiss: viewModel.checkLocationServicesIsEnabled) {
            OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
