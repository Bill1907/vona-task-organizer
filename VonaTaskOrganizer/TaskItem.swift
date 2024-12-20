//
//  TaskItem.swift
//  VonaTaskOrganizer
//
//  Created by Boseong Kim on 12/20/24.
//

import Foundation

struct TaskItem: Identifiable {
    enum Priority: Int {
        case low, medium, high
    }
    
    let id: UUID
    var title: String
    var dueDate: Date
    var isCompleted: Bool
    var content: String
    var priority: Priority
    var tags: [String]

    init(title: String,
         dueDate: Date,
         isCompleted: Bool = false,
         content: String = "",
         priority: Priority = .medium,
         tags: [String] = []) {
        self.id = UUID()
        self.title = title
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.content = content
        self.priority = priority
        self.tags = tags
    }
}
