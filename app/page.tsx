import { TaskInput } from "@/components/task-input";
import { TaskResult } from "@/components/task-result";

export default function Home() {
  return (
    <div className="container mx-auto p-4 flex flex-col gap-12">
      <TaskInput />
      <TaskResult />
    </div>
  );
}
