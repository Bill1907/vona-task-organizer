import { TaskInput } from "@/components/task-input";
import { TaskResult } from "@/components/task-result";

export default function Home() {
  return (
    <div className="container mx-auto p-4">
      <TaskInput />
      <TaskResult />
    </div>
  );
}
