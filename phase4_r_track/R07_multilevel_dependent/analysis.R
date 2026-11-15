source("phase4_r_track/shared.R")
d<-read.csv("data/shared/berkey1998.csv")
d$outcome<-factor(d$outcome,levels=c("PD","AL"))
# Preserve PD, AL order: the covariance columns use that same order.
stopifnot(all(d$outcome[seq(1,nrow(d),by=2)]=="PD"),all(d$outcome[seq(2,nrow(d),by=2)]=="AL"))
V<-bldiag(lapply(split(d,d$trial),function(x)as.matrix(x[,c("v1i","v2i")])))
stopifnot(isSymmetric(V),min(eigen(V,symmetric=TRUE,only.values=TRUE)$values)>0)
m<-rma.mv(yi,V,mods=~outcome-1,random=~outcome|trial,struct="UN",data=d,method="REML")
export(data.frame(term=rownames(coef(summary(m))),coef(summary(m)),row.names=NULL),"R07_multivariate.csv")
export(data.frame(component=c("tau2_PD","tau2_AL","rho"),value=c(m$tau2,m$rho)),"R07_components.csv")
# Robust inference has only five independent studies: low degrees of freedom matter.
if(!requireNamespace("clubSandwich",quietly=TRUE))stop("Install clubSandwich.")
cr<-clubSandwich::coef_test(m,vcov="CR2",cluster=d$trial,test="Satterthwaite")
export(as.data.frame(cr),"R07_CR2.csv")
# A diagonal V is an explicitly misspecified teaching contrast, not a recommended model.
naive<-rma.mv(yi,diag(d$vi),mods=~outcome-1,random=~outcome|trial,struct="UN",data=d,method="REML")
export(data.frame(term=rownames(coef(summary(naive))),coef(summary(naive)),row.names=NULL),"R07_diagonal_contrast.csv")
print(coef(summary(m)));print(cr)
