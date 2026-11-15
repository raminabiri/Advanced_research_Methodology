# All numerical inputs here are SYNTHETIC; not national Iranian data.
out <- 'outputs/phase6'; dir.create(out,recursive=TRUE,showWarnings=FALSE)
x<-data.frame(scenario=c('baseline','exercise'),deaths=c(10,8),remaining_life=30,prevalent=c(100,150),DW=.2,population=10000)
x$YLL<-x$deaths*x$remaining_life;x$YLD<-x$prevalent*x$DW
x$DALY<-x$YLL+x$YLD;x$crude_rate<-x$DALY/x$population*1e5
stopifnot(identical(x$DALY,c(320,270)))
write.csv(x,file.path(out,'M24_manual_synthetic.csv'),row.names=FALSE)
# Shared latent draw deliberately preserves positive dependence.
set.seed(241115); z<-rnorm(10000)
yll<-300*exp(.12*z);yld<-20*exp(.18*z+.08*rnorm(10000))
res<-data.frame(statistic=c('sum_draws_2.5','sum_draws_97.5','sum_component_lower','sum_component_upper'),value=c(quantile(yll+yld,c(.025,.975)),quantile(yll,.025)+quantile(yld,.025),quantile(yll,.975)+quantile(yld,.975)))
write.csv(res,file.path(out,'M24_draw_intervals_synthetic.csv'),row.names=FALSE)
print(x)
