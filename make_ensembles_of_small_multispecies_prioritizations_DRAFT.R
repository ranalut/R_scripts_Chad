########################################
### this is a template for combining across biological assumptions...you would just substitute
### in the multispecies prioritizations.
###########################################

### This does not combine across seasons (and I didn't do that for the single species prioritizations)

r<-raster(paste("D:/Climate_Strongholds/prioritizations_single_species/run_files/risk/", cbc$BBL_ABBREV[i], "_risk_in_CBC.ABF_EAIG100.rank.asc", sep=""))
o<-raster(paste("D:/Climate_Strongholds/prioritizations_single_species/run_files/opportunity/", cbc$BBL_ABBREV[i], "_opportunity_in_CBC.ABF_EAIG-100.rank.asc", sep=""))
n<-raster(paste("D:/Climate_Strongholds/prioritizations_single_species/run_files/none/", cbc$BBL_ABBREV[i], "_none_in_CBC.ABF_EA.rank.asc", sep=""))

e<-max(r,o,n)
e_v<-as.vector(e)
vals<-rank(e_v, na.last="keep", ties.method="random")
vals<-vals/max(vals, na.rm=T)
ensemble <- setValues(r, vals)

writeRaster(ensemble, paste("D:/Climate_Strongholds/prioritizations_single_species/run_files/ensemble/", cbc$BBL_ABBREV[i], "_ensemble_in_CBC.img", sep=""))

###################################
### This is a template for "trimming the fat" off individual species distributions
### that we probably want to implement for the small multispecies prioritizations as well
### The extension to multispecies prioritizations will require that we tweak this 
### to overlay 95% distribution footprints for all taxa in the prioritization and then rerank
### pixels within the footprint.
##################################

file_pr<-paste("W:/Climate_Strongholds/prioritizations_single_species/run_files/ensemble/", cbc$BBL_ABBREV[i], "_ensemble_in_CBC.img", sep="")
ensemble_pr<-raster(file_pr)

### load maximum 

file_max<-paste("W:/Climate_FINAL/2000_2080_maximum/", cbc$BBL_ABBREV[i], "_2000_2080_B2_A1B_A2_maximum_CBC.img", sep="")
dist_max<-raster(file_max)
nas<-is.na(dist_max)
dist_vals<-dist_max[!nas]

### cumsum values from maximum distribution and set threshold so that 95% of cumulative distribution is identified

o<-order(dist_vals)
ordered_v<-dist_vals[o]
ordered_cs<-cumsum(ordered_v)
x<-length(ordered_cs[ordered_cs<(0.05*max(ordered_cs))])

threshold<-ordered_v[x]

trim<-ensemble_pr[dist_max>threshold]

### rank order from prioritization

ranks<-rank(trim, ties.method="random")
vals<-ranks/max(ranks)

out<-dist_max
out[dist_max>threshold]<-vals
out[dist_max<=threshold]<-0

writeRaster(out, paste("W:/Climate_Strongholds/prioritizations_single_species/run_files/ensemble_trimmed/", cbc$FILE_NAME[i], "_prioritization_95_percent_of_maximum_distribution_CBC.img", sep=""))
