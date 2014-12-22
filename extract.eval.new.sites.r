library(dismo)

# in.suffix <- '_brt_2000s_eval_80s_90s'
# out.suffix <- '_data_tpr_tnr'
in.suffix <- '_brt_2000s_eval_80s_90s_new_sites'
out.suffix <- '_data_tpr_tnr_new_sites'

extract.eval <- function(x,metric)
{
	test <- file.exists(x)
	if(test==FALSE) { return(NA) }
	load(x)
	if (metric=='TPR') { output <- evaluateBRT@TPR[which.max(evaluateBRT@kappa)] }
	if (metric=='TNR') { output <- evaluateBRT@TNR[which.max(evaluateBRT@kappa)] }
	if (metric=='prevalence') { output <- evaluateBRT@prevalence } # This is a vector that relates to thresholds.
	if (metric=='kappa') { output <- evaluateBRT@kappa[which.max(evaluateBRT@kappa)] }
	if (metric=='AUC') { output <- evaluateBRT@auc }
	return(output)
}

bbs_eval <- read.csv('d:/climate_evaluation/bbs_evaluation_2000s_model_1980s_1990s_data.csv',header=TRUE, stringsAsFactors=FALSE)
file_names <- paste('d:/bbs_future/bbs_objects/',bbs_eval$SPECIES,'/',bbs_eval$SPECIES,in.suffix,sep='')
bbs_eval$TPR_KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='TPR',FUN.VALUE=1)
bbs_eval$TNR_KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='TNR',FUN.VALUE=1)
# bbs_eval$PREVALENCE <- vapply(X=file_names,FUN=extract.eval,metric='prevalence',FUN.VALUE=1)
bbs_eval$KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='kappa',FUN.VALUE=1)
bbs_eval$AUC_NEW <- vapply(X=file_names,FUN=extract.eval,metric='AUC',FUN.VALUE=1)
bbs_eval$PREVALENCE <- bbs_eval$PRESENCES_2000_2009/(bbs_eval$PRESENCES_2000_2009 + bbs_eval$ABSENCES_2000_2009)
de_table <- read.csv("D:/BBS_Future/pres_abs_dev_testdata_BBS_2000s_vs_80s_90s_independent.csv",header=TRUE,row.names=1,stringsAsFactors=FALSE)
colnames(de_table) <- c('SPECIES','PRESENCES_NEW','ABSENCES_NEW','DEVIANCE_NEW')
bbs_eval <- merge(bbs_eval,de_table,all.x=TRUE)
bbs_eval$PREVALENCE_NEW <- bbs_eval$PRESENCES_NEW/(bbs_eval$PRESENCES_NEW + bbs_eval$ABSENCES_NEW)
write.csv(bbs_eval,paste('d:/climate_evaluation/bbs_evaluation_2000s_model_1980s_1990s',out.suffix,'.csv',sep=''))
# stop('cbw')

cbc_eval <- read.csv('d:/climate_evaluation/cbc_evaluation_2000s_model_1980s_1990s_data.csv',header=TRUE, stringsAsFactors=FALSE)
file_names <- paste('d:/cbc_future/cbc_objects/',cbc_eval$SPECIES,'/',cbc_eval$SPECIES,in.suffix,sep='')
cbc_eval$TPR_KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='TPR',FUN.VALUE=1)
cbc_eval$TNR_KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='TNR',FUN.VALUE=1)
cbc_eval$KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='kappa',FUN.VALUE=1)
cbc_eval$AUC_NEW <- vapply(X=file_names,FUN=extract.eval,metric='AUC',FUN.VALUE=1)
# cbc_eval$PREVALENCE <- vapply(X=file_names,FUN=extract.eval,metric='prevalence',FUN.VALUE=1)
cbc_eval$PREVALENCE <- cbc_eval$PRESENCES_2000_2009/(cbc_eval$PRESENCES_2000_2009 + cbc_eval$ABSENCES_2000_2009)
de_table <- read.csv("D:/CBC_Future/pres_abs_dev_testdata_CBC_2000s_vs_80s_90s_independent.csv",header=TRUE,row.names=1,stringsAsFactors=FALSE)
colnames(de_table) <- c('SPECIES','PRESENCES_NEW','ABSENCES_NEW','DEVIANCE_NEW')
cbc_eval <- merge(cbc_eval,de_table,all.x=TRUE)
cbc_eval$PREVALENCE_NEW <- cbc_eval$PRESENCES_NEW/(cbc_eval$PRESENCES_NEW + cbc_eval$ABSENCES_NEW)
write.csv(cbc_eval,paste('d:/climate_evaluation/cbc_evaluation_2000s_model_1980s_1990s',out.suffix,'.csv',sep=''))

