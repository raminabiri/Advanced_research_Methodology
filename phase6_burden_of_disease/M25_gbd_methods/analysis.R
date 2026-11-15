# SYNTHETIC exposure, causal RR and burden assumptions, not GBD reproduction.
set.seed(251115);dir.create('outputs/phase6',recursive=TRUE,showWarnings=FALSE)
paf<-function(p,rr)p*(rr-1)/(1+p*(rr-1))
stopifnot(abs(paf(.3,2)-3/13)<1e-12,abs(paf(.4,1.5)-1/6)<1e-12)
n<-10000;p<-rbeta(n,30,70);rr<-exp(rnorm(n,log(2),.12));burden<-exp(rnorm(n,log(1000),.1))
# Independence in these draws is a teaching assumption, not a GBD claim.
a<-paf(p,rr)*burden
write.csv(data.frame(point_paf=paf(.3,2),point_attributable=1000*paf(.3,2),draw_median=median(a),lower=quantile(a,.025),upper=quantile(a,.975)), 'outputs/phase6/M25_PAF_synthetic.csv',row.names=FALSE)
