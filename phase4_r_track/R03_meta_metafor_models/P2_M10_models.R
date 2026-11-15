# P2-M10. Same real BCG data, contrasting specified models.
# Run from repository root: Rscript --vanilla phase4_r_track/R03_meta_metafor_models/P2_M10_models.R
if (!requireNamespace("metafor",quietly=TRUE)) stop("Install metafor first.")
d <- read.csv("data/shared/bcg.csv")
d <- metafor::escalc(measure="RR", ai=tpos,bi=tneg,ci=cpos,di=cneg,data=d,add=0)
stopifnot(nrow(d)==13L,all(is.finite(d$yi)),all(d$vi>0))
models <- list(FE_z=metafor::rma(yi,vi,data=d,method="FE",test="z"),
 DL_z=metafor::rma(yi,vi,data=d,method="DL",test="z"),
 REML_z=metafor::rma(yi,vi,data=d,method="REML",test="z"),
 PM_z=metafor::rma(yi,vi,data=d,method="PM",test="z"),
 REML_HK=metafor::rma(yi,vi,data=d,method="REML",test="knha"))
rows <- lapply(names(models),function(nm) {
 m<-models[[nm]]
 data.frame(model=nm,k=m$k,logRR=as.numeric(coef(m)),SE=m$se,
            RR=exp(as.numeric(coef(m))),RR_lower=exp(m$ci.lb),RR_upper=exp(m$ci.ub),
            tau2=m$tau2,Q=m$QE,I2=m$I2,p=m$pval)
})
out<-do.call(rbind,rows)
w<-data.frame(trial=d$trial,author=d$author,year=d$year,
              FE_percent=as.numeric(weights(models$FE_z)),
              REML_percent=as.numeric(weights(models$REML_z)))
stopifnot(abs(sum(w$FE_percent)-100)<1e-7,abs(sum(w$REML_percent)-100)<1e-7)
stopifnot(isTRUE(all.equal(as.numeric(coef(models$FE_z)),sum(d$yi/d$vi)/sum(1/d$vi))))
# This interval predicts a comparable true effect, not a new study estimate.
pr<-predict(models$REML_HK,transf=exp)
pred<-data.frame(model="REML_HK",RR=pr$pred,CI_lower=pr$ci.lb,CI_upper=pr$ci.ub,
                 PI_lower=pr$pi.lb,PI_upper=pr$pi.ub)
dir.create("data/phase2",showWarnings=FALSE)
write.csv(out,"data/phase2/M10_bcg_models.csv",row.names=FALSE)
write.csv(w,"data/phase2/M10_bcg_weights.csv",row.names=FALSE)
write.csv(pred,"data/phase2/M10_bcg_prediction.csv",row.names=FALSE)
writeLines(c(R.version.string,paste("metafor",packageVersion("metafor"))),
           "data/phase2/M10_environment.txt")
print(out,digits=7,row.names=FALSE);print(w[c(1,4,8),],digits=7)
print(pred,digits=7)
