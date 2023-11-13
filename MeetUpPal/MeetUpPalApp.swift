//
//  MeetUpPalApp.swift
//  MeetUpPal
//
//  Created by Peter Molnar on 29/08/2022.
//

import SwiftUI

@main
struct MeetUpPalApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
