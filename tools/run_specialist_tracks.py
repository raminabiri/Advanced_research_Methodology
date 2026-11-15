#!/usr/bin/env python3
"""Execute the authored specialist teaching examples from fresh R processes.
SRMA_R_LIB may name a scratch/user library. Never installs packages or calls web GUIs.
"""
from pathlib import Path
import os,subprocess,hashlib,json,datetime
ROOT=Path(__file__).resolve().parents[1]
logs=ROOT/'outputs/validation/specialist';logs.mkdir(parents=True,exist_ok=True)
scripts=[]
for prefix in ['phase5_','phase6_','phase7_']:
 for phase in sorted(ROOT.glob(prefix+'*')):scripts+=sorted(phase.glob('*/analysis.R'))
runs=[]
for script in scripts:
 relative=str(script.relative_to(ROOT)); log=logs/(script.parent.name+'.log')
 with log.open('w') as stream:
  result=subprocess.run(['Rscript','--vanilla',relative],cwd=ROOT,env={**os.environ,'TZ':'UTC'},stdout=stream,stderr=subprocess.STDOUT)
 shared=ROOT/'phase7_advanced_methods/shared.R'
 runs.append({'script':relative,'exit_code':result.returncode,'script_sha256':hashlib.sha256(script.read_bytes()).hexdigest(),'shared_sha256':hashlib.sha256(shared.read_bytes()).hexdigest() if relative.startswith('phase7_') else None,'log':str(log.relative_to(ROOT)),'verified_utc':datetime.datetime.now(datetime.timezone.utc).isoformat()})
 print(relative,result.returncode,flush=True)
 (logs/'execution.json').write_text(json.dumps(runs,indent=2))
if any(x['exit_code'] for x in runs):raise SystemExit(1)
# Capture the exact packages in this successful build.
r="""extra<-Sys.getenv('SRMA_R_LIB','');if(nzchar(extra)).libPaths(c(extra,.libPaths()));p<-c('metaumbrella','mada','netmeta','dosresmeta','bayesmeta','metaSEM','OpenMx','metafor','metadat','lme4','clubSandwich');write.csv(data.frame(package=p,version=sapply(p,function(z)as.character(packageVersion(z)))),'outputs/validation/specialist/package_versions.csv',row.names=FALSE);capture.output(sessionInfo(),file='outputs/validation/specialist/sessionInfo.txt')"""
subprocess.run(['Rscript','--vanilla','-e',r],cwd=ROOT,env={**os.environ,'TZ':'UTC'},check=True,stdout=subprocess.DEVNULL)
print('All specialist analysis.R examples passed. brms_extension.R and web GUIs excluded explicitly.')
