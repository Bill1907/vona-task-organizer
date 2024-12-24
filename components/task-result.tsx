"use client";
import { useTaskStore } from "@/store/useTaskStore";
import { TaskMarkdown } from "./task-markdown";

export function TaskResult() {
  const { isLoading, tasks, error } = useTaskStore();

  return (
    <div className="w-full max-w-4xl mx-auto">
      {isLoading && (
        <div className="animate-pulse text-center py-4">
          <p>Loading tasks...</p>
        </div>
      )}

      {error && (
        <div className="text-red-500 p-4 rounded-md bg-red-50 dark:bg-red-900/20">
          <p>Error: {error}</p>
        </div>
      )}

      {tasks.map((task, idx) => (
        <TaskMarkdown task={task} idx={idx} key={`${task.type}-${idx}`} />
      ))}
    </div>
  );
}
