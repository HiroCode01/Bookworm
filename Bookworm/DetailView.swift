//
//  DetailView.swift
//  Bookworm
//
//  Created by HiRO on 20/06/25.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var isShowingAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()

                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            VStack {
                Text(book.author)
                    .font(.title.bold())
                    .foregroundStyle(.secondary)
                
                Text(book.review)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .font(.title3)
                
                RatingView(rating: .constant(book.rating))
                    .font(.title)
            
                Text(book.date.formatted(date: .long, time: .shortened))
                    .padding()
            }
            .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $isShowingAlert) {
            Button("Delete", role: .destructive) { deleteBook()}
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Trash", systemImage: "trash") {
                    isShowingAlert = true
                }
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Horror", review: "Amazing book", rating: 4, date: Date.now)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
