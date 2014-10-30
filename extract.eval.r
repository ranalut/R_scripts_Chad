library(dismo)

extract.eval <- function(x,metric)
{
	load(x)
	if (metric=='TPR') { output <- evaluateBRT@TPR[which.max(evaluateBRT@kappa)] }
	if (metric=='TNR') { output <- evaluateBRT@TNR[which.max(evaluateBRT@kappa)] }
	if (metric=='prevalence') { output <- evaluateBRT@prevalence } # This is a vector that relates to thresholds.
	if (metric=='kappa') { output <- evaluateBRT@kappa[which.max(evaluateBRT@kappa)] }
	return(output)
}

bbs_eval <- read.csv('d:/climate_evaluation/bbs_evaluation_2000s_model_1980s_1990s_data.csv',header=TRUE)
file_names <- paste('d:/bbs_future/bbs_objects/',bbs_eval$SPECIES,'/',bbs_eval$SPECIES,'_brt_2000s_eval_80s_90s',sep='')
bbs_eval$TPR_KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='TPR',FUN.VALUE=1)
bbs_eval$TNR_KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='TNR',FUN.VALUE=1)
# bbs_eval$PREVALENCE <- vapply(X=file_names,FUN=extract.eval,metric='prevalence',FUN.VALUE=1)
bbs_eval$KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='kappa',FUN.VALUE=1)
write.csv(bbs_eval,'d:/climate_evaluation/bbs_evaluation_2000s_model_1980s_1990s_data_tpr_tnr.csv')
# stop('cbw')

cbc_eval <- read.csv('d:/climate_evaluation/cbc_evaluation_2000s_model_1980s_1990s_data.csv',header=TRUE)
file_names <- paste('d:/cbc_future/cbc_objects/',cbc_eval$SPECIES,'/',cbc_eval$SPECIES,'_brt_2000s_eval_80s_90s',sep='')
cbc_eval$TPR_KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='TPR',FUN.VALUE=1)
cbc_eval$TNR_KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='TNR',FUN.VALUE=1)
cbc_eval$KAPPA <- vapply(X=file_names,FUN=extract.eval,metric='kappa',FUN.VALUE=1)
# cbc_eval$PREVALENCE <- vapply(X=file_names,FUN=extract.eval,metric='prevalence',FUN.VALUE=1)
write.csv(cbc_eval,'d:/climate_evaluation/cbc_evaluation_2000s_model_1980s_1990s_data_tpr_tnr.csv')

