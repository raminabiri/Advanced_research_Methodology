source("phase4_r_track/shared.R")
d<-read.csv("data/shared/bcg.csv",stringsAsFactors=FALSE)
stopifnot(nrow(d)==13L,!anyDuplicated(d$trial))
d$n_vaccine<-d$tpos+d$tneg;d$n_control<-d$cpos+d$cneg
summary_table<-data.frame(studies=nrow(d),vaccine_total=sum(d$n_vaccine),control_total=sum(d$n_control))
export(summary_table,"R01_data_summary.csv")
export(d[order(d$year),],"R01_sorted_bcg.csv")
print(summary_table)
