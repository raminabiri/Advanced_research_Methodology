source("phase4_r_track/shared.R")
d<-bcg();m<-rma(yi,vi,data=d,method="REML",test="knha")
p<-predict(m,transf=exp)
export(data.frame(k=m$k,Q=m$QE,df=m$k-1,Q_p=m$QEp,I2=m$I2,tau2=m$tau2,
 RR=p$pred,CI_lower=p$ci.lb,CI_upper=p$ci.ub,PI_lower=p$pi.lb,PI_upper=p$pi.ub),"R04_heterogeneity.csv")
loo<-leave1out(m)
export(data.frame(removed=d$author,RR=exp(loo$estimate),lower=exp(loo$ci.lb),upper=exp(loo$ci.ub),tau2=loo$tau2),"R04_leave_one_out.csv")
# Categories are existing allocation methods, not an asserted clinical mechanism.
sub<-rma(yi,vi,mods=~factor(alloc),data=d,method="REML",test="knha")
export(data.frame(term=rownames(coef(summary(sub))),coef(summary(sub)),row.names=NULL),"R04_subgroup_coefficients.csv")
export(data.frame(test="allocation_omnibus",QM=sub$QM,df1=sub$QMdf[1],p=sub$QMp),"R04_subgroup_test.csv")
plot_png("R04_forest.png",forest(m,slab=paste(d$author,d$year),atransf=exp,xlab="Risk ratio (log scale)"))
plot_png("R04_influence.png",plot(influence(m)))
print(p);print(coef(summary(sub)))
