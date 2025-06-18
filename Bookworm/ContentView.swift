//
//  ContentView.swift
//  Bookworm
//
//  Created by HiRO on 13/06/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var books: [Book]
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            Text("Count: \(books.count)")
                .navigationTitle("BookWorm")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
