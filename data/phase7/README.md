# منشأ داده‌های واقعی فاز پیشرفته

| فایل | منبع و اندازه | ملاحظات |
|---|---|---|
| dementia.csv | mada::Dementia؛ 33 جدول از Mitchell 2009 | فقط چهار خانه؛ آستانه و شناسه برای پژوهش باید به مقاله برگردد |
| senn2013.csv | netmeta::Senn2013؛ 28 مقایسه، 26 مطالعه، 10 درمان | وابستگی مطالعهٔ چندبازویی با studlab نگه داشته شود |
| metainsight_senn_arms.csv | metadat::dat.senn2013؛ 53 بازو، 26 مطالعه | نگاشت: Study=study، T=treatment، N=ni، Mean=mi، SD=sdi؛ دادهٔ منبع شامل تغییر و مقدار پایانی است |
| alcohol_cvd.csv | dosresmeta::alcohol_cvd؛ 6 مطالعه، 25 ردیف، Liu 2009 | دادهٔ مشاهده‌ای با طرح‌های cc و ci؛ نسبت‌های تعدیل‌شده با مرجع مشترک |
| becker09_real.rds | metaSEM::Becker09؛ ده ماتریس، Craft 2003/Becker 2009 | ماتریس‌های ناقص NA دارند؛ صفر جای مقدار گمشده نیست |

فایل‌های SYNTHETIC در outputs دادهٔ ساختگی‌اند. هیچ دادهٔ فردی واقعی توزیع نشده است. دادهٔ BCG و Berkey در پوشهٔ مشترک موجودند.

منابع مقاله‌ها و راهنمای بسته در **پایان درس مربوط** آمده است. این فایل فقط فرهنگ داده است، نه فایل جداگانهٔ منابع درس.

[صفحهٔ پیشین: فهرست روش‌ها](../../phase7_advanced_methods/README.md) · [صفحهٔ پسین: آغاز DTA](../../phase7_advanced_methods/M30_diagnostic_accuracy/lesson.md)
