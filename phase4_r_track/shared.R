# Run all course scripts from the repository root.
extra_lib <- Sys.getenv("SRMA_R_LIB", unset="")
if (nzchar(extra_lib) && dir.exists(extra_lib)) .libPaths(c(extra_lib,.libPaths()))
if (!file.exists("data/shared/bcg.csv")) stop("Set working directory to course root.")
if (!requireNamespace("metafor",quietly=TRUE)) stop("Install metafor.")
suppressPackageStartupMessages(library(metafor))
outdir <- "outputs/phase4"
dir.create(outdir,recursive=TRUE,showWarnings=FALSE)
bcg <- function() {
 d<-read.csv("data/shared/bcg.csv")
 escalc(measure="RR",ai=tpos,bi=tneg,ci=cpos,di=cneg,data=d,add=0)
}
export <- function(x,name) write.csv(x,file.path(outdir,name),row.names=FALSE)
model_row <- function(m,label,ratio=TRUE) {
 f<-if(ratio) exp else identity
 data.frame(model=label,k=m$k,estimate=f(as.numeric(m$beta)[1]),
 lower=f(m$ci.lb[1]),upper=f(m$ci.ub[1]),tau2=if(is.null(m$tau2))NA else m$tau2[1])
}
plot_png <- function(name,expr,width=1400,height=1000) {
 png(file.path(outdir,name),width=width,height=height,res=150)
 on.exit(dev.off()); force(expr)
}
