
workspace <- 'd:/climate_evaluation/'
season <- 'bbs'

dep <- read.csv(paste(workspace,season,'_evaluation_2000s_model_1980s_1990s_data_tpr_tnr.csv',sep=''),header=TRUE,stringsAsFactors=FALSE)

ind <- read.csv(paste(workspace,season,'_evaluation_2000s_model_1980s_1990s_data_tpr_tnr_new_sites.csv',sep=''),header=TRUE,stringsAsFactors=FALSE)

sink(paste(workspace,'t.tests.',season,'.txt',sep=''))

cat('############# TPR\n')
vtest <- var.test(dep$TPR,ind$TPR,na.action=na.rm)
print(vtest)
ptest <- t.test(dep$TPR,ind$TPR,paired=TRUE,na.action=na.rm,var.equal=TRUE)
print(ptest)
plot(dep$TPR,ind$TPR)

cat('############# TNR\n')
vtest <- var.test(dep$TNR,ind$TNR,na.action=na.rm)
print(vtest)
ptest <- t.test(dep$TNR,ind$TNR,paired=TRUE,na.action=na.rm)
print(ptest)
plot(dep$TNR,ind$TNR)

cat('############# AUC\n')
vtest <- var.test(ind$BRT_AUC,ind$AUC_NEW,na.action=na.rm) # Both AUC's in independent file
print(vtest)
ptest <- t.test(ind$BRT_AUC,ind$AUC_NEW,paired=TRUE,na.action=na.rm)
print(ptest)
plot(ind$BRT_AUC,ind$AUC_NEW)

cat('############# DEVIANCE\n')
vtest <- var.test(ind$independent_deviance_explained,ind$DEVIANCE,na.action=na.rm) # Both AUC's in independent file
print(vtest)
ptest <- t.test(ind$independent_deviance_explained,ind$DEVIANCE,paired=TRUE,na.action=na.rm)
print(ptest)
plot(ind$independent_deviance_explained,ind$DEVIANCE)

cat('############# DEVIANCE <= 1\n')
ind2 <- ind[ind$DEVIANCE_NEW<=1,]
vtest <- var.test(ind2$independent_deviance_explained,ind2$DEVIANCE,na.action=na.rm) # Both AUC's in independent file
print(vtest)
ptest <- t.test(ind2$independent_deviance_explained,ind2$DEVIANCE,paired=TRUE,na.action=na.rm)
print(ptest)
plot(ind2$independent_deviance_explained,ind2$DEVIANCE)

cat('############# PREVALENCE\n')
vtest <- var.test(ind$PREVALENCE,ind$PREVALENCE_NEW,na.action=na.rm) # Both AUC's in independent file
print(vtest)
ptest <- t.test(ind$PREVALENCE,ind$PREVALENCE_NEW,paired=TRUE,na.action=na.rm,var.equal=TRUE)
print(ptest)
plot(ind$PREVALENCE,ind$PREVALENCE_NEW)

cat('############# PREVALENCE <- 5 PRESENCES\n')
ind3 <- ind[ind$PRESENCES_NEW>=5,]
vtest <- var.test(ind3$PREVALENCE,ind3$PREVALENCE_NEW,na.action=na.rm) # Both AUC's in independent file
print(vtest)
ptest <- t.test(ind3$PREVALENCE,ind3$PREVALENCE_NEW,paired=TRUE,na.action=na.rm,var.equal=TRUE)
print(ptest)
plot(ind3$PREVALENCE,ind3$PREVALENCE_NEW)

sink()
