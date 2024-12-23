import { create } from "zustand";

type Task = {
  type: string;
  text: string;
};

interface TaskStore {
  tasks: Task[];
  isLoading: boolean;
  error: string | null;
  addTask: (task: Task) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  clearTasks: () => void;
}

export const useTaskStore = create<TaskStore>((set) => ({
  tasks: [],
  isLoading: false,
  error: null,
  addTask: (task: Task) =>
    set((state) => ({
      tasks: [...state.tasks, task],
    })),
  setLoading: (loading) =>
    set(() => ({
      isLoading: loading,
    })),
  setError: (error) =>
    set(() => ({
      error,
    })),
  clearTasks: () => set(() => ({ tasks: [] })),
}));
