//
//  DataController.swift
//  MeetUpPal
//
//  Created by Peter Molnar on 03/04/2023.
//

import Foundation
import CoreData

final class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "MeetUpPal")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
