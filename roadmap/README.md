# Roadmap Template Guide

This folder contains a reusable LaTeX roadmap template. It is designed so that tasks are defined once and reused in:

- the Gantt chart
- the TODO list
- automatic group progress calculation

## 1. Folder structure

- `roadmap.tex`: Main configuration and document entry point
- `01_New_Commands.tex`: Dynamic rendering logic (Gantt + TODO)
- `03_pages.tex`: Included page files
- `04_chapters.tex`: Included chapter files
- `pages/00_front_page.tex`: Front page
- `pages/01_table_of_contents.tex`: Table of contents
- `chapter/10_project_definition.tex`: Project definition chapter
- `chapter/20_project_timeline.tex`: Timeline renderer call

## 2. Build

Use the helper build script from the repository root:

```bash
./helper_scripts/latexmk_build_clean roadmap/roadmap.tex
```

The output file is `roadmap.pdf`.

Optional (first time only), if the script is not executable:

```bash
chmod +x helper_scripts/latexmk_build_clean
```

## 3. Main configuration

Edit `roadmap.tex`.

### Calendar range

```tex
\newcommand{\RoadmapWeekStart}{27}
\newcommand{\RoadmapWeekEnd}{39}
```

### Groups

Groups define ordering, labels, date range, color, and milestone text.

```tex
% Format: \RoadmapGroup{key}{title}{startWeek}{endWeek}{color}{milestoneTitle}
\newcommand{\RoadmapGroupData}{%
	\RoadmapGroup{setup}{Setup}{27}{27}{blue}{Setup finished}%
	\RoadmapGroup{basics}{Get Basics}{30}{32}{orange}{Basics finished}%
}
```

Important:

- `key` must be unique.
- Group order in the chart and TODO follows the order in `\RoadmapGroupData`.

### Tasks

Tasks are the single source of truth.

```tex
% Format: \RoadmapTask{groupKey}{title}{startWeek}{endWeek}{progress}
\newcommand{\RoadmapTaskData}{%
	\RoadmapTask{setup}{Write roadmap}{27}{27}{100}%
	\RoadmapTask{setup}{Set up LaTeX layout}{27}{27}{80}%
	\RoadmapTask{basics}{Understand and use Yocto}{30}{30}{40}%
}
```

Important:

- `groupKey` must match one group key from `\RoadmapGroupData`.
- Task `progress` is expected as integer 0 to 100.

## 4. Automatic group progress

Group progress is calculated automatically from its tasks:

- For each group, all task progress values are summed
- Divided by the number of tasks in that group
- Rounded to nearest integer

This means there is no manual group progress field anymore.

## 5. Dynamic page breaks in the Gantt chart

The timeline supports automatic page breaks for large plans.

### Max rows per timeline page

Default is defined in `01_New_Commands.tex`:

```tex
\providecommand{\RoadmapMaxChartRows}{15}
```

To override it in `roadmap.tex`, set it before loading `01_New_Commands.tex`:

```tex
\newcommand{\RoadmapMaxChartRows}{20}
```

Row counting includes:

- group row
- task rows
- milestone row

When the next row would exceed the configured limit, a new timeline page is started automatically.

## 6. Optional labels and titles

You can override these labels in `roadmap.tex` before loading `01_New_Commands.tex`:

```tex
\newcommand{\RoadmapTimelineChapterTitle}{Project Timeline}
\newcommand{\RoadmapTimelineContinuedTitle}{Project Timeline (continued)}
\newcommand{\RoadmapCalendarTitle}{Calendar weeks}
\newcommand{\RoadmapTodoChapterTitle}{TODO List}
\newcommand{\RoadmapTodoWeekPrefix}{CW}
```

## 7. How timeline and TODO are rendered

- Timeline chapter file `chapter/20_project_timeline.tex` calls:

```tex
\RoadmapRenderAllGroupsInTimeline
```

- TODO chapter is rendered from the same data via:

```tex
\RoadmapRenderAllTodoSections
```

Because both views use the same central data, they always stay synchronized.

## 8. Typical workflow

1. Edit group and task data in `roadmap.tex`.
2. Compile with `helper_scripts/latexmk_build_clean`.
3. Check chart pagination and text lengths.
4. Adjust `\RoadmapMaxChartRows` if needed.

## 9. Troubleshooting

### Changing `\RoadmapMaxChartRows` has no effect

Cause:

- The value is overridden somewhere else.

Fix:

- Ensure there is only one active definition in the preamble.
- If you set it in `roadmap.tex`, place it before `\input{01_New_Commands.tex}`.

### Group progress looks wrong

Cause:

- Tasks are assigned to wrong group keys or missing task progress values.

Fix:

- Verify each `\RoadmapTask` uses a valid group key.
- Keep progress values in the range 0 to 100.

### Compilation fails due to external chapter paths

Cause:

- Writing aux files outside allowed directories can fail in restricted environments.

Fix:

- Prefer `\input` for external text fragments.
- Keep `\include` targets inside the roadmap folder when possible.
