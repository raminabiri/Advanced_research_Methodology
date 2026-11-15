source('phase7_advanced_methods/shared.R');library(dosresmeta)
d<-read.csv('data/phase7/alcohol_cvd.csv')
# Real observational data; adjusted log relative-risk measures from mixed designs.
lin<-dosresmeta(logrr~dose,id=id,type=type,se=se,cases=cases,n=n,data=d,method='reml')
# Natural cubic spline with internal knot fixed at empirical median.
# One-stage chosen because some studies have few nonreference categories.
knots<-as.numeric(quantile(d$dose,.5))
bound<-range(d$dose)
nonlin<-dosresmeta(logrr~splines::ns(dose,knots=knots,Boundary.knots=bound),id=id,type=type,se=se,cases=cases,n=n,data=d,method='reml',proc='1stage',control=list(maxiter=1000))
grid<-data.frame(dose=seq(0,max(d$dose),length.out=101))
p1<-predict(lin,newdata=grid,xref=0,expo=TRUE)
p2<-predict(nonlin,newdata=grid,xref=0,expo=TRUE)
put(cbind(grid,as.data.frame(p1)),'M32_linear_prediction.csv')
put(cbind(grid,as.data.frame(p2)),'M32_spline_prediction.csv')
capture.output(summary(lin),file=file.path(out,'M32_linear.txt'));capture.output(summary(nonlin),file=file.path(out,'M32_spline.txt'))
put(data.frame(internal_knots=knots),'M32_knots.csv')
# Wald joint test of departures from the spline's linear subspace, using coefficients.
# ns basis coefficients do not designate "first linear, others nonlinear".
# Thus no invalid test dropping arbitrary ns coefficients is performed here.
fig('M32_curve.png',{plot(grid$dose,p2$pred,type='l',ylim=range(c(p2$ci.lb,p2$ci.ub)),xlab='Dose (g/day)',ylab='Relative risk vs 0');lines(grid$dose,p2$ci.lb,lty=2);lines(grid$dose,p2$ci.ub,lty=2);abline(h=1,lty=3)})
stopifnot(length(unique(d$id))==6,abs(p2$pred[1]-1)<1e-8)
# Valid 1-df Wald test for nonlinearity in the two-dimensional natural spline.
# Express the linear dose vector in the CENTERED spline basis; test its orthogonal constraint.
Braw<-splines::ns(d$dose,knots=knots,Boundary.knots=bound)
B0<-as.numeric(predict(Braw,newx=0))
B<-sweep(Braw,2,B0,'-')
linear_direction<-as.numeric(qr.solve(B,d$dose))
stopifnot(ncol(B)==2,max(abs(B%*%linear_direction-d$dose))<1e-8)
L<-matrix(c(-linear_direction[2],linear_direction[1]),nrow=1)
q<-as.numeric(L%*%coef(nonlin));varq<-as.numeric(L%*%vcov(nonlin)%*%t(L))
W<-q^2/varq
put(data.frame(Wald_chisq=W,df=1,p=pchisq(W,df=1,lower.tail=FALSE)),'M32_nonlinearity_Wald.csv')
