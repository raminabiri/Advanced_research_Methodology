# CLAUDE.md — قواعد تولید محتوای این دوره

- All course content is in Persian; follow `00_admin/writing_style_shared_fa.md` (takes precedence) and `00_admin/style_guide_fa.md` (ZWNJ, terminology table, callout boxes).
- Each module folder: `lesson.md` (reading and video resources at the end), `exercises.md`, `solutions.md`, optional `code/` (R). Template: `00_admin/module_template/`.
- Module codes and titles are fixed in `00_admin/syllabus.md`; folder names in each phase README.
- Write a module only when the user asks for it explicitly (user asked to stop after M01–M02 on 2026-10-26).
- References: verify every DOI via Crossref (`api.crossref.org/works/<doi>`) before citing. Never invent YouTube IDs; YouTube is unreachable from this server, so mark direct video links 🔎 and prefer verified hub pages (training.cochrane.org, iran.cochrane.org).
- Synthetic teaching data lives in `data/` and must be labelled «ساختگی». Real class dataset: `metafor::dat.bcg`.
- Test R code before committing; packages can be installed to a scratch lib.

- 2026-11-15: user authorized writing one further module (P1-M03) and publishing all existing SRMA course files to raminabiri/Advanced_research_Methodology. This does not authorize drafting all remaining modules.
- Keep central CMA 4 and R tracks, each with its own tutorials and exercises. Learners may choose either or both; do not require R for every CMA learner.
- Course is self-study, undergraduate through specialist in life/medical sciences. Burden examples cover Iran and other countries. M01–M02 need later style revision.

- Current authorization: integrate missing tools at their proper modules, provide real-paper exercises with filled educational tables, and delete separate reference/video files after migrating their content to lesson endings. Tool workshop files may accompany unfinished core lessons. Do not present selected educational rows as complete official assessments.

- User now explicitly authorizes completing every phase without stopping, improving explanatory depth, keeping real-paper exercises and solutions for every tool, and reporting completion of each phase. This supersedes the older one-module restriction. Continue publishing this course to the previously authorized GitHub repository.

- Latest instruction supersedes automatic continuation: embed the seven online-tool modules and missing method modules locally, report additions, then STOP until the user asks to continue. Do not commit or push this update.

- Current scope: user requested exactly two additional modules, M09 and M10, then a stop. Both are now written with central-track companions. Do not continue to M11 or commit/push unless the user later authorizes it.

- Latest user instruction authorizes committing and pushing the pending course changes. Publish the written M09/M10 and their companions together with earlier pending foundation content and planned online-tool modules; do not resume writing additional modules.

- Latest request authorizes completing all remaining content through phase 4 (M11–M17, C01–C06, R01–R08). Announce phase completion and continue through phase 4, then stop. Do not extend writing to phase 5 or beyond.

- Completed current writing scope locally through phase 4, plus six online companions belonging to these stages. Stop; do not draft phase 5. No commit/push was performed during this writing request. Status and execution evidence are in phase4_r_track/VALIDATION.md and 00_admin/course_manifest.json.

- Latest user instruction "ادامه بده" authorized continuing writing through the remaining phases. First-edition modules in phases 5–8 and MetaInsight are now written locally. All 13 new main analysis.R examples passed; provenance is in outputs/validation/specialist/execution.json. brms_extension.R is authored but unexecuted. No commit/push or Streamlit build occurred in this continuation. Preserve honest execution and assessment limits. The earlier stop-before-phase-5 restriction is superseded.

- Latest user explicitly requested commit and push of all pending course changes through phase 8. Publication is authorized to raminabiri/Advanced_research_Methodology main; preserve the existing remote tree and use an expected-head lease.
