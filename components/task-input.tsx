"use client";
import { useState } from "react";
import { Button } from "./ui/button";
import { Textarea } from "./ui/textarea";
import { useTaskStore } from "@/store/useTaskStore";

export function TaskInput() {
  const { addTask, setLoading } = useTaskStore();
  const [task, setTask] = useState("");

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);
    const response = await fetch("/api/task", {
      method: "POST",
      body: JSON.stringify({
        task: task,
      }),
    });
    const data = await response.json();

    const { type, text } = data.content[0];
    console.log(type, text);
    addTask({ type, text });
    setLoading(false);
  };
  return (
    <form className="flex flex-col gap-2" onSubmit={handleSubmit}>
      <Textarea
        placeholder="오늘 할 일을 입력해주세요"
        value={task}
        onChange={(e) => setTask(e.target.value)}
      />
      <Button type="submit">Add</Button>
    </form>
  );
}
