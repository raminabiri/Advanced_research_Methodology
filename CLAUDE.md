# CLAUDE.md — قواعد تولید محتوای این دوره

- All course content is in Persian; follow `00_admin/writing_style_shared_fa.md` (takes precedence) and `00_admin/style_guide_fa.md` (ZWNJ, terminology table, callout boxes).
- Each module folder: `lesson.md`, `references.md`, `videos.md`, `exercises.md`, `solutions.md`, optional `code/` (R). Template: `00_admin/module_template/`.
- Module codes and titles are fixed in `00_admin/syllabus.md`; folder names in each phase README.
- Write a module only when the user asks for it explicitly (user asked to stop after M01–M02 on 2026-10-26).
- References: verify every DOI via Crossref (`api.crossref.org/works/<doi>`) before citing. Never invent YouTube IDs; YouTube is unreachable from this server, so mark direct video links 🔎 and prefer verified hub pages (training.cochrane.org, iran.cochrane.org).
- Synthetic teaching data lives in `data/` and must be labelled «ساختگی». Real class dataset: `metafor::dat.bcg`.
- Test R code before committing; packages can be installed to a scratch lib.

- 2026-11-15: user authorized writing one further module (P1-M03) and publishing all existing SRMA course files to raminabiri/Advanced_research_Methodology. This does not authorize drafting all remaining modules.
- Keep central CMA 4 and R tracks, each with its own tutorials and exercises. Learners may choose either or both; do not require R for every CMA learner.
- Course is self-study, undergraduate through specialist in life/medical sciences. Burden examples cover Iran and other countries. M01–M02 need later style revision.
