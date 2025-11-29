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
                }
                
            }.navigationTitle("My activities")
                .toolbar {
                    Button("Add Activity", systemImage: "plus") {
                        showingAdd = true
                    }
                }
        }.sheet(isPresented: $showingAdd) {
            // AddActivity(activities: activities)
         }
    }
}

#Preview {
    ContentView()
}


        
