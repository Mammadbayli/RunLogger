//
//  RunLoggerApp.swift
//  RunLogger
//
//  Created by Javad Mammadbayli on 1/3/25.
//

import SwiftUI
import SwiftData

@main
struct RunLoggerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Run.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
