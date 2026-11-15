# P2-M09. Real BCG data; analytical re-expression, not a new clinical review.
# Run from repository root: Rscript --vanilla phase4_r_track/R02_data_prep_escalc/P2_M09_effect_sizes.R
if (!requireNamespace("metafor", quietly=TRUE)) stop("Install metafor first.")
d <- read.csv("data/shared/bcg.csv", check.names=FALSE)
stopifnot(nrow(d)==13L, !anyDuplicated(d$trial),
          all(d[c("tpos","tneg","cpos","cneg")] > 0))
d$n_t <- d$tpos+d$tneg; d$n_c <- d$cpos+d$cneg
rr <- metafor::escalc(measure="RR", ai=tpos, bi=tneg, ci=cpos, di=cneg,
                      data=d, add=0)
or <- metafor::escalc(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg,
                      data=d, add=0)
rd <- metafor::escalc(measure="RD", ai=tpos, bi=tneg, ci=cpos, di=cneg,
                      data=d, add=0)
manual_y <- log((d$tpos/d$n_t)/(d$cpos/d$n_c))
manual_v <- 1/d$tpos-1/d$n_t+1/d$cpos-1/d$n_c
stopifnot(isTRUE(all.equal(as.numeric(rr$yi), manual_y)),
          isTRUE(all.equal(as.numeric(rr$vi), manual_v)))
z <- qnorm(0.975)
out <- data.frame(trial=d$trial, author=d$author, year=d$year,
 n_t=d$n_t,n_c=d$n_c,risk_t=d$tpos/d$n_t,risk_c=d$cpos/d$n_c,
 logRR=as.numeric(rr$yi),v_logRR=as.numeric(rr$vi),SE_logRR=sqrt(rr$vi),
 RR=exp(rr$yi),RR_lower=exp(rr$yi-z*sqrt(rr$vi)),RR_upper=exp(rr$yi+z*sqrt(rr$vi)),
 logOR=as.numeric(or$yi),v_logOR=as.numeric(or$vi),OR=exp(or$yi),
 RD=as.numeric(rd$yi),v_RD=as.numeric(rd$vi))
dir.create("data/phase2",showWarnings=FALSE)
write.csv(out,"data/phase2/M09_bcg_effects.csv",row.names=FALSE)
# Synthetic independent-group demonstrations, explicitly not study findings.
smd <- metafor::escalc(measure="SMD",m1i=20,sd1i=5,n1i=25,
                      m2i=25,sd2i=5,n2i=25)
cor <- metafor::escalc(measure="ZCOR",ri=0.5,ni=50)
prop <- metafor::escalc(measure="PLO",xi=20,ni=100)
print(out[1:2,],digits=7)
print(data.frame(example=c("synthetic_SMD","synthetic_ZCOR","synthetic_logit"),
                 yi=c(smd$yi,cor$yi,prop$yi),vi=c(smd$vi,cor$vi,prop$vi)),digits=7)
writeLines(c(R.version.string,paste("metafor",packageVersion("metafor"))),
           "data/phase2/M09_environment.txt")
