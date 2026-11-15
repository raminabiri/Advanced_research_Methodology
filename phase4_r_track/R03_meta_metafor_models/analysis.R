source("phase4_r_track/shared.R")
if(!requireNamespace("meta",quietly=TRUE))stop("Install meta as described in setup.")
d<-bcg()
m<-rma(yi,vi,data=d,method="REML",test="knha")
mt<-meta::metabin(event.e=tpos,n.e=tpos+tneg,event.c=cpos,n.c=cpos+cneg,
 studlab=author,data=d,sm="RR",method="Inverse",method.tau="REML",
 method.random.ci="HK",common=FALSE,random=TRUE)
# Compare methods with identical effect/variance/model/interval settings.
stopifnot(abs(as.numeric(coef(m))-mt$TE.random)<1e-6)
stopifnot(abs(m$tau2-mt$tau2)<1e-5)
comparison<-rbind(model_row(m,"metafor_REML_HK"),
 data.frame(model="meta_REML_HK",k=mt$k,estimate=exp(mt$TE.random),lower=exp(mt$lower.random),upper=exp(mt$upper.random),tau2=mt$tau2))
export(comparison,"R03_package_comparison.csv");print(comparison)
