extra<-Sys.getenv('SRMA_R_LIB','');if(nzchar(extra)).libPaths(c(extra,.libPaths()))
if(!file.exists('data/shared/bcg.csv'))stop('Run from repository root.')
out<-'outputs/phase7';dir.create(out,recursive=TRUE,showWarnings=FALSE)
put<-function(x,name)write.csv(x,file.path(out,name),row.names=FALSE)
fig<-function(name,expr){png(file.path(out,name),1400,1000,res=150);on.exit(dev.off());force(expr)}
