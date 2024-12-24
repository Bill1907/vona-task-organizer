"use client";
import { useTaskStore } from "@/store/useTaskStore";
import ReactMarkdown from "react-markdown";
import { AnimatePresence, motion } from "motion/react";

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
        <details
          key={`${task.type}-${idx}`}
          className="mb-4 border rounded-lg overflow-hidden dark:border-gray-700 group"
        >
          <summary className="cursor-pointer p-4 hover:bg-gray-50 dark:hover:bg-gray-800/50 font-medium flex items-center">
            <span className="mr-2 flex items-center">
              <motion.span
                initial={false}
                animate={{ rotate: 0 }}
                variants={{
                  open: { rotate: 90 },
                  closed: { rotate: 0 },
                }}
                className="inline-block mr-2 transition-transform group-open:rotate-90"
              >
                ▶
              </motion.span>
              {task.type} {idx + 1}
            </span>
          </summary>
          <AnimatePresence>
            <motion.div
              initial={{ height: 0, opacity: 0 }}
              animate={{ scale: 1 }}
              exit={{ scale: 0 }}
              transition={{ duration: 1 }}
              className="p-4 bg-white dark:bg-gray-900 border-t dark:border-gray-700 prose prose-sm dark:prose-invert max-w-none"
            >
              <ReactMarkdown
                components={{
                  h1: ({ children }) => (
                    <h1 className="text-xl font-bold mb-4 dark:text-gray-100">
                      {children}
                    </h1>
                  ),
                  h2: ({ children }) => (
                    <h2 className="text-lg font-semibold mb-3 dark:text-gray-200">
                      {children}
                    </h2>
                  ),
                  h3: ({ children }) => (
                    <h3 className="text-md font-semibold mb-2 dark:text-gray-300">
                      {children}
                    </h3>
                  ),
                  ul: ({ children }) => (
                    <ul className="list-disc pl-6 mb-4 dark:text-gray-300">
                      {children}
                    </ul>
                  ),
                  li: ({ children }) => (
                    <li className="mb-1 dark:text-gray-300">{children}</li>
                  ),
                  code: ({ children }) => (
                    <code className="bg-gray-100 dark:bg-gray-800 px-1 rounded dark:text-gray-200">
                      {children}
                    </code>
                  ),
                  p: ({ children }) => (
                    <p className="dark:text-gray-300">{children}</p>
                  ),
                }}
              >
                {task.text}
              </ReactMarkdown>
            </motion.div>
          </AnimatePresence>
        </details>
      ))}
    </div>
  );
}
