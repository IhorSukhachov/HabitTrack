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
    var description: String
    var completionCount: Int = 0
}

@Observable
class Activities  {
    var activity = [Activity]()
}



struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingAdd = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (activities.activity) { activity in
                    NavigationLink(destination: Text(activity.description)) {
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


        
