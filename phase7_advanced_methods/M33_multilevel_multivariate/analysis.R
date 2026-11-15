source('phase7_advanced_methods/shared.R');library(metafor);library(clubSandwich)
d<-read.csv('data/shared/berkey1998.csv');d$outcome<-factor(d$outcome,levels=c('PD','AL'))
V<-bldiag(lapply(split(d,d$trial),function(z)as.matrix(z[,c('v1i','v2i')])))
stopifnot(all(eigen(V,symmetric=TRUE)$values>0))
m<-rma.mv(yi,V,mods=~outcome-1,random=~outcome|trial,struct='UN',data=d,method='REML')
L<-matrix(c(1,-1),nrow=1)
contrast<-as.numeric(L%*%coef(m));se<-sqrt(as.numeric(L%*%vcov(m)%*%t(L)))
put(data.frame(contrast='PD minus AL; different scales require clinical justification',estimate=contrast,se=se,lower=contrast-1.96*se,upper=contrast+1.96*se),'M33_contrast.csv')
capture.output(coef_test(m,vcov='CR2',cluster=d$trial,test='Satterthwaite'),file=file.path(out,'M33_CR2.txt'))
# Purely synthetic three-level effects: true study variance .03, nested effect variance .01.
set.seed(331115);study<-rep(1:20,each=3);effect<-rep(1:3,20);vi<-rep(.02,60)
y<- .2+rep(rnorm(20,0,sqrt(.03)),each=3)+rnorm(60,0,sqrt(.01))+rnorm(60,0,sqrt(vi))
s<-data.frame(study,effect,yi=y,vi)
fit<-rma.mv(yi,vi,random=~1|study/effect,data=s,method='REML')
put(s,'M33_three_level_SYNTHETIC.csv');capture.output(summary(fit),file=file.path(out,'M33_three_level.txt'))
put(data.frame(component=c('study','within_study_effect'),variance=fit$sigma2),'M33_three_level_components.csv')
# This simulated example has independent sampling errors conditional on study effects.
# Real shared samples need a non-diagonal sampling V in addition to random effects.
