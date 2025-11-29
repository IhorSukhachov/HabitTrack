//
//  AddActivity.swift
//  HabitTrack
//
//  Created by Ihor Sukhachov on 29.11.2025.
//

import SwiftUI

struct AddActivity: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    
    var activities: Activities
    
    var body: some View {
       
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Activity")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let item = Activity(title: title, description: description)
                            activities.activity.append(item)
                            dismiss()
                            
                        }
                    }
                }
            }
        }
    
}
#Preview {
    AddActivity(activities: Activities())
}
