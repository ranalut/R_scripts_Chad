

# ==================================
# This is incomplete, doesn't run
# ====================================


# All spp (588)
all_spp <- read.csv('d:/climate_final/final_588_species_2014_08_07.csv',header=TRUE)
print(table(all_spp$AUDUBON_CLIMATE_SENSITIVITY))

# Performance
bbs_eval <- read.csv('d:/climate_evaluation/bbs_evaluation_2000s_model_1980s_1990s_data_tpr_tnr.csv',header=TRUE)
cbc_eval <- read.csv('d:/climate_evaluation/cbc_evaluation_2000s_model_1980s_1990s_data_tpr_tnr.csv',header=TRUE)

# Climate Sensitivities
# bbs_sens <- read.csv('d:/climate_final/bbs_list_2014_08_07.csv',header=TRUE)
# cbc_sens <- read.csv('d:/climate_final/cbc_list_2014_08_07.csv',header=TRUE)

all_spp <- merge(all_spp,bbs_eval[,c('BBL_ABBREV','TPR_KAPPA','TNR_KAPPA','KAPPA')],by ='BBL_ABBREV',all.x=TRUE, sort=FALSE)
# print(head(all_spp)); stop('cbw')

all_spp <- merge(all_spp,cbc_eval[,c('BBL_ABBREV','TPR_KAPPA','TNR_KAPPA','KAPPA')],by ='BBL_ABBREV',all.x=TRUE, sort=FALSE, all.y=FALSE)
# stop('cbw')

# Other ideas...
# 'd:/climate_final/jgs_validation/bbs_change_jgs.csv'
# 'd:/climate_final/jgs_validation/cbc_change_jgs.csv'
# range_change <- read.csv('d:/climate_final/jgs_validation/langham_appendices_s1-10_ranges.csv',header=TRUE)

############################################################
# I need a function that automatically classifies the species looking at both seasons and whether there is a suitable model for each reading in from the % lost from each season.
############################################################

# Proportion of climate T&E species
for (n in seq(0,0.9,0.1))
{
	temp <- all_spp[all_spp$TPR_KAPPA.x >= n | all_spp$TPR_KAPPA.y >= n,]
	# stop('cbw')
	# print(table(temp$AUDUBON_CLIMATE_SENSITIVITY))
	temp_table <- table(temp$AUDUBON_CLIMATE_SENSITIVITY)
	cat('\n\nMIN. TRUE PRESENCE = ',n,'\n')
	cat('# SPECIES = ',dim(temp)[1],'\n')
	cat('STABLE = ',sum(temp_table[c('STABLE','OTHER_INTRODUCED','OTHER_MARGINAL')]),'\n')
	cat('ENDANGERED = ',sum(temp_table[c('ENDANGERED_1','ENDANGERED_2')]),'\n')
	cat('TREATENED = ',sum(temp_table[c('THREATENED_1','THREATENED_2')]),'\n')
	cat('PROPORTION T&E =',sum(temp_table[c('ENDANGERED_1','ENDANGERED_2','THREATENED_1','THREATENED_2')])/dim(temp)[1],'\n')
}





