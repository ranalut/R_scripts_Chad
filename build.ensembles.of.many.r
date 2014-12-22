
ensemble.many6.zig3 <- function(file.paths,strong,out.file)
{
	
	r1 <- raster(file.paths[1])
	r2 <- raster(file.paths[2])
	r3 <- raster(file.paths[3])
	r4 <- raster(file.paths[4])
	r5 <- raster(file.paths[5])
	r6 <- raster(file.paths[6])
	
	e <- max(r1,r2,r3,r4,r5,r6)
	e_v <- as.vector(e)
	vals <- rank(e_v, na.last="keep", ties.method="random")
	vals <- vals/max(vals, na.rm=T)
	ensemble <- setValues(strong, vals)
	plot(ensemble)

	writeRaster(ensemble, out.file, overwrite=TRUE)
}

strong <- raster('D:/Climate_Strongholds/prioritizations/ensemble_TE_in_BBS_CBC.img')
# prefixes <- c('te_woodland','te_wetland','te_various','te_shrubland','te_ocean','te_grassland')
prefixes <- c('all_woodland','all_wetland','all_various','all_shrubland','all_ocean','all_grassland')
# dir.create('d:/climate_strongholds/analyses_misc/te_habitat_ensemble/')
dir.create('d:/climate_strongholds/analyses_misc/all_habitat_ensemble/')
file.paths <- paste('d:/climate_strongholds/analyses_misc/',prefixes,'_summer/',prefixes
,'_ensemble_in_winter_summer_trim_95p.img',sep='')
# print(file.paths); stop('cbw')

ensemble.many6.zig3(
	file.paths=file.paths,
	strong=strong,
	# out.file='d:/climate_strongholds/analyses_misc/te_habitat_ensemble/te_habitat_ensemble.img'
	out.file='d:/climate_strongholds/analyses_misc/all_habitat_ensemble/all_habitat_ensemble.img'
	)
