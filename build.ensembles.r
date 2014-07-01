
library(raster)

season <- 'BBS' # 'CBC' # 'BBS'
geography <- 'states'
prioritize <- 
'NC_pine_island_priority'
# 'NC_pine_island_responsibility' 
# 'NC_coastal' 
# NA # 'Pacific' # 'Central' # 'Mississippi' # 'Atlantic' # 'Any'
workspace <- paste("D:/Climate_Strongholds/",geography,"_analyses/",prioritize,"/",sep='')
strong <- raster('D:/Climate_Strongholds/prioritizations/ensemble_TE_in_BBS_CBC.img')

# Ensemble
r <- raster(paste(workspace,"prioritizations/risk_",prioritize,"_in_",season,".ABF_EAIG100.rank.asc", sep=""))
o <- raster(paste(workspace,"prioritizations/opportunity_",prioritize,"_in_",season,".ABF_EAIG-100.rank.asc", sep=""))
n <- raster(paste(workspace,"prioritizations/none_",prioritize,"_in_",season,".ABF_EA.rank.asc", sep=""))

e <- max(r,o,n)
e_v <- as.vector(e)
vals <- rank(e_v, na.last="keep", ties.method="random")
vals <- vals/max(vals, na.rm=T)
ensemble <- setValues(strong, vals)
plot(ensemble)

writeRaster(ensemble, paste(workspace, prioritize,"_ensemble_in_",season,".img", sep=""), overwrite=TRUE)
# stop('cbw')


### define maximum distn
priority <- read.csv(paste("D:/Climate_Strongholds/",geography,"_analyses/priority_species_22may14.csv",sep=''), stringsAsFactors=FALSE)
the.rows <- grep('X', priority[,prioritize], ignore.case=TRUE)
select.spp <- priority$BBL_ABBREV[the.rows]
if (season=='CBC') { valid.models <- read.csv("D:/Climate_Strongholds/CBC_list_2014_03_07_all_species.csv", stringsAsFactors=FALSE) }
if (season=='BBS') { valid.models <- read.csv("D:/Climate_Strongholds/BBS_list_2014_03_07_all_species.csv", stringsAsFactors=FALSE) }
select.spp <- select.spp[select.spp %in% valid.models$BBL_ABBREV]
cat(season,' Species',select.spp,'\n')

max.template <- ensemble
max.template[is.na(max.template)==FALSE] <- 0

### cumsum values from maximum distribution and set threshold so that 95% of cumulative distribution is identified
for (i in 1:length(select.spp))
{
	file_max <- paste("D:/Climate_FINAL/2000_2080_maximum/", select.spp[i], "_2000_2080_B2_A1B_A2_maximum_",season,".img", sep="")
	dist_max <- raster(file_max)
	nas <- is.na(dist_max)
	dist_vals <- dist_max[!nas]
	
	o <- order(dist_vals)
	ordered_v <- dist_vals[o]
	ordered_cs <- cumsum(ordered_v)
	x <- length(ordered_cs[ordered_cs < (0.05 * max(ordered_cs))])

	threshold <- ordered_v[x]

	max.template[dist_max > threshold] <- 1
	plot(max.template)
}
# stop('cbw')

### rank order from prioritization
trim <- ensemble[max.template==1]
ranks <- rank(trim, ties.method="random")
vals <- ranks/max(ranks)

out <- max.template
out[max.template==1] <- vals
# out[dist_max<=threshold]<-0

plot(out)
writeRaster(out, paste(workspace, prioritize,"_ensemble_in_",season,"_trim_95p.img", sep=""), overwrite=TRUE)
