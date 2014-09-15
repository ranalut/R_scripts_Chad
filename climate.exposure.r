library(raster)

load("D:/CBC_Future/prediction2000s.RData")
load("D:/CBC_Future/prediction2080_CFS2.rdata")

var <- c(1,11)
var.names <- c('mean_ann_temp','mean_ann_precip')

pres <- avg1999_2008
fut80 <- list(A2_2080_hccpr,A2_2080_ccma,A2_2080_nies,A2_2080_csiro_mk)
# output <- pres
# pres <- alignExtent(extent(fut80[[1]]),pres)

for (i in 1:length(fut80))
{
	pres.mat <- as.matrix(pres[[1]])
	future <- fut80[[i]]
	names(future) <- names(pres)
	future <- future[[1]]
	future <- as.matrix(future)
	
	temp <- future - pres.mat
	temp <- temp/10
	if (i==1) { output <- raster(temp, ext=extent(fut80[[i]])) }
	else
	{
		output <- addLayer(output,raster(temp,ext=extent(fut80[[i]])))
	}
}

mean.output <- calc(output,fun=mean,filename=paste('D:/Climate_Exposure/',var.names[1],'_mean.tif',sep=''))




# Our #. Bioclim variables
# 1. BIO1 = Annual Mean Temperature
# 2. BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
# 3. BIO3 = Isothermality (BIO2/BIO7) (* 100)
#### BIO4 = Temperature Seasonality (standard deviation *100) # Dropped for our analysis.
# 4. BIO5 = Max Temperature of Warmest Month
# 5. BIO6 = Min Temperature of Coldest Month
# 6. BIO7 = Temperature Annual Range (BIO5-BIO6)
# 7. BIO8 = Mean Temperature of Wettest Quarter
# 8. BIO9 = Mean Temperature of Driest Quarter
# 9. BIO10 = Mean Temperature of Warmest Quarter
# 10. BIO11 = Mean Temperature of Coldest Quarter
# 11. BIO12 = Annual Precipitation
# 12. BIO13 = Precipitation of Wettest Month
# 13. BIO14 = Precipitation of Driest Month
##### BIO15 = Precipitation Seasonality (Coefficient of Variation) # Dropped for our analysis
# 14. BIO16 = Precipitation of Wettest Quarter
# 15. BIO17 = Precipitation of Driest Quarter
# 16. BIO18 = Precipitation of Warmest Quarter
# 17. BIO19 = Precipitation of Coldest Quarter
