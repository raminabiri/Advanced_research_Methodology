# Every numerical dataset generated below is SYNTHETIC.
out<-'outputs/phase6';dir.create(out,recursive=TRUE,showWarnings=FALSE)
weights<-c(.8,.2);rates<-c(100,1000)
stopifnot(sum(weights)==1,sum(weights*rates)==280)
write.csv(data.frame(raw=sum(c(.9,.1)*rates),ASR=sum(weights*rates)),file.path(out,'M27_standardization.csv'),row.names=FALSE)
set.seed(271115);year<-2000:2023;rate<-exp(5+.02*(year-2000)+rnorm(length(year),0,.015))
m<-lm(log(rate)~year); ci<-confint(m)['year',]
write.csv(data.frame(EAPC=100*expm1(coef(m)['year']),lower=100*expm1(ci[1]),upper=100*expm1(ci[2])),file.path(out,'M27_EAPC_synthetic.csv'),row.names=FALSE)
png(file.path(out,'M27_trend_synthetic.png'),1200,800);plot(year,rate,main='Synthetic rates; not GBD estimates');lines(year,exp(fitted(m)));dev.off()
old<-list(N=1000,s=c(.8,.2),r=c(.01,.04));new<-list(N=1200,s=c(.7,.3),r=c(.008,.03))
f<-function(x)x$N*sum(x$s*x$r)
perms<-list(c('N','s','r'),c('N','r','s'),c('s','N','r'),c('s','r','N'),c('r','N','s'),c('r','s','N'))
scores<-setNames(rep(0,3),names(old))
for(ord in perms){state<-old;for(nm in ord){before<-f(state);state[[nm]]<-new[[nm]];scores[nm]<-scores[nm]+f(state)-before}}
scores<-scores/length(perms)
stopifnot(abs(sum(scores)-(f(new)-f(old)))<1e-12,abs(f(new)-17.52)<1e-12)
write.csv(data.frame(component=names(scores),change=as.numeric(scores)),file.path(out,'M27_shapley_synthetic.csv'),row.names=FALSE)
# Descriptive binned lower envelope, NOT a validated frontier model.
sdi<-seq(.2,.9,length.out=30);asr<-1000*(1-sdi)+runif(30,0,250)
bin<-cut(sdi,breaks=seq(.1,1,by=.1));frontier<-ave(asr,bin,FUN=min)
write.csv(data.frame(sdi,asr,bin,descriptive_lower_envelope=frontier),file.path(out,'M27_SDI_synthetic.csv'),row.names=FALSE)
print(scores)
