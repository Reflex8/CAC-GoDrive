//
//  ContentView.swift
//  Rand
//
//  Created by Rithik K on 10/23/24.
//

import SwiftUI


struct ContentView: View
{
    @StateObject var viewModel: MyModel = MyModel()
    
    @EnvironmentObject var tabModel: tabModel
//    @EnvironmentObject var viewModel : AuthViewModel
    
    
//    let collection: [Collection]
    
    
    var body : some View {
        
        
        if tabModel.selectedTab == "home"
        {
            HomePageView()
        }
        else if tabModel.selectedTab == "map"
        {
            MapView()
        }
        else if tabModel.selectedTab == "profile"
        {
            ProfileView()
        }
        TabBar()
            .environmentObject(tabModel)
    }
}

    
