
# Fill-in fxn
fill.in <- function(values,total)
{
	n <- length(values)
	output <- c(values,rep('',total-n))
	return(output)
}

# Load 588, extract T&E species
full <- read.csv('d:/climate_final/final_588_species_2014_08_07.csv',header=TRUE,stringsAsFactors=FALSE)

# Load habitat info, merge with T&E table
hab <- read.csv("d:/climate_strongholds/strongholds groupings state of the birds v2.csv",header=TRUE,stringsAsFactors=FALSE)
hab_aud <- hab[,c('Code','Audubon_Habitat_Guild','Habitat','Arctic','Coastal','Aridlands','Boreal.Forests','Eastern.Forests','Subtropical.Forests','Western.Forests','Grasslands','Generalist','Marshlands','Oceans')] # ,'Urban.Suburban' Drop this group b/c all species are dropped by non-introduced filter below
colnames(hab_aud) <- c('BBL_ABBREV','habitat',colnames(hab_aud)[-c(1:2)])
test <- duplicated(hab_aud)
hab_aud <- hab_aud[test==FALSE,]
full <- merge(full,hab_aud,all.x=TRUE,sort=FALSE)

# This fixes the Dusky/Sooty Grouse and Arizona/Stricklands Woodpecker mergers. Pacific/Winter Wren is included in SoTB.
full$habitat[is.na(full$habitat)==TRUE] <- 'Wd'
full$Habitat[is.na(full$habitat)==TRUE] <- 'F-W'
full$Western.Forests[is.na(full$habitat)==TRUE] <- '1' 

# All Non-Introduced Species
all_spp <- full[full$AUDUBON_CLIMATE_SENSITIVITY %in% c('ENDANGERED_1','ENDANGERED_2','THREATENED_1','THREATENED_2','STABLE'),]
x <- dim(all_spp)[1]
cat('total spp =',x,'\n')
# print(table(te$Habitat))
prefix <- colnames(all_spp)[-c(1:8)]
# print(prefix); stop('cbw')
# print(print(all_spp$BBL_ABBREV[all_spp[,prefix[1]]==1]); stop('cbw')
temp <- all_spp[,prefix[1]]==1
v <- fill.in(values=all_spp$BBL_ABBREV[is.na(temp)==FALSE],total=x)
output <- data.frame(v,v)
# print(head(output)); stop('cbw')
for (i in 2:length(prefix))
{
	temp <- all_spp[,prefix[i]]==1
	v <- fill.in(values=all_spp$BBL_ABBREV[is.na(temp)==FALSE],total=x)
	output <- cbind(output,v,v)
}
colnames(output) <- paste('n',x,'_',rep(prefix,each=2),c('_winter','_summer'),sep='')
write.csv(output,paste('d:/climate_strongholds/analyses_misc/',x,'_sotb_hab_v1.csv',sep=''),row.names=FALSE)

# T&E Species
te <- full[full$AUDUBON_CLIMATE_SENSITIVITY %in% c('ENDANGERED_1','ENDANGERED_2','THREATENED_1','THREATENED_2'),]
x <- dim(te)[1]
cat('total spp =',x,'\n')
temp <- te[,prefix[1]]==1
v <- fill.in(values=te$BBL_ABBREV[is.na(temp)==FALSE],total=x)
output <- data.frame(v,v)
# print(head(output)); stop('cbw')
for (i in 2:length(prefix))
{
	temp <- te[,prefix[i]]==1
	v <- fill.in(values=te$BBL_ABBREV[is.na(temp)==FALSE],total=x)
	output <- cbind(output,v,v)
}
colnames(output) <- paste('n',x,'_',rep(prefix,each=2),c('_winter','_summer'),sep='')
write.csv(output,paste('d:/climate_strongholds/analyses_misc/',x,'_sotb_hab_v1.csv',sep=''),row.names=FALSE)



