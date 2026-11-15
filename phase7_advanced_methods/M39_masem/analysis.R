source('phase7_advanced_methods/shared.R');library(metaSEM)
OpenMx::mxOption(NULL,'Number of Threads',1)
data('Becker09',package='metaSEM')
# Real correlation matrices from Craft et al. (2003), selected in Becker (2009).
stopifnot(length(Becker09$data)==10,length(Becker09$n)==10)
for(i in seq_along(Becker09$data)){
 z<-Becker09$data[[i]]
 stopifnot(isSymmetric(z),all(diag(z)[!is.na(diag(z))]==1))
 observed<-which(!is.na(diag(z))); z_obs<-z[observed,observed,drop=FALSE]
 if(!anyNA(z_obs))stopifnot(min(eigen(z_obs,symmetric=TRUE)$values)>0)
}
saveRDS(Becker09,'data/phase7/becker09_real.rds')
put(data.frame(study=seq_along(Becker09$n),n=Becker09$n),'M39_sample_sizes.csv')
model<-'Performance ~ Cog2Per*Cognitive + SO2Per*Somatic + SC2Per*Self_confidence
Self_confidence ~ Cog2SC*Cognitive + SO2SC*Somatic
Cognitive ~~ 1*Cognitive
Somatic ~~ 1*Somatic
Cognitive ~~ cor*Somatic
Performance ~~ var_Per*Performance
Self_confidence ~~ var_SC*Self_confidence'
RAM<-lavaan2RAM(model,obs.variables=c('Performance','Cognitive','Somatic','Self_confidence'))
s1<-tssem1(Becker09$data,Becker09$n,method='REM',RE.type='Diag',suppressWarnings=FALSE)
s2<-tssem2(s1,Amatrix=RAM$A,Smatrix=RAM$S,diag.constraints=TRUE,intervals.type='z',suppressWarnings=FALSE)
capture.output(summary(s1),file=file.path(out,'M39_TSSEM_stage1.txt'))
capture.output(summary(s2),file=file.path(out,'M39_TSSEM_stage2.txt'))
# Fit indices are informative only after convergence and identification checks.
put(data.frame(parameter=names(coef(s2)),estimate=coef(s2)),'M39_paths.csv')
fixed1<-tssem1(Becker09$data,Becker09$n,method='FEM',suppressWarnings=FALSE)
fixed2<-tssem2(fixed1,Amatrix=RAM$A,Smatrix=RAM$S,diag.constraints=TRUE,intervals.type='z',suppressWarnings=FALSE)
capture.output(summary(fixed2),file=file.path(out,'M39_fixed_sensitivity.txt'))
# One-stage MASEM applies the same structural model directly to study matrices.
cd<-Cor2DataFrame(Becker09$data,Becker09$n)
one<-osmasem(RAM=RAM,data=cd,RE.type='Diag',suppressWarnings=FALSE)
capture.output(summary(one),file=file.path(out,'M39_one_stage.txt'))
saveRDS(list(stage1=s1,stage2=s2,one_stage=one),file.path(out,'M39_models.rds'))
stopifnot(s1$mx.fit$output$status$code %in% c(0,1),s2$mx.fit$output$status$code %in% c(0,1))

# Main example is saturated (df=0): perfect fit is not evidence for the theory.
# An explicitly educational constrained model removes both direct anxiety paths.
restricted<-gsub('Performance ~ Cog2Per*Cognitive + SO2Per*Somatic + SC2Per*Self_confidence',
 'Performance ~ SC2Per*Self_confidence',model,fixed=TRUE)
ram_r<-lavaan2RAM(restricted,obs.variables=c('Performance','Cognitive','Somatic','Self_confidence'))
s2r<-tssem2(s1,Amatrix=ram_r$A,Smatrix=ram_r$S,diag.constraints=TRUE,intervals.type='z',suppressWarnings=FALSE)
capture.output(summary(s2r),file=file.path(out,'M39_restricted_stage2.txt'))
stopifnot(s2r$mx.fit$output$status$code %in% c(0,1))
