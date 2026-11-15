# PROGRESS

## Done (2026-10-26)
- Reviewed the two AI drafts (moved to `00_admin/source_ai_drafts/`); critique in `00_admin/course_review.md`.
- Architecture: 9 phases (0–8), 38 modules + CMA (C01–C06) and R (R01–R08) tracks; `00_admin/syllabus.md`.
- Full folder skeleton; every unwritten module has a placeholder README.
- Admin docs: README, syllabus, assessment, Persian style guide, glossary, module template.
- Phase 1: M01 and M02 fully written (lesson, references, videos, exercises, solutions).
- Synthetic data for phase 1: `data/phase1/screening_sample.csv` (kappa = 0.677), `extraction_reports.md`, `rob_judgements.csv`.

## Next steps
- On user request only: write P1-M03 … M08 (planned R code: rentrez, irr, PRISMA2020, synthesisr, estmeansd, robvis — all tested installable).
- `tools/check_links.sh` to recheck links (run from Iran for YouTube).
- Optional: `_quarto.yml` to render the repo as an RTL Persian book.

## Bugs / open issues
- YouTube links unverifiable from this server (marked 🔎).
- pedro.org.au video page timed out from server.

## Update (2026-11-15)
- Added P1-M03 as a Persian self-study module: lesson, references, verified resource pages, protocol workbook, exercises, and explained solutions.
- Added protocol-planning companions in the central CMA 4 and R tracks; no statistical computation is required for this module.
- Crossref verified the two PRISMA-P DOIs. Video landing pages checked; playback not verified.
- Added a portable copy of the author's newer writing/teaching style, which takes precedence over conflicting older conventions.
- Confirmed scope: all four core areas taught fully over time; self-study; undergraduate through specialist audience; Iran and international burden examples.
- Existing M01–M02 still need revision to the new style. Other modules and software tutorials remain unfinished.
- GitHub target: https://github.com/raminabiri/Advanced_research_Methodology ; Streamlit dashboard deferred.

## Tool workshops and resource migration (2026-11-15)
- Added 21 real-paper tool examples across 12 workshops, each with a filled selected-row teaching table, exercise and explained answer. These are not complete official assessments or final ratings.
- Added tool map and machine-readable coverage/source metadata for future Streamlit integration. Core unwritten lessons remain unwritten.
- Clarified QUADAS-3, draft status of ROBINS-I V2, PRESS/PRISMA-S, SWiM and PRISMA-ScR placement.
- Added complementary scoping/qualitative pathway deliverables to the syllabus.
- Deleted 8 separate references/videos files (including template files) after migrating existing content into lesson endings; updated navigation and templates.

## Local structure update — writing paused at user request
- Embedded seven online-tool modules: Rayyan, Covidence, TERA, RevMan, Meta-Mar, MetaInsight, GRADEpro.
- Added detailed plans for M39 MASEM and M40 power/precision planning.
- Expanded M31 network and M34 Bayesian plans to cover a complete real-data workflow.
- These are scaffolds and curricula, not completed lessons, exercises, official filled forms or executed online sessions.
- Updated syllabus and navigation. User explicitly prohibits commit/push for this update and requests a stop after embedding, until they ask to continue.

## Two-module local completion — M09 and M10
- Completed the two requested modules: effect measures and fixed/random-effects models; expanded explanation, worked real BCG examples, standalone exercises and explained answers.
- Added separate central CMA and R practical guides, exercises and answers for each module.
- Executed both R scripts with R 4.6.1 and metafor 5.2.1; checked per-study logRR/variance against manual formulas and FE pooling/weight totals against definitions.
- Stored real-data derived reference tables and environment information under data/phase2.
- CMA guides are written; CMA GUI execution and video playback were not verified.
- No commit or push. Stop after reporting these two modules; await further user direction.

## Publication authorized
- User requested commit and push of pending course work. This supersedes the earlier temporary publication prohibition.
- Publication includes M09/M10 (phase 2), central CMA/R companions, prior local phase 0/1 lessons and the explicitly planned online/advanced module structure.
- No further lesson writing is authorized by the publication-only request.
