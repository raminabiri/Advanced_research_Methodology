source("phase4_r_track/shared.R")
if(!requireNamespace("meta",quietly=TRUE))stop("Install meta.")
n<-read.csv("data/shared/nissen2007.csv")
n$a<-n$treat.infarction;n$b<-n$treat.total-n$a;n$c<-n$cont.infarction;n$d<-n$cont.total-n$c
n_use<-n[n$a+n$c>0,]
# Explicitly exclude four double-zero rows from these OR estimators, not from the review.
mh<-rma.mh(measure="OR",ai=a,bi=b,ci=c,di=d,data=n_use,add=0,to="none",drop00=TRUE)
pe<-rma.peto(ai=a,bi=b,ci=c,di=d,data=n_use,drop00=TRUE)
export(rbind(model_row(mh,"MH_no_correction"),model_row(pe,"Peto")),"R06_rare_models.csv")
export(data.frame(trials=nrow(n),single_zero=sum(xor(n$a==0,n$c==0)),double_zero=sum(n$a==0 & n$c==0)),"R06_zero_counts.csv")
p<-read.csv("data/shared/crisafulli2020.csv")
logit<-escalc(measure="PLO",xi=cases,ni=total,data=p,add=0)
iv<-rma(yi,vi,data=logit,method="REML",test="knha")
gl<-rma.glmm(measure="PLO",xi=cases,ni=total,data=p,method="ML")
mp<-meta::metaprop(event=cases,n=total,studlab=study,data=p,sm="PLOGIT",method="Inverse",
 method.tau="REML",method.random.ci="HK",common=FALSE,random=TRUE)
stopifnot(abs(as.numeric(coef(iv))-mp$TE.random)<1e-5)
f<-function(m,label){pr<-predict(m,transf=plogis);data.frame(model=label,k=m$k,
 per100000=pr$pred*1e5,lower=pr$ci.lb*1e5,upper=pr$ci.ub*1e5,tau2=m$tau2)}
export(rbind(f(iv,"logit_IV_REML_HK"),f(gl,"binomial_GLMM_ML")),"R06_prevalence_models.csv")
plot_png("R06_prevalence_forest.png",forest(iv,slab=p$study,atransf=plogis,xlab="Birth prevalence (logit axis)"),height=1400)
print(read.csv(file.path(outdir,"R06_rare_models.csv")));print(read.csv(file.path(outdir,"R06_prevalence_models.csv")))
