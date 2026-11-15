#!/usr/bin/env python3
"""Optional live replay of the M01 feasibility queries; not a systematic search.
Uses Python standard library. Writes to a fresh timestamped directory and never
changes the checked-in snapshot. No API key or personal data are required.
"""
import argparse,datetime,json,time,urllib.parse,urllib.request
from pathlib import Path
QUERIES=[('Q01','(exercise[tiab] OR "physical activity"[tiab]) AND depress*[tiab] AND (systematic review[pt] OR meta-analysis[pt] OR "systematic review"[tiab])'),('Q02','"10.1136/bmj-2023-075847"[AID] OR "10.1136/bjsports-2022-106195"[AID] OR "10.1002/14651858.CD004366.pub6"[AID]')]
def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--output-root',type=Path,default=Path('outputs/m01_feasibility_live'))
 args=parser.parse_args()
 now=datetime.datetime.now(datetime.timezone.utc)
 dest=args.output_root/now.strftime('%Y%m%dT%H%M%S%fZ');dest.mkdir(parents=True,exist_ok=False)
 logs=[]
 for qid,query in QUERIES:
  url='https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?'+urllib.parse.urlencode(dict(db='pubmed',term=query,retmode='json',retmax=10,sort='pub_date'))
  row=dict(id=qid,query=query,endpoint=url,run_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),purpose='limited feasibility exercise; NOT final systematic search',retmax=10)
  try:
   with urllib.request.urlopen(url,timeout=60) as response:row['response']=json.load(response)
   result=row['response'].get('esearchresult',{})
   row['success']='count' in result and not row['response'].get('error') and not result.get('errorlist')
  except Exception as exc:row.update(success=False,error=str(exc))
  logs.append(row)
  (dest/'pubmed_pilot_run.json').write_text(json.dumps(logs,ensure_ascii=False,indent=2))
  print(qid,'success=',row['success'],'count=',row.get('response',{}).get('esearchresult',{}).get('count'))
  time.sleep(.4)
 print('Saved:',dest/'pubmed_pilot_run.json')
 if not all(x['success'] for x in logs):raise SystemExit('Incomplete run: inspect saved errors; never interpret failure as zero results.')
if __name__=='__main__':main()
