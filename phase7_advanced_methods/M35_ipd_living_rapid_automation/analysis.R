source('phase7_advanced_methods/shared.R');library(lme4);library(metafor)
# All participant data are SYNTHETIC. No real patient data are distributed.
set.seed(351115);study<-rep(1:12,each=120);n<-length(study)
age<-rnorm(n,60,10);treatment<-rbinom(n,1,.5)
age_within<-age-ave(age,study,FUN=mean)
age_between<-ave(age,study,FUN=mean)-60
intercepts<-rnorm(12,0,1);effects<-rnorm(12,-1,.5)
y<-intercepts[study]+.03*(age-60)+effects[study]*treatment+.015*age_within*treatment+rnorm(n,0,2)
d<-data.frame(study=factor(study),age,age_within,age_between,treatment,y)
# Separate within-study effect modification from between-study differences.
m<-lmer(y~treatment+age_within+age_between+treatment:age_within+treatment:age_between+(1|study)+(0+treatment|study),data=d,REML=TRUE)
capture.output(summary(m),file=file.path(out,'M35_IPD_one_stage_SYNTHETIC.txt'))
put(d,'M35_IPD_SYNTHETIC.csv')
study_fits<-lapply(split(d,d$study),function(z){fit<-lm(y~treatment+age_within+treatment:age_within,data=z);cf<-summary(fit)$coefficients;data.frame(yi=cf['treatment','Estimate'],vi=cf['treatment','Std. Error']^2)})
two<-do.call(rbind,study_fits);pool<-rma(yi,vi,data=two,method='REML',test='knha')
put(two,'M35_IPD_two_stage_estimates.csv');capture.output(summary(pool),file=file.path(out,'M35_IPD_two_stage_SYNTHETIC.txt'))
# No automated screening decision is made by this script.

stopifnot(!isSingular(m))
