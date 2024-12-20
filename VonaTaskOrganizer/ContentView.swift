//
//  ContentView.swift
//  VonaTaskOrganizer
//
//  Created by Boseong Kim on 12/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()
    
    var body: some View {
        VStack {
            Text("Today's Tasks").font(.title)
            
            List(viewModel.tasks) { task in
                HStack {
                    Text(task.title)
                    Spacer()
                    Text(task.priority == .high ? "🔥" : (task.priority == .low ? "🥱" : "🙂"))
                }
            }
            
            Button("Add Sample Task") {
                viewModel.addTask(title: "New Task", dueDate: Date())
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

