
ap_9 <- read.csv('d:/climate_evaluation/langham_appendices_s9_evaluation.csv',header=TRUE)
# print(head(ap_9))

# BBS
bbs_met <- read.csv('d:/climate_evaluation/bbs_evaluation_2000s_model_1980s_1990s_data_tpr_tnr.csv',header=TRUE)
bbs_met <- bbs_met[,c(6,17:19)]
colnames(bbs_met) <- c('Scientific.Name','BBS_TRUE_POSITIVE_RATE','BBS_TRUE_NEGATIVE_RATE','BBS_KAPPA')
ap_9 <- merge (ap_9, bbs_met, sort=FALSE, all.x=TRUE)
ap_9 <- ap_9[,c(1:6,11:13,7:10)]
ap_9$BBS_TRUE_POSITIVE_RATE[is.na(ap_9$BBS_AUC)==TRUE] <- NA
ap_9$BBS_TRUE_NEGATIVE_RATE[is.na(ap_9$BBS_AUC)==TRUE] <- NA
ap_9$BBS_KAPPA[is.na(ap_9$BBS_AUC)==TRUE] <- NA

# CBC
cbc_met <- read.csv('d:/climate_evaluation/cbc_evaluation_2000s_model_1980s_1990s_data_tpr_tnr.csv',header=TRUE)
cbc_met <- cbc_met[,c(6,17:19)]
colnames(cbc_met) <- c('Scientific.Name','CBC_TRUE_POSITIVE_RATE','CBC_TRUE_NEGATIVE_RATE','CBC_KAPPA')
ap_9 <- merge (ap_9, cbc_met, sort=FALSE, all.x=TRUE)
ap_9$CBC_TRUE_POSITIVE_RATE[is.na(ap_9$CBC_AUC)==TRUE] <- NA
ap_9$CBC_TRUE_NEGATIVE_RATE[is.na(ap_9$CBC_AUC)==TRUE] <- NA
ap_9$CBC_KAPPA[is.na(ap_9$CBC_AUC)==TRUE] <- NA

ap_9 <- ap_9[order(ap_9$Common.Name),]

cat('\t\tmean\tmedian\tsd\n')
cat('BBS\tTPR\t',round(mean(ap_9$BBS_TRUE_POSITIVE_RATE,na.rm=TRUE),3),'\t',round(median(ap_9$BBS_TRUE_POSITIVE_RATE,na.rm=TRUE),3),'\t',round(sd(ap_9$BBS_TRUE_POSITIVE_RATE,na.rm=TRUE),3),'\n')
cat('BBS\tTNR\t',round(mean(ap_9$BBS_TRUE_NEGATIVE_RATE,na.rm=TRUE),3),'\t',round(median(ap_9$BBS_TRUE_NEGATIVE_RATE,na.rm=TRUE),3),'\t',round(sd(ap_9$BBS_TRUE_NEGATIVE_RATE,na.rm=TRUE),3),'\n')
cat('BBS\tKAPPA\t',round(mean(ap_9$BBS_KAPPA,na.rm=TRUE),3),'\t',round(median(ap_9$BBS_KAPPA,na.rm=TRUE),3),'\t',round(sd(ap_9$BBS_KAPPA,na.rm=TRUE),3),'\n')

cat('CBC\tTPR\t',round(mean(ap_9$CBC_TRUE_POSITIVE_RATE,na.rm=TRUE),3),'\t',round(median(ap_9$CBC_TRUE_POSITIVE_RATE,na.rm=TRUE),3),'\t',round(sd(ap_9$CBC_TRUE_POSITIVE_RATE,na.rm=TRUE),3),'\n')
cat('CBC\tTNR\t',round(mean(ap_9$CBC_TRUE_NEGATIVE_RATE,na.rm=TRUE),3),'\t',round(median(ap_9$CBC_TRUE_NEGATIVE_RATE,na.rm=TRUE),3),'\t',round(sd(ap_9$CBC_TRUE_NEGATIVE_RATE,na.rm=TRUE),3),'\n')
cat('CBC\tKAPPA\t',round(mean(ap_9$CBC_KAPPA,na.rm=TRUE),3),'\t',round(median(ap_9$CBC_KAPPA,na.rm=TRUE),3),'\t',round(sd(ap_9$CBC_KAPPA,na.rm=TRUE),3),'\n')

# stop('cbw')

ap_9 <- ap_9[,-match(c('BBS_KAPPA','CBC_KAPPA',"BBS_SAMPLING_INSIDE_BIRDLIFE_RANGE","BBS_INSIDE_OUTSIDE_BIRDLIFE_RANGE_RATIO","CBC_SAMPLING_INSIDE_BIRDLIFE_RANGE","CBC_INSIDE_OUTSIDE_BIRDLIFE_RANGE_RATIO"),colnames(ap_9))]
ap_9[,3:10] <- round(ap_9[,3:10],3)

write.csv(ap_9,'d:/climate_evaluation/langham_appendices_s9_evaluation_v3.csv')
# stop('cbw')

# Bring in new Birdlife Metric
eval_final <- read.csv("d:/climate_evaluation/model assessment both seasons birdlife.csv", header=TRUE)
eval_final <- eval_final[,-c(11:13)]
eval_final[,7:10] <- round(eval_final[,7:10],3)
# colnames(eval_final)[7] <- 'BBS_DE'; colnames(eval_final)[8] <- 'CBC_DE'

eval_final <- merge(eval_final[,-c(7:8)],ap_9[,-c(2,3,7)],all.x=TRUE,sort=FALSE)
write.csv(eval_final,'d:/climate_evaluation/model_evaluation_metrics_29oct14.csv')


