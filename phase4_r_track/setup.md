# راه‌اندازی و اجرای مسیر R

این مسیر از ریشهٔ مخزن اجرا می‌شود. R و یک ویرایشگر مانند RStudio کافی‌اند؛ برای گزارش پایانی، برنامهٔ رسمی Quarto نیز لازم است. مسیر CMA پیش‌نیاز این مسیر نیست.

## نصب بسته‌ها

یک بار در R اجرا کنید:

```r
install.packages(c("metafor", "meta", "clubSandwich", "robvis", "ggplot2", "knitr", "rmarkdown"),
                 repos="https://cloud.r-project.org")
```

ممکن است نصب وابستگی‌های کامپایل‌شونده به ابزارهای ساخت سازگار با سیستم‌عامل نیاز داشته باشد. پیام نصب و راهنمای رسمی R را بخوانید؛ در پایان با `requireNamespace` موجود بودن بسته را بررسی کنید. نام بسته به‌تنهایی مدرک نصب موفق نیست.

برای کتابخانهٔ شخصی جدا می‌توانید هنگام اجرا متغیر `SRMA_R_LIB` را روی مسیر آن قرار دهید. کد مشترک، این مسیر اختیاری را به `.libPaths()` اضافه می‌کند؛ مسیر موقتِ محیط تولید دوره در کد به‌عنوان الزام فراگیر ثابت نشده است.

## ترتیب اجرا

از R01 تا R08، فایل `analysis.R` در پوشهٔ هر ماژول را با `source` یا `Rscript --vanilla` اجرا کنید. هر اسکریپت دادهٔ مورد نیازش را مستقیم از `data/shared` می‌خواند؛ اجرای همهٔ فایل‌های قبلی شرط فنی نیست، اما ترتیب آموزشی توصیه می‌شود.

| ماژول | فایل |
|---|---|
| R01 | `phase4_r_track/R01_r_basics/analysis.R` |
| R02 | `phase4_r_track/R02_data_prep_escalc/analysis.R` |
| R03 | `phase4_r_track/R03_meta_metafor_models/analysis.R` |
| R04 | `phase4_r_track/R04_heterogeneity_influence/analysis.R` |
| R05 | `phase4_r_track/R05_pubbias_metaregression/analysis.R` |
| R06 | `phase4_r_track/R06_prevalence_rare_events/analysis.R` |
| R07 | `phase4_r_track/R07_multilevel_dependent/analysis.R` |
| R08 | `phase4_r_track/R08_reproducible_reporting/analysis.R` |

کدها خروجی‌های خود را در `outputs/phase4` بازنویسی می‌کنند؛ ورودی خام تغییر نمی‌کند. پیش از کار روی پروژهٔ شخصی، نام پوشهٔ خروجی را جدا کنید تا نمونهٔ آموزشی با کار واقعی مخلوط نشود.

## گزارش Quarto

[Quarto را از منبع رسمی](https://quarto.org/docs/download/) نصب و از ریشه اجرا کنید:

```sh
quarto render phase4_r_track/R08_reproducible_reporting/report.qmd --to html --execute-dir .
```

قالب پروژه در `_quarto.yml`، خروجی را در `outputs/reports` قرار می‌دهد. بستهٔ R با نام quarto، جای خود برنامهٔ خط فرمان را نمی‌گیرد. در محیط محدود، محل کش را به یک پوشهٔ نوشتنی تنظیم کنید؛ این تنظیم محیط اجراست و روش آماری را عوض نمی‌کند.

## چه چیزی کنترل شده است؟

[گزارش بررسی](VALIDATION.md) نسخه‌ها، خروجی‌ها و هشدارهای شناخته‌شده را ثبت می‌کند. یادگیری کامل شامل خواندن هشدار است: بزرگی SMD، دادهٔ صفر و تعداد کم خوشه‌ها باید تفسیر شوند. پنهان کردن پیام برای تمیز شدن خروجی، صحت علمی ایجاد نمی‌کند.
