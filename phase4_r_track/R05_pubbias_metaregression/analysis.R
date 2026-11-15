source("phase4_r_track/shared.R")
d<-bcg();m<-rma(yi,vi,data=d,method="REML",test="knha")
eg<-regtest(m,model="rma",predictor="sei")
tf<-trimfill(m)
export(data.frame(method="Egger_rma_SE",statistic=eg$zval,p=eg$pval),"R05_asymmetry.csv")
export(data.frame(added=tf$k0,RR=exp(as.numeric(coef(tf))),lower=exp(tf$ci.lb),upper=exp(tf$ci.ub)),"R05_trimfill.csv")
d$latitude10<-(d$ablat-mean(d$ablat))/10
mr<-rma(yi,vi,mods=~latitude10,data=d,method="REML",test="knha")
export(data.frame(term=rownames(coef(summary(mr))),coef(summary(mr)),row.names=NULL),"R05_metaregression.csv")
# A simple selection-model sensitivity; model assumptions are not verified by fitting it.
# Orient effects so positive values favor vaccination for the one-sided selection model.
sel<-selmodel(rma(-yi,vi,data=d,method="ML"),type="stepfun",steps=0.05)
# Return to vaccine/control RR, reversing interval bounds.
export(data.frame(model="selection_step_0.05",k=sel$k,estimate=exp(-as.numeric(sel$beta)[1]),
 lower=exp(-sel$ci.ub[1]),upper=exp(-sel$ci.lb[1]),tau2=sel$tau2),"R05_selection.csv")
plot_png("R05_funnel.png",funnel(m,xlab="log risk ratio"))
plot_png("R05_bubble.png",regplot(mr,mod="latitude10",xlab="Centered absolute latitude / 10",ylab="log risk ratio"))

# Permutation sensitivity for the pre-specified single moderator.
set.seed(20261115)
perm<-permutest(mr,iter=999,progbar=FALSE)
export(data.frame(term=rownames(perm$beta),p_permutation=perm$pval,seed=20261115,iterations=999),"R05_permutation.csv")
# Peters test is shown for odds ratios, separately from the RR Egger analysis.
if(!requireNamespace("meta",quietly=TRUE))stop("Install meta.")
mo<-meta::metabin(event.e=tpos,n.e=tpos+tneg,event.c=cpos,n.c=cpos+cneg,
 data=d,sm="OR",method="Inverse",method.tau="REML",method.random.ci="HK",common=FALSE,random=TRUE)
pt<-meta::metabias(mo,method.bias="Peters")
export(data.frame(test="Peters_OR",statistic=unname(pt$statistic),p=pt$pval),"R05_peters.csv")

print(coef(summary(mr)));print(eg)
