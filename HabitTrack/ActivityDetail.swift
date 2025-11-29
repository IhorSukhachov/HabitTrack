//
//  ActivityDetail.swift
//  HabitTrack
//
//  Created by Ihor Sukhachov on 29.11.2025.
//

import SwiftUI

struct ActivityDetail: View {
    @Binding var activity: Activity

    var body: some View {
        VStack(spacing: 20) {
            Text(activity.description)
                .font(.body)
                .padding()

            Text("Completed: \(activity.completionCount)")
                .font(.title2)

            Button {
                activity.completionCount += 1
            } label: {
                Label("Mark Complete", systemImage: "checkmark.circle.fill")
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
        }
        .padding()
        .navigationTitle(activity.title)
    }
}

#Preview {
    ActivityDetail(
        activity: .constant(
            Activity(
                title: "Test Activity",
                description: "Just testing preview",
                completionCount: 5
            )
        )
    )
}
