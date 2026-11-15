# Optional sampling extension; NOT executed in this course build.
# Requires brms plus a working Stan toolchain; never run automatically.
source('phase7_advanced_methods/shared.R')
library(brms)
d<-read.csv('data/shared/bcg.csv')
e<-metafor::escalc(measure='RR',ai=tpos,bi=tneg,ci=cpos,di=cneg,data=d,add=0)
e$sei<-sqrt(e$vi);e$study<-factor(e$trial)
priors<-c(prior(normal(0,1),class='Intercept'),prior(normal(0,.5),class='sd'))
# sigma=FALSE: the reported SE is the full within-study SD. Random study SD is tau.
fit<-brm(yi|se(sei,sigma=FALSE)~1+(1|study),data=e,family=gaussian(),prior=priors,
 chains=4,iter=4000,warmup=2000,cores=2,seed=20261115,control=list(adapt_delta=.99),sample_prior='yes')
saveRDS(fit,file.path(out,'M34_brms_optional.rds'))
capture.output(summary(fit),file=file.path(out,'M34_brms_optional_summary.txt'))
fig('M34_brms_optional_ppcheck.png',print(pp_check(fit)))
# Before scientific interpretation: inspect Rhat, bulk/tail ESS, divergence,
# treedepth, BFMI and trace plots. This script makes no claim those passed.
prior_fit<-brm(yi|se(sei,sigma=FALSE)~1+(1|study),data=e,family=gaussian(),prior=priors,
 chains=4,iter=2000,warmup=1000,cores=2,seed=20261116,sample_prior='only')
fig('M34_brms_optional_priorcheck.png',print(pp_check(prior_fit)))
