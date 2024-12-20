//
//  ContentView.swift
//  VonaTaskOrganizer
//
//  Created by Boseong Kim on 12/20/24.
//

import SwiftUI

enum ViewSection: Hashable {
    case dashboard
    case today
}

struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var selectedSection: ViewSection? = .dashboard

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedSection) {
                Section("Menu") {
                    NavigationLink(value: ViewSection.dashboard) {
                        Label("Dashboard", systemImage: "calendar")
                    }
                    NavigationLink(value: ViewSection.today) {
                        Label("Today's Tasks", systemImage: "square.and.pencil")
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("VonaTaskOrganizer")
        } detail: {
            switch selectedSection {
            case .dashboard:
                DashboardView(viewModel: viewModel)
            case .today:
                TodayTasksView(viewModel: viewModel)
            case .none:
                Text("Select an item")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
        }
    }
}


#Preview {
    ContentView()
}

