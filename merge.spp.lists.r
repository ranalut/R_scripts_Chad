
fn <- '_list_2014_08_07_all_species.csv'

cbc <- read.csv(paste('d:/climate_strongholds/CBC',fn,sep=''),header=TRUE)
bbs <- read.csv(paste('d:/climate_strongholds/BBS',fn,sep=''),header=TRUE)

master <- data.frame(rbind(cbc[,1:4],bbs[,1:4]))

test <- duplicated(master[,3])
master <- master[test==FALSE,]

master$summer <- master$BBL_ABBREV %in% bbs$BBL_ABBREV
master$winter <- master$BBL_ABBREV %in% cbc$BBL_ABBREV

master <- master[order(master$AOU54_COMMON_NAME),]

write.csv(master,paste('d:/climate_strongholds/CBC_BBS',fn,sep=''),row.names=FALSE)
