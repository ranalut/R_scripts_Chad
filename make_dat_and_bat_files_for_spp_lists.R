
# Settings
source('gen.zig3.files.r')
geography <- 'states'
prioritize <- 'NC_coastal' # 'Any' # NA # 'Pacific' # 'Central' # 'Mississippi' # 'Atlantic' # 'Any'
workspace <- paste("D:/Climate_Strongholds/",geography,"_analyses/",prioritize,"/",sep='')
dir.create(paste(workspace,'run_files/',sep=''), recursive=TRUE)
temp.dat.file <- read.csv("D:/Climate_Strongholds/prioritizations_single_species/dat_template.csv", stringsAsFactors=FALSE)

# Priority species
priority <- read.csv("D:/Climate_Strongholds/",geography,"_analyses/priority_species_22may14.csv", stringsAsFactors=FALSE)
the.rows <- grep('X', priority[,prioritize], ignore.case=TRUE)
flyway.spp <- priority$BBL_ABBREV[the.rows]
cat(prioritize,' priority species: ',flyway.spp,'\nNumber of Species: ',length(flyway.spp),'\n')
stop('cbw')

# CBC
cbc <- read.csv("D:/Climate_Strongholds/CBC_list_2014_03_07_all_species.csv", stringsAsFactors=FALSE)

gen.zig3.files(
	theData=cbc, 
	workspace=workspace, 
	label=prioritize, 
	label.spp=flyway.spp,
	season='CBC',
	temp_dat=temp.dat.file,
	append.bat=FALSE
	)

# BBS
bbs<-read.csv("D:/Climate_Strongholds/BBS_list_2014_03_07_all_species.csv",stringsAsFactors=FALSE)

gen.zig3.files(
	theData=cbc, 
	workspace=workspace, 
	label=prioritize, 
	label.spp=flyway.spp,
	season='BBS',
	temp_dat=temp.dat.file,
	append.bat=TRUE
	)
