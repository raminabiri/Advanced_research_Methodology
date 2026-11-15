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

## Local completion through phase 4
- Wrote remaining M11–M17, all C01–C06 and R01–R08, each with worked examples, exercises, explained solutions and resources at the lesson end.
- Added four real metadat datasets with provenance. Added six written online companions (Rayyan, Covidence, TERA, RevMan, Meta-Mar, GRADEpro); MetaInsight remains phase 7 planned.
- Executed all eight R lessons in clean processes; checked package agreement, rare-event accounting, multivariate structure and CI/PI interpretation. Added and executed permutation/Peters analyses.
- Rendered Persian Quarto HTML with official CLI 1.11.9. Kept expected scientific/package warnings documented.
- Wrote validation reports and dashboard-ready module metadata. CMA GUI, online-account execution, independent expert review and video playback are not claimed.
- Current work is local; no commit/push in this writing turn. Stop at phase 4; no further phase drafting.


## ادامهٔ نگارش پس از فاز۴ — 2026-11-15

با درخواست «ادامه بده»، نسخهٔ نخست فازهای۵تا۸ نوشته شد: ۵ماژول آمبرلا،۷ماژول بار بیماری،۸ماژول روش پیشرفته و۳ماژول پروژهٔ نهایی. در مجموع۵۶ماژول اصلی درس، تمرین و پاسخ دارند؛ هفتمین ابزار برخط MetaInsight نیز نوشته شد.

۱۳کد اصلی تازه از Rscriptهای جداگانه اجرا شدند. داده‌های واقعی Dementia، Senn، دوز–پاسخ و ماتریس‌های Becker09 همراه منشأ افزوده شدند. سناریوهای DALY/PAF/روند/تجزیه،IPD و توان برچسب ساختگی دارند. همهٔ منابع و آموزش دیداری در پایان درس‌اند.

مدل اسپلاین اولیه همگرا نشد؛ مثال نهایی با یک گره اجرا شد و آزمون درست غیرخطی بودن افزوده شد. مدل اصلی MASEM اشباع بود؛ محدودیت تفسیر و مدل محدودتر افزوده شد. فایل brms افزوده اجرا نشده است؛ رابط‌های CMA/ابزارهای برخط و دانلود GBD تأیید نشده‌اند. بازبینی علمی جداگانه همچنان انجام نشده است.

این نوبت محلی است و کامیت/پوش انجام نشد. داشبورد Streamlit ساخته نشده است. مسیرهای مکمل مرور حیطه‌ای و سنتز کیفی همچنان توسعهٔ جداگانه‌اند. گزارش: `00_admin/specialist_validation.md`.


## درخواست انتشار — 2026-11-15

کاربر کامیت و پوش همهٔ تغییرات آماده تا پایان فاز۸ را درخواست کرد. بررسی ساختار، پیوندها و هش کدهای اجراشده موفق بود. انتشار بر پایهٔ شاخهٔ main مخزن raminabiri/Advanced_research_Methodology انجام می‌شود؛ تاریخچهٔ GitHub مرجع شناسهٔ کامیت است.


## نمونهٔ بازنویسی اجرایی M01 — 2026-11-15

کاربر پس از نقد کمبود عمق، نوشتن و انتشار یک درس نمونه از ابتدای مرور نظام‌مند را تأیید کرد. M01 بازنویسی شد: درس گام‌به‌گام، پروندهٔ ورزش/افسردگی با سه مرور واقعی و ثبت اجرای PubMed، جدول و یادداشت تصمیم پرشده، کاربرگ، تمرین مستقل ویتامین D با پاسخ پرشده و چهار لینک مستقیم YouTube. خروجی خام جست‌وجو و ستون‌های شاهد از سناریوی آموزشی جدا هستند.

این تنها نمونهٔ بازنویسی است؛ تأیید کفایت آموزشی کاربر دریافت نشده و بقیهٔ درس‌ها با این الگو بازنویسی نشده‌اند. شمار فایل‌ها و موفقیت بررسی ساختار جای ارزیابی عمق آموزش را نمی‌گیرند. منابع و فیلم‌ها در پایان lesson.md هستند.
