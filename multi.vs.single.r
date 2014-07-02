library(raster)

###############################
# 5 Species
# spp.codes <- c('AMKE','CASP','CCLO','FEHA','GHOW') # 5, CBC
# season <- 'CBC'
# folder <- 'test5'

# spp.codes <- c('AMKE','CASP','CCLO','FEHA') # 4, BBS
# season <- 'BBS'
# folder <- 'test5'

###############################
# 10 Species
# spp.codes <- c('LEOW','AMKE','CASP','FEHA','GHOW','GRPC','HASP','LALO','LARB','CCLO') # 10, BBS
# season <- 'CBC'
# folder <- 'test10'

# spp.codes <- c('AMKE','CASP','CCLO','FEHA','GRPC','LALO','LARB') # 7, BBS
# season <- 'BBS'
# folder <- 'test10'

###############################
# 3 Species
# spp.codes <- c('AMKE','CASP','CCLO') # 3, CBC
# season <- 'BBS'
# folder <- 'test3'

################################
# 2 Species
spp.codes <- c('CASP','CCLO') # 3, CBC
season <- 'BBS'
folder <- 'test2'

################################
# Multi-species
reclass.m <- matrix(c(0,0.9,0.9),ncol=3,byrow=TRUE)
reclass.s <- matrix(c(0,0.9,0,0.9,1,1),ncol=3,byrow=TRUE)

multi.spp <- raster(paste('D:/Climate_Strongholds/analyses_misc/',folder,'/',folder,'_ensemble_in_',season,'.img',sep=''))
# plot(multi.spp)
m90c <- reclassify(multi.spp, rcl=reclass.m)
plot(m90c)
writeRaster(m90c,paste('D:/Climate_Strongholds/analyses_misc/',folder,'/',folder,'_m90in_',season,'.img',sep=''), overwrite=TRUE)
# stop('cbw')

##################################
# Single-species Means
single.spp <- stack(paste('D:/Climate_Strongholds/prioritizations_single_species/run_files/ensemble/', spp.codes,'_ensemble_in_',season,'.img',sep=''))

s90m <- overlay(single.spp, fun=mean)
top90 <- minValue(s90m) + 0.9 * (maxValue(s90m) - minValue(s90m))
reclass.x <- matrix(c(0,top90,top90),ncol=3,byrow=TRUE)
s90m <- reclassify(s90m, rcl=reclass.x)

plot(s90m)
writeRaster(s90m,paste('D:/Climate_Strongholds/analyses_misc/',folder,'/',folder,'_s90m_in_',season,'.img',sep=''), overwrite=TRUE)

##################################
# Stacked Multi-species
s90 <- reclassify(single.spp, rcl=reclass.s)
s90 <- overlay(s90, fun=sum)

plot(s90)
writeRaster(s90,paste('D:/Climate_Strongholds/analyses_misc/',folder,'/',folder,'_s90_in_',season,'.img',sep=''), overwrite=TRUE)

# s90_v <- as.vector(s90)
# counts <- table(s90_v)
# ncells <- as.numeric(counts[length(counts)])
# # ncells <- length(s90_v[s90_v==length(spp.codes) & is.na(s90_v)==FALSE])

# m_v <- as.vector(multi.spp)
# vals <- m_v[is.na(m_v)==FALSE]

# vals_o <- rev(vals[order(vals)])
# threshold <- vals_o[ncells]
# print(threshold)

# reclass <- matrix(c(0,threshold,0,threshold,1,1),ncol=3,byrow=TRUE)
# m90b <- reclassify(multi.spp, rcl=reclass)
# plot(m90b,main=round(threshold,3))
# writeRaster(m90b,paste('D:/Climate_Strongholds/analyses_misc/',folder,'/',folder,'_m90b_in_',season,'.img',sep=''), overwrite=TRUE)

