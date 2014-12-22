
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
hab <- read.csv('d:/climate_final/langham_appendicess1-10_rev3_habitat.csv',header=TRUE,stringsAsFactors=FALSE)
hab_aud <- hab[,c('Common.Name','Audubon.Habitat')]
colnames(hab_aud) <- c('AOU54_COMMON_NAME','habitat')
test <- duplicated(hab_aud)
hab_aud <- hab_aud[test==FALSE,]

full <- merge(full,hab_aud,all.x=TRUE)
full$habitat[is.na(full$habitat)==TRUE] <- 'Woodland' # This fixes the Dusky/Sooty Grouse and Pacific/Winter Wren mergers.

# All Non-Introduced Species
te <- full[full$AUDUBON_CLIMATE_SENSITIVITY %in% c('ENDANGERED_1','ENDANGERED_2','THREATENED_1','THREATENED_2','STABLE'),]
x <- dim(te)[1]
cat('total spp =',x,'\n')
print(table(te$habitat))
prior_table <- data.frame(all_winter=rep(NA,x),all_summer=rep(NA,x))
prior_table$all_winter <- te$BBL_ABBREV
prior_table$all_summer <- te$BBL_ABBREV
prior_table$all_grassland_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Grassland'],total=x)
prior_table$all_grassland_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Grassland'],total=x)
prior_table$all_ocean_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Ocean'],total=x)
prior_table$all_ocean_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Ocean'],total=x)
prior_table$all_shrubland_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Shrubland'],total=x)
prior_table$all_shrubland_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Shrubland'],total=x)
prior_table$all_various_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Various'],total=x)
prior_table$all_various_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Various'],total=x)
prior_table$all_wetland_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Wetland'],total=x)
prior_table$all_wetland_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Wetland'],total=x)
prior_table$all_woodland_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Woodland'],total=x)
prior_table$all_woodland_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Woodland'],total=x)

write.csv(prior_table,paste('d:/climate_strongholds/analyses_misc/',x,'_hab_v1.csv',sep=''),row.names=FALSE)

# T&E Species
te <- full[full$AUDUBON_CLIMATE_SENSITIVITY %in% c('ENDANGERED_1','ENDANGERED_2','THREATENED_1','THREATENED_2'),]
x <- dim(te)[1]
cat('total spp =',x,'\n')
print(table(te$habitat))
prior_table <- data.frame(te_winter=rep(NA,x),te_summer=rep(NA,x))
prior_table$te_winter <- te$BBL_ABBREV
prior_table$te_summer <- te$BBL_ABBREV
prior_table$te_grassland_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Grassland'],total=x)
prior_table$te_grassland_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Grassland'],total=x)
prior_table$te_ocean_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Ocean'],total=x)
prior_table$te_ocean_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Ocean'],total=x)
prior_table$te_shrubland_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Shrubland'],total=x)
prior_table$te_shrubland_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Shrubland'],total=x)
prior_table$te_various_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Various'],total=x)
prior_table$te_various_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Various'],total=x)
prior_table$te_wetland_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Wetland'],total=x)
prior_table$te_wetland_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Wetland'],total=x)
prior_table$te_woodland_winter <- fill.in(values=te$BBL_ABBREV[te$habitat=='Woodland'],total=x)
prior_table$te_woodland_summer <- fill.in(values=te$BBL_ABBREV[te$habitat=='Woodland'],total=x)

write.csv(prior_table,paste('d:/climate_strongholds/analyses_misc/',x,'_hab_v1.csv',sep=''),row.names=FALSE)


