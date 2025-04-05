//
//  Chef_MakerApp.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.04.25.
//

import SwiftUI

@main
struct Chef_MakerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
