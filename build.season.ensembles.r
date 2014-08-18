
ensemble.seasons.zig3 <- function(prioritize, strong, workspace, valid.models, label.spp, metadata)
{
	# Ensemble
	s <- raster(paste(workspace, prioritize,"_ensemble_in_BBS.img", sep=""))
	w <- raster(paste(workspace, prioritize,"_ensemble_in_CBC.img", sep=""))
	
	e <- max(s,w)
	e_v <- as.vector(e)
	vals <- rank(e_v, na.last="keep", ties.method="random")
	vals <- vals/max(vals, na.rm=T)
	ensemble <- setValues(strong, vals)
	plot(ensemble)

	writeRaster(ensemble, paste(workspace, prioritize,"_ensemble_in_CBC_BBS.img", sep=""), overwrite=TRUE)
	# stop('cbw')

	theData.w <- valid.models[[1]][valid.models[[1]]$BBL_ABBREV %in% label.spp,]
	w.spp <- theData.w$BBL_ABBREV
	cat('Winter',' Species',w.spp,'\n')
	
	theData.s <- valid.models[[2]][valid.models[[2]]$BBL_ABBREV %in% label.spp,]
	s.spp <- theData.s$BBL_ABBREV
	cat('Summer',' Species',s.spp,'\n')
	
	# Metadata 
	keywords <- c('winter summer','CBC BBS','multi-species prioritization')
	new.metadata <- gsub(pattern='<keyword>placeholder</keyword>', replacement=paste('<keyword>',paste(keywords,collapse=' '),'</keyword>',sep=''), x=metadata)
	new.metadata <- gsub(pattern='<resTitle>placeholder</resTitle>', replacement=paste('<resTitle>',prioritize,"_ensemble_in_winter_summer_trim_95p.img",'</resTitle>',sep=''), x=new.metadata)
	new.metadata <- gsub(pattern='P STYLE="margin:0 0 8 0;"&gt;&lt;SPAN&gt;placeholder; placeholder&lt;/SPAN&gt;&lt;/P&gt;&lt;', replacement=paste('P STYLE="margin:0 0 8 0;"&gt;&lt;SPAN&gt;Winter: ',paste(theData.w$AOU54_COMMON_NAME,collapse='; '),'&lt;/SPAN&gt;&lt;/P&gt;&lt;P STYLE="margin:0 0 8 0;"&gt;&lt;SPAN&gt;Summer: ',paste(theData.s$AOU54_COMMON_NAME,collapse='; '),'&lt;/SPAN&gt;&lt;/P&gt;&lt;',sep=''), x=new.metadata)
	new.metadata <- gsub(pattern='P STYLE="margin:0 0 8 0;"&gt;&lt;SPAN&gt;placeholder&lt;/SPAN&gt;&lt;/P&gt;&lt;', replacement=paste('P STYLE="margin:0 0 8 0;"&gt;&lt;SPAN&gt;','Ensemble of winter and summer.  Winter based on Christmas Bird Count (CBC) data. Summer based on Breeding Bird Survey (BBS) data.','&lt;/SPAN&gt;&lt;/P&gt;&lt;',sep=''), x=new.metadata)
	writeLines(new.metadata, paste(workspace, prioritize,"_ensemble_in_winter_summer_trim_95p.img.xml", sep=""))
	
	# stop('exported metadata')
	
	max.template <- ensemble
	max.template[is.na(max.template)==FALSE] <- 0

	### cumsum values from maximum distribution and set threshold so that 95% of cumulative distribution is identified
	
	for (i in 1:length(w.spp))
	{
		file_max <- paste("D:/Climate_FINAL/2000_2080_maximum/", w.spp[i], "_2000_2080_B2_A1B_A2_maximum_CBC.img", sep="")
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
	
	for (i in 1:length(s.spp))
	{
		file_max <- paste("D:/Climate_FINAL/2000_2080_maximum/", s.spp[i], "_2000_2080_B2_A1B_A2_maximum_BBS.img", sep="")
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
	writeRaster(out, paste(workspace, prioritize,"_ensemble_in_winter_summer_trim_95p.img", sep=""), overwrite=TRUE)
}