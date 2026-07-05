import type { Plugin } from "@opencode-ai/plugin"
import { readFileSync } from "fs"
import { resolve, dirname } from "path"

function parseEnv(content: string): Record<string, string> {
  const vars: Record<string, string> = {}
  for (const line of content.split("\n")) {
    const trimmed = line.trim()
    if (!trimmed || trimmed.startsWith("#")) continue
    const eq = trimmed.indexOf("=")
    if (eq === -1) continue
    let key = trimmed.slice(0, eq).trim()
    let val = trimmed.slice(eq + 1).trim()
    if (key.startsWith("export ")) key = key.slice(7).trim()
    if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'")))
      val = val.slice(1, -1)
    vars[key] = val
  }
  return vars
}

function findEnvFile(): string | null {
  let dir = process.cwd()
  for (let i = 0; i < 10; i++) {
    const candidate = resolve(dir, ".env")
    try {
      if (readFileSync(candidate, "utf-8")) return candidate
    } catch {}
    const parent = dirname(dir)
    if (parent === dir) break
    dir = parent
  }
  return null
}

export const LoadEnvPlugin: Plugin = async () => {
  const envPath = findEnvFile()
  if (!envPath) return {}

  const content = readFileSync(envPath, "utf-8")
  const parsed = parseEnv(content)

  for (const [key, val] of Object.entries(parsed)) {
    if (!process.env[key]) process.env[key] = val
  }

  return {
    "shell.env": async (_input, output) => {
      for (const [key, val] of Object.entries(parsed)) {
        output.env[key] = val
      }
    },
  }
}
