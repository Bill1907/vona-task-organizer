import { Anthropic } from "@anthropic-ai/sdk";
import { NextResponse } from "next/server";
import { readFileSync } from "fs";
import path from "path";

const anthropic = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY,
});

// 프롬프트 파일 읽기
const promptPath = path.join(process.cwd(), "prompts", "task-system.md");
const systemPrompt = readFileSync(promptPath, "utf-8");

export async function POST(req: Request) {
  try {
    const { task } = await req.json();

    const response = await anthropic.messages.create({
      model: "claude-3-sonnet-20240229",
      max_tokens: 1024,
      system: systemPrompt,
      messages: [{ role: "user", content: task }],
    });

    return NextResponse.json(response);
  } catch (error) {
    return NextResponse.json(
      { error: "Error processing your request" },
      { status: 500 }
    );
  }
}
