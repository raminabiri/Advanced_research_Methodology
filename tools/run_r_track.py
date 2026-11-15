#!/usr/bin/env python3
"""Run the eight R lessons in clean processes and check meaningful invariants.
Usage: SRMA_R_LIB=/path/to/optional/library python3 tools/run_r_track.py
"""
from pathlib import Path
import subprocess,os,json,csv,math,hashlib
root=Path(__file__).resolve().parents[1]
paths=[p for p in sorted((root/'phase4_r_track').glob('R*/analysis.R'))]
assert len(paths)==8
logs=root/'outputs/validation';logs.mkdir(parents=True,exist_ok=True)
env=os.environ.copy();env['TZ']='UTC'
results=[]
for path in paths:
 cp=subprocess.run(['Rscript','--vanilla',str(path.relative_to(root))],cwd=root,env=env,capture_output=True,text=True)
 (logs/(path.parent.name+'.log')).write_text(cp.stdout+'\n'+cp.stderr)
 results.append({'module':path.parent.name,'exit_code':cp.returncode,'script_sha256':hashlib.sha256(path.read_bytes()).hexdigest()})
 print(path.parent.name,'PASS' if cp.returncode==0 else 'FAIL',flush=True)
 if cp.returncode:print(cp.stderr[-2500:],flush=True)
with (logs/'r_track_execution.json').open('w') as f:json.dump(results,f,indent=2)
if any(x['exit_code'] for x in results):raise SystemExit(1)
def rows(name):return list(csv.DictReader(open(root/'outputs/phase4'/name)))
cmp=rows('R03_package_comparison.csv')
for key in ['estimate','lower','upper','tau2']:
 assert math.isclose(float(cmp[0][key]),float(cmp[1][key]),rel_tol=1e-5,abs_tol=1e-7),(key,cmp)
zeros=rows('R06_zero_counts.csv')[0]
assert (int(zeros['trials']),int(zeros['single_zero']),int(zeros['double_zero']))==(42,26,4)
assert all(int(x['k'])==38 for x in rows('R06_rare_models.csv'))
assert all(int(x['k'])==26 for x in rows('R06_prevalence_models.csv'))
assert len(rows('R04_leave_one_out.csv'))==13
assert len(rows('R07_multivariate.csv'))==2
h=rows('R04_heterogeneity.csv')[0]
assert float(h['CI_upper'])<1<float(h['PI_upper'])
assert (root/'outputs/phase4/R08_risk_of_bias.png').stat().st_size>1000
print('PASS: matched meta/metafor results, rare-event accounting, multivariate dimensions and CI/PI meaning.')
