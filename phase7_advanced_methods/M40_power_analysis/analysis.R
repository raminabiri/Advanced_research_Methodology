source('phase7_advanced_methods/shared.R');library(metafor)
# Prospective, synthetic scenarios. BCG informs plausible heterogeneity, not post-hoc power.
set.seed(401115);B<-500
scenarios<-expand.grid(k=c(10,20,40),tau=c(0,.2,.5));mu<-log(.8);vi<-.04
res<-lapply(seq_len(nrow(scenarios)),function(j){k<-scenarios$k[j];tau<-scenarios$tau[j]
 a<-replicate(B,{y<-rnorm(k,mu,sqrt(vi+tau^2));m<-rma(y,vi=rep(vi,k),method='REML',test='knha');c(reject=m$pval<.05,cover=m$ci.lb<=mu && m$ci.ub>=mu,width=m$ci.ub-m$ci.lb)})
 power<-mean(a['reject',]);data.frame(k,tau,mu,vi,B,power,MCSE=sqrt(power*(1-power)/B),coverage=mean(a['cover',]),mean_logCI_width=mean(a['width',]))})
put(do.call(rbind,res),'M40_power_simulation.csv')
# Simple normal approximation with known tau, for comparison only.
ana<-transform(scenarios,SE=sqrt((vi+tau^2)/k))
ana$normal_approx_power<-pnorm(-qnorm(.975),mean=mu/ana$SE)+1-pnorm(qnorm(.975),mean=mu/ana$SE)
put(ana,'M40_known_tau_approximation.csv')
stopifnot(all(vapply(res,function(x)x$power>=0 && x$power<=1,logical(1))))
