//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Fazliddin Abdazimov on 13/06/25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
