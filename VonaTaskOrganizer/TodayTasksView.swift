//
//  TodayTasksView.swift
//  VonaTaskOrganizer
//
//  Created by Boseong Kim on 12/20/24.
//

import SwiftUI

struct TodayTasksView: View {
    @ObservedObject var viewModel: TaskViewModel
    @State private var newTitle: String = ""
    @State private var newPriority: TaskItem.Priority = .medium
    @State private var newTags: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Add Today's Task")
                .font(.title)

            TextField("Title", text: $newTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Picker("Priority", selection: $newPriority) {
                Text("Low").tag(TaskItem.Priority.low)
                Text("Medium").tag(TaskItem.Priority.medium)
                Text("High").tag(TaskItem.Priority.high)
            }
            .pickerStyle(SegmentedPickerStyle())

            TextField("Tags (comma separated)", text: $newTags)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Add Task") {
                let tagsArray = newTags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                viewModel.addTask(title: newTitle, dueDate: Date(), priority: newPriority, tags: tagsArray)
                newTitle = ""
                newTags = ""
                newPriority = .medium
            }

            Spacer()

            Text("Today's Tasks")
                .font(.headline)

            List(todaysTasks) { task in
                HStack {
                    Text(task.title)
                    Spacer()
                    Text(task.priority == .high ? "🔥" : (task.priority == .low ? "🥱" : "🙂"))
                }
            }
        }
        .padding()
    }

    private var todaysTasks: [TaskItem] {
        viewModel.tasks.filter {
            Calendar.current.isDate($0.dueDate, inSameDayAs: Date())
        }
    }
}
