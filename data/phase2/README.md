# داده و خروجی مرجع M09 و M10

- ورودی: [bcg.csv](../shared/bcg.csv)، دادهٔ واقعی `metadat::dat.bcg`؛ [مقالهٔ اصلی](https://pubmed.ncbi.nlm.nih.gov/8309034/) و [شرح ستون‌ها و دامنه](https://wviechtb.github.io/metadat/reference/dat.bcg.html).
- `M09_bcg_effects.csv`: اثرها، واریانس‌ها و CI حاصل از بازتحلیل؛ عدد ساختگی نیست.
- `M10_bcg_models.csv`: پنج مدل با نام روش و تنظیم روشن.
- `M10_bcg_weights.csv`: وزن درصدی ثابت و REML.
- `M10_bcg_prediction.csv`: CI و PI مدل REML_HK با پیش‌فرض پیش‌بینی نسخهٔ ثبت‌شده.
- `M09_environment.txt` و `M10_environment.txt`: نسخهٔ R و metafor هنگام اجرا.

از ریشهٔ مخزن، ابتدا کد M09 در `phase4_r_track/R02_data_prep_escalc/P2_M09_effect_sizes.R` یا کد M10 در `phase4_r_track/R03_meta_metafor_models/P2_M10_models.R` را اجرا کنید. هر کدام مستقل از اجرای دیگری کار می‌کند و خروجی خودش را بازنویسی می‌کند؛ فایل ورودی خام را تغییر نمی‌دهد.

مثال‌های SMD، z فیشر و logit در چاپ کد M09 **ساختگی و آموزشی** هستند؛ در جدول CSV اثرهای واقعی BCG وارد نشده‌اند. این فایل‌ها بازتولید همهٔ تحلیل‌های مقالهٔ ۱۹۹۴ یا ارزیابی خطر سوگیری آن نیستند.
