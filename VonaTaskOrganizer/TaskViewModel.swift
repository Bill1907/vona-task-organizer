import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    
    // test용 초기 데이터
    init() {
        tasks = [
            TaskItem(title: "Buy groceries", dueDate: Date(), priority: .high, tags: ["Home"]),
            TaskItem(title: "Check emails", dueDate: Date(), priority: .medium, tags: ["Work"]),
            TaskItem(title: "Exercise", dueDate: Date().addingTimeInterval(3600*24), priority: .low, tags: ["Health"])
        ]
    }
    
    func addTask(title: String, dueDate: Date, priority: TaskItem.Priority = .medium, tags: [String] = []) {
        let newTask = TaskItem(title: title, dueDate: dueDate, priority: priority, tags: tags)
        tasks.append(newTask)
    }
}
