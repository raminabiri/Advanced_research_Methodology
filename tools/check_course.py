#!/usr/bin/env python3
"""Check course structure, local links, execution provenance and essential data invariants."""
from pathlib import Path
import re,json,csv,hashlib
r=Path(__file__).resolve().parents[1]
manifest=json.loads((r/'00_admin/course_manifest.json').read_text())
assert len(manifest)==56
broken=[]
for p in r.rglob('*.md'):
 if any(x.startswith('.') for x in p.relative_to(r).parts):continue
 for u in re.findall(r'\]\(([^)]+)\)',p.read_text()):
  if u.startswith(('http://','https://','#','/','mailto:')):continue
  target=u.split('#')[0].strip('<>')
  if target and not (p.parent/target).exists():broken.append((str(p.relative_to(r)),u))
assert not broken,broken
assert not [p for p in r.rglob('*.md') if p.name in ['references.md','videos.md']]
for row in manifest:
 m=r/row['path']
 for name in ['README.md','lesson.md','exercises.md','solutions.md']:assert (m/name).is_file(),(m,name)
 s=(m/'lesson.md').read_text()
 assert '## منابع نوشتاری' in s and '## فیلم' in s,m
 assert s.rfind('## منابع نوشتاری')<s.rfind('## فیلم'),m
runs=json.loads((r/'outputs/validation/r_track_execution.json').read_text())
assert len(runs)==8 and all(x['exit_code']==0 for x in runs)
for row in runs:
 p=r/'phase4_r_track'/row['module']/'analysis.R'
 assert hashlib.sha256(p.read_bytes()).hexdigest()==row['script_sha256'],p
online=json.loads((r/'online_tools/modules.json').read_text())
assert sum(x['lesson_written'] for x in online)==7
assert next(x for x in online if x['id']=='O06_metainsight')['status']=='written_manual_workflow'
ris=(r/'data/online_tools/practice_records.ris').read_text()
assert ris.count('TY  - JOUR')==4 and ris.count('10.1136/bmj-2023-075847')==2
report=r/'outputs/reports/phase4_r_track/R08_reproducible_reporting/report.html'
s=report.read_text()
assert report.stat().st_size>100000 and ('dir="rtl"' in s or 'dir: rtl' in s)
assert 'گزارش بازتحلیل آموزشی BCG' in s
for name in ['R05_permutation.csv','R05_peters.csv']:
 rows=list(csv.DictReader(open(r/'outputs/phase4'/name)));assert rows
 for row in rows:
  pv=float(row['p_permutation'] if 'p_permutation' in row else row['p'])
  assert 0<=pv<=1
specialist=json.loads((r/'outputs/validation/specialist/execution.json').read_text())
assert len(specialist)==13 and all(x['exit_code']==0 for x in specialist)
for row in specialist:
 assert hashlib.sha256((r/row['script']).read_bytes()).hexdigest()==row['script_sha256'],row['script']
 if row['shared_sha256']:
  assert hashlib.sha256((r/'phase7_advanced_methods/shared.R').read_bytes()).hexdigest()==row['shared_sha256']
 assert (r/row['log']).is_file()
by_path={str(__import__('pathlib').Path(x['script']).parent) for x in specialist}
assert all(x['r_execution_verified']==(x['path'] in by_path) for x in manifest if x['phase']>=5)
def rows(name):return list(csv.DictReader(open(r/name)))
assert [float(z['CCA']) for z in rows('outputs/phase5/overlap_results.csv')]==[.5,.75,.2,.4]
assert rows('outputs/phase5/metaumbrella_summary.csv')[0]['Class']=='III'
rr=rows('outputs/phase7/M34_prior_sensitivity.csv')
for z in rr:
 assert 0<float(z['CrI_lower'])<float(z['RR_median'])<float(z['CrI_upper'])
 assert float(z['prediction_lower'])<float(z['CrI_lower'])<float(z['CrI_upper'])<float(z['prediction_upper'])
 assert float(z['prediction_lower'])<1<float(z['prediction_upper'])
assert abs(sum(float(z['change']) for z in rows('outputs/phase6/M27_shapley_synthetic.csv'))-1.52)<1e-9
for z in rows('outputs/phase7/M31_effects_ranking.csv'):
 assert 0<=float(z['Pscore'])<=1
assert len(rows('data/phase7/metainsight_senn_arms.csv'))==53
assert len(rows('data/phase7/dementia.csv'))==33
w=rows('outputs/phase7/M32_nonlinearity_Wald.csv')[0]
assert int(w['df'])==1 and 0<=float(w['p'])<=1
print('PASS: 56 core modules through phase 8; seven online companions; zero broken local links.')
print('PASS: 13 specialist R scripts match successful execution provenance and data invariants.')
print('PASS: resources in lesson endings; eight successful current R scripts; RTL HTML report.')
print('CMA GUI and online account execution remain unverified, as documented.')
