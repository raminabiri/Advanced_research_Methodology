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
