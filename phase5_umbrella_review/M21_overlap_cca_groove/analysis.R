# Teaching matrix is synthetic, not extracted from Singh.
d <- read.csv('data/phase5/overlap_synthetic.csv',row.names=1)
stopifnot(all(as.matrix(d) %in% c(0,1)), !anyDuplicated(rownames(d)))
cca <- function(m) {
 m <- m[rowSums(m)>0,,drop=FALSE]
 r <- nrow(m); cc <- ncol(m)
 if(r==0 || cc<2) return(NA_real_)
 (sum(m)-r)/(r*cc-r)
}
pairs <- combn(names(d),2,simplify=FALSE)
res <- rbind(data.frame(comparison='overall',CCA=cca(d)),
 do.call(rbind,lapply(pairs,function(x)data.frame(comparison=paste(x,collapse=':'),CCA=cca(d[,x,drop=FALSE])))))
stopifnot(isTRUE(all.equal(res$CCA,c(.5,.75,.2,.4))))
dir.create('outputs/phase5',recursive=TRUE,showWarnings=FALSE)
write.csv(res,'outputs/phase5/overlap_results.csv',row.names=FALSE)
print(res)
