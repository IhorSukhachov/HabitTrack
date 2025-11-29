//
//  ContentView.swift
//  HabitTrack
//
//  Created by Ihor Sukhachov on 28.11.2025.
//

import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct ContentView: View {
    @State private var activities: [Activity] = []
    @State private var showingAdd = false
    
    var body: some View {
        NavigationStack {
            List(activities) { activity in
                Text(activity.title)
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddActivityView { title, description in
                    let new = Activity(title: title, description: description)
                    activities.append(new)
                    showingAdd = false
                }
            }
        }
    }
}

struct AddActivityView: View {
    @State private var title = ""
    @State private var description = ""
    var onSave: (String, String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Activity")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        onSave(title, description)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
