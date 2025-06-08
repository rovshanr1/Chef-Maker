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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NotificationView(appState: AppState())
        .environmentObject(AppState())
}
