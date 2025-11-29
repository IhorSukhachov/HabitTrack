//
//  ContentView.swift
//  HabitTrack
//
//  Created by Ihor Sukhachov on 28.11.2025.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    let id = UUID()
    let title: String
    var description: String
    var completionCount: Int = 0
    
    init(id: UUID = UUID(), title: String, description: String, completionCount: Int = 0) {
            self.title = title
            self.description = description
            self.completionCount = completionCount
        }
}

@Observable
class Activities {
    var activity = [Activity]() {
        didSet {
            save()
        }
    }
    
    let saveKey = "ActivitiesData"
    
    init() {
        load()
    }
    
    // Save to UserDefaults
    func save() {
        if let encoded = try? JSONEncoder().encode(activity) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    // Load from UserDefaults
    func load() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Activity].self, from: savedData) {
            activity = decoded
        }
    }
}



struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingAdd = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach ($activities.activity) { $activity in
                    NavigationLink(destination: ActivityDetail(activity: $activity)) {
                        Text(activity.title)
                    }
                }.onDelete(perform: removeItems)
                
            }.navigationTitle("My activities")
                .toolbar {
                    Button("Add Activity", systemImage: "plus") {
                        showingAdd = true
                    }
                }
        }.sheet(isPresented: $showingAdd) {
             AddActivity(activities: activities)
         }
    }
    func removeItems(at offsets: IndexSet) {
        activities.activity.remove(atOffsets: offsets)
       }
}

#Preview {
    ContentView()
}


        
