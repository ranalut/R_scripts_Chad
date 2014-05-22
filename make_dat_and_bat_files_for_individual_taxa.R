
# Settings
priority.flyway <- 'Pacific' # NA
workspace <- paste("D:/Climate_Strongholds/flyways_analyses/",priority.flyway,"/run_files/",sep='')
dir.create(workspace, recursive=TRUE)

# Priority species
priority <- read.csv("D:/Climate_Strongholds/flyways_analyses/priority_species_22may14.csv", stringsAsFactors=FALSE)
flyway.spp <- priority$BBL_ABBREV[priority$Flyway==priority.flyway]
cat(priority.flyway,' priority species: ',flyway.spp,'\n')
# stop('cbw')

# CBC
cbc<-read.csv("D:/Climate_Strongholds/CBC_list_2014_03_07_all_species.csv",stringsAsFactors=FALSE)

cbc_e<-grep("ENDANGERED", cbc$CBC_SENSITIVITY)
cbc_t<-grep("THREATENED", cbc$CBC_SENSITIVITY)
cbc_te<-c(cbc_t,cbc_e)
cbc<-cbc[cbc_te,]
if (is.na(priority.flyway)==FALSE) 
{ 
	cbc <- cbc[cbc$BBL_ABBREV %in% flyway.spp,]
	cat('CBC Species',cbc$BBL_ABBREV,'\n')
}
cbc_bat<-write.table(cbc$BAT_FILE_ENTRY_RISK, paste(workspace,"risk_in_CBC.bat",sep=''), qmethod=c("escape"), quote=F, row.names=F, col.names=F)
cbc_bat<-write.table(cbc$BAT_FILE_ENTRY_OPP, paste(workspace,"opportunity_in_CBC.bat",sep=''), qmethod=c("escape"), quote=F, row.names=F, col.names=F)
cbc_bat<-write.table(cbc$BAT_FILE_ENTRY_NONE, paste(workspace,"none_in_CBC.bat",sep=''), qmethod=c("escape"), quote=F, row.names=F, col.names=F)

# Need only one list (drop the for loop)
for (i in 1:length(cbc$BBL_ABBREV)){
  spp_file_name<-paste(cbc$SPP_FILE[i])
  outname<-paste(workspace, cbc$BBL_ABBREV[i], "_CBC_25.spp", sep="")
  write.table(spp_file_name, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

for (i in 1:length(cbc$BBL_ABBREV)){
  spp_file_name<-paste(cbc$RISK_FILE[i])
  outname<-paste(workspace, cbc$BBL_ABBREV[i], "_risk_CBC.spp", sep="")
  write.table(spp_file_name, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}
  
for (i in 1:length(cbc$BBL_ABBREV)){
  spp_file_name<-paste(cbc$OPP_FILE[i])
  outname<-paste(workspace, cbc$BBL_ABBREV[i], "_opportunity_CBC.spp", sep="")
  write.table(spp_file_name, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

temp_dat<-read.csv("D:/Climate_Strongholds/prioritizations_single_species/dat_template.csv", stringsAsFactors=FALSE)

# Drop the loops, need one per scenario*season combo.
for (i in 1:length(cbc$BBL_ABBREV)){
  temp_dat[30,1]<-paste("Info-gap weights file = ", cbc$BBL_ABBREV[i], "_risk_CBC.spp", sep="")
  outname<-paste(workspace, cbc$BBL_ABBREV[i], "_settings_risk_in_CBC.dat", sep="")
  write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

for (i in 1:length(cbc$BBL_ABBREV)){
  temp_dat[30,1]<-paste("Info-gap weights file = ", cbc$BBL_ABBREV[i], "_opportunity_CBC.spp", sep="")
  outname<-paste(workspace, cbc$BBL_ABBREV[i], "_settings_opportunity_in_CBC.dat", sep="")
  write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

for (i in 1:length(cbc$BBL_ABBREV)){
  temp_dat[29,1]<-paste("use info-gap weights  = 0", sep="")
  outname<-paste(workspace, cbc$BBL_ABBREV[i], "_settings_none_in_CBC.dat", sep="")
  write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}
# stop('cbw')

# BBS

bbs<-read.csv("D:/Climate_Strongholds/BBS_list_2014_03_07_all_species.csv",stringsAsFactors=FALSE)

bbs_e<-grep("ENDANGERED", bbs$BBS_SENSITIVITY)
bbs_t<-grep("THREATENED", bbs$BBS_SENSITIVITY)
bbs_te<-c(bbs_t,bbs_e)
bbs<-bbs[bbs_te,]
if (is.na(priority.flyway)==FALSE) 
{ 
	bbs <- bbs[bbs$BBL_ABBREV %in% flyway.spp,]
	cat('BBS Species',bbs$BBL_ABBREV,'\n')
}
bbs_bat<-write.table(bbs$BAT_FILE_ENTRY_RISK, paste(workspace,"risk_in_BBS.bat",sep=''), qmethod=c("escape"), quote=F, row.names=F, col.names=F)
bbs_bat<-write.table(bbs$BAT_FILE_ENTRY_OPP, paste(workspace,"opportunity_in_BBS.bat",sep=''), qmethod=c("escape"), quote=F, row.names=F, col.names=F)
bbs_bat<-write.table(bbs$BAT_FILE_ENTRY_NONE, paste(workspace,"none_in_BBS.bat",sep=''), qmethod=c("escape"), quote=F, row.names=F, col.names=F)

for (i in 1:length(bbs$BBL_ABBREV)){
  spp_file_name<-paste(bbs$SPP_FILE[i])
  outname<-paste(workspace, bbs$BBL_ABBREV[i], "_BBS_25.spp", sep="")
  write.table(spp_file_name, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

for (i in 1:length(bbs$BBL_ABBREV)){
  spp_file_name<-paste(bbs$RISK_FILE[i])
  outname<-paste(workspace, bbs$BBL_ABBREV[i], "_risk_BBS.spp", sep="")
  write.table(spp_file_name, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

for (i in 1:length(bbs$BBL_ABBREV)){
  spp_file_name<-paste(bbs$OPP_FILE[i])
  outname<-paste(workspace, bbs$BBL_ABBREV[i], "_opportunity_BBS.spp", sep="")
  write.table(spp_file_name, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

temp_dat<-read.csv("D:/Climate_Strongholds/prioritizations_single_species/dat_template.csv", stringsAsFactors=FALSE)

for (i in 1:length(bbs$BBL_ABBREV)){
  temp_dat[30,1]<-paste("Info-gap weights file = ", bbs$BBL_ABBREV[i], "_risk_BBS.spp", sep="")
  outname<-paste(workspace, bbs$BBL_ABBREV[i], "_settings_risk_in_BBS.dat", sep="")
  write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

for (i in 1:length(bbs$BBL_ABBREV)){
  temp_dat[30,1]<-paste("Info-gap weights file = ", bbs$BBL_ABBREV[i], "_opportunity_BBS.spp", sep="")
  outname<-paste(workspace, bbs$BBL_ABBREV[i], "_settings_opportunity_in_BBS.dat", sep="")
  write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}

for (i in 1:length(bbs$BBL_ABBREV)){
  temp_dat[29,1]<-paste("use info-gap weights  = 0", sep="")
  outname<-paste(workspace, bbs$BBL_ABBREV[i], "_settings_none_in_BBS.dat", sep="")
  write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
}
