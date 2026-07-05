# Scrum & Agile Integration

## Overview

The workspace supports Scrum/Agile workflows at the project level. Each project can define sprints, backlogs, and retrospectives within its own structure.

## Sprint Structure

Each project may contain:

```
projects/<project>/
├── AGENTS.md                    # Project context (epic-level)
├── sprints/
│   ├── sprint-01/
│   │   ├── sprint-goals.md     # Sprint goal and scope
│   │   ├── tasks.md            # Task breakdown
│   │   ├── progress.md         # Daily progress (AI agent log)
│   │   └── retrospective.md    # Retro notes (continuous improvement)
│   ├── sprint-02/
│   │   └── ...
│   └── current/                # Symlink to current sprint
└── prompts/
    └── daily-standup.md        # Standup prompt for AI agent
```

## Sprint Workflow

### Sprint Planning
1. Product Owner writes feature specs
2. AI refines acceptance criteria
3. Tasks are broken down and stored in sprint folder

### During Sprint
1. AI agent loads `sprints/current/` context
2. Works through tasks in priority order
3. Logs progress in `progress.md`
4. Verifies completion criteria before marking tasks done

### Sprint Review / Retro
1. AI agent summarizes completed work from `progress.md`
2. Team reviews demo/outcomes
3. Retro notes captured in `retrospective.md`
4. Improvements applied to next sprint

## Scrum Ceremonies (AI-Assisted)

| Ceremony | AI Role |
|----------|---------|
| **Refinement** | Review specs for clarity, suggest AC, estimate effort |
| **Planning** | Break down stories into tasks, identify dependencies |
| **Daily Standup** | Report progress on current tasks, surface blockers |
| **Review** | Summarize completed work, demonstrate features |
| **Retro** | Analyze metrics, suggest process improvements |
