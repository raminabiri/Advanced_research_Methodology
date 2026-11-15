source('phase7_advanced_methods/shared.R');library(mada)
d<-read.csv('data/phase7/dementia.csv')
stopifnot(all(as.matrix(d)>=0),all(d$TP+d$FN>0),all(d$TN+d$FP>0))
d$sensitivity<-with(d,TP/(TP+FN));d$specificity<-with(d,TN/(TN+FP))
put(d,'M30_individual_accuracy.csv')
# mada uses a transformed-normal approximation, not a binomial GLMM.
m<-reitsma(d,correction=.5,correction.control='single')
capture.output(summary(m),file=file.path(out,'M30_reitsma.txt'))
cf<-coef(m);pr<-plogis(as.numeric(cf))
put(data.frame(sensitivity=pr[1],specificity=1-pr[2]),'M30_summary_accuracy.csv')
fig('M30_SROC.png',plot(m,main='Dementia: Reitsma bivariate model'))
# Fixed summary accuracy applied to hypothetical 1000 people, prevalence 0.1.
prevalence<-.1
put(data.frame(TP=1000*prevalence*pr[1],FN=1000*prevalence*(1-pr[1]),FP=1000*(1-prevalence)*pr[2],TN=1000*(1-prevalence)*(1-pr[2])),'M30_hypothetical_1000.csv')
sens<-reitsma(d,correction=.5,correction.control='all')
put(data.frame(policy=c('single','all'),logit_sensitivity=c(coef(m)[1],coef(sens)[1]),logit_FPR=c(coef(m)[2],coef(sens)[2])),'M30_zero_sensitivity.csv')
stopifnot(nrow(d)==33,all(pr>0 & pr<1))
