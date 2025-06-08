//
//  NotificationView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 08.05.25.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var viewModel: NotificationViewModel
    @EnvironmentObject var appState: AppState
    
    init(appState: AppState){
        _viewModel = StateObject(wrappedValue: NotificationViewModel())
    }
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false) {
                VStack{
                    
                }
                .background(Color.appsBackground)
            }
            
        }
    }
}

#Preview {
    NotificationView(appState: AppState())
        .environmentObject(AppState())
}
