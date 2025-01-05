//
//  ContentView.swift
//  RunLogger
//
//  Created by Javad Mammadbayli on 1/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Run]
    @State private var showNewRunView = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        RunSessionView(run: item)
                    } label: {
                        Text(
                            item.string
                        )
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Runs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNewRunView) {
                RunSessionView()
            }
        } detail: {
            Text("Select an item")
        }
        .onChange(of: items) {
            showNewRunView = false
        }
    }

    private func addItem() {
        withAnimation {
            showNewRunView.toggle()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Run.self, inMemory: true)
}
