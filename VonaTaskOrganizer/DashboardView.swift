//
//  DashboardView.swift
//  VonaTaskOrganizer
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: TaskViewModel
    @State private var selectedTags: Set<String> = []

    var body: some View {
        VStack {
        
            // 전체(또는 선택된 tag 집합)에 따른 완료율 원형 그래프
            ZStack {
                // 배경 원
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.gray)

                // 완료율에 따른 진행도 원
                Circle()
                    .trim(from: 0.0, to: completionRate)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.easeInOut(duration: 0.5), value: completionRate)

                // 완료율 퍼센트 텍스트
                Text("\(Int(completionRate * 100))%")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .frame(width: 100, height: 100)
            .padding()
            .overlay(
                Text("Completion rate")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .offset(y: -50), // 그래프 위쪽에 텍스트를 배치하기 위해 오프셋 조절
                alignment: .top
            )

            // 태그 선택 UI (Chip 형태, 다중 선택용)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    // "All" chip
                    chipView(label: "All", isSelected: selectedTags.isEmpty) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedTags.removeAll()
                        }
                    }

                    ForEach(allTags, id: \.self) { tag in
                        chipView(label: tag, isSelected: selectedTags.contains(tag)) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                if selectedTags.contains(tag) {
                                    selectedTags.remove(tag)
                                } else {
                                    selectedTags.insert(tag)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom)

            // 필터링된 Task 리스트
            List(filteredTasks) { task in
                HStack {
                    Text(task.priority == .high ? "🔥" : (task.priority == .low ? "🥱" : "🙂"))
                    Text(task.title)

                    Spacer()

                    // 완료 상태에 따른 표시
                    if task.isCompleted {
                        Text("✔︎")
                            .foregroundColor(.green)
                    } else {
                        Text("❒")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding()
    }

    // 모든 태그 추출
    private var allTags: [String] {
        let tagsSet = Set(viewModel.tasks.flatMap { $0.tags })
        return Array(tagsSet)
    }

    // 다중 태그 필터 적용
    // selectedTags가 비어있으면 전체 task 반환
    // 비어있지 않으면 선택한 태그 중 하나라도 포함하는 task만 반환
    private var filteredTasks: [TaskItem] {
        if selectedTags.isEmpty {
            return viewModel.tasks
        } else {
            return viewModel.tasks.filter {
                let tagSet = Set($0.tags)
                return !tagSet.isDisjoint(with: selectedTags)
            }
        }
    }

    // 완료율 계산
    private var completionRate: Double {
        let tasksForFiltering = filteredTasks
        guard !tasksForFiltering.isEmpty else { return 0 }
        let completed = tasksForFiltering.filter { $0.isCompleted }.count
        return Double(completed) / Double(tasksForFiltering.count)
    }

    // Chip 형태로 태그 표시하기 위한 헬퍼 뷰
    @ViewBuilder
    private func chipView(label: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Text(label)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(isSelected ? Color.gray.opacity(0.3) : Color.clear)
            .cornerRadius(5)
            .overlay(
                Capsule().stroke(Color.green, lineWidth: isSelected ? 2 : 1)
            )
            .onTapGesture(perform: action)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}
