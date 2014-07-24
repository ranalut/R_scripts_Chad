# Libraries
library(raster)

# Scripts
source('gen.zig3.files.r')
source('build.ensembles.r')

# Adjustable Settings
spp.file <- "Climate Camp Species Lists - CLIMATE_CAMP_ALL.csv"
	# 'priority_species_22may14.csv' 
	# 'test_priority_species_1jul14.csv'
geography <- 'states' # 'misc' # 'states' # 'flyways'
prioritize <- 'tx_coastal'
	# 'fl_coastal' 
	# 'mn_grasslands'
	# 'test2'
	# 'NC_pine_island_priority' # 'NC_pine_island_responsibility' # 'NC_coastal' 
	# 'Any' # NA # 'Pacific' # 'Central' # 'Mississippi' # 'Atlantic' # 'Any'
run.zonation <- FALSE

#####################################################################################
# Standard settings
season <- c('CBC','BBS') # 'CBC' # 'BBS'
true.false <- list(CBC=FALSE,BBS=TRUE)
workspace <- paste("D:/Climate_Strongholds/analyses_",geography,"/",prioritize,"/",sep='')
dir.create(paste(workspace,'run_files/',sep=''), recursive=TRUE)

# Priority species
priority <- read.csv(paste("D:/Climate_Strongholds/analyses_",geography,"/",spp.file,sep=''), stringsAsFactors=FALSE)
the.rows <- grep('X', priority[,prioritize], ignore.case=TRUE)
select.spp <- priority$BBL_ABBREV[the.rows]
cat(prioritize,' priority species: ',select.spp,'\nNumber of Species: ',length(select.spp),'\n')
sink(paste(workspace, prioritize, '.txt',sep=''))
	cat(prioritize,' priority species: ',select.spp,'\nNumber of Species: ',length(select.spp),'\n')
sink()
# stop('cbw')

# Other inputs
CBC <- read.csv("D:/Climate_Strongholds/CBC_list_2014_03_07_all_species.csv", stringsAsFactors=FALSE)
BBS <- read.csv("D:/Climate_Strongholds/BBS_list_2014_03_07_all_species.csv",stringsAsFactors=FALSE)
all.spp <- list(CBC=CBC,BBS=BBS)
strong <- raster('D:/Climate_Strongholds/prioritizations/ensemble_TE_in_BBS_CBC.img')

temp.dat.file <- read.csv("D:/Climate_Strongholds/prioritizations_single_species/dat_template.csv", stringsAsFactors=FALSE)
metadata <- readLines('d:/climate_strongholds/prioritization_metadata_template.xml')

for (k in season)
{
	# Function calls
	gen.zig3.files(
		theData=all.spp[[k]], 
		workspace=workspace, 
		label=prioritize, 
		label.spp=select.spp,
		season=k,
		temp_dat=temp.dat.file,
		append.bat=true.false[[k]],
		run.zig=run.zonation
		)
}
# stop('cbw')

# As yet, I cannot figure out how to use command line to run the batch file.
# cat('zig3run d:\\climate_strongholds\\analyses_',geography,'\\',prioritize,'\\',prioritize,'.bat',sep='')
# readline(prompt='\n\nRun the Zonation batch project\nThen press [enter] to continue')
	
for (k in season)
{
	ensemble.zig3(
		prioritize=prioritize, 
		season=k, 
		strong=strong, 
		workspace=workspace,
		valid.models=all.spp[[k]],
		label.spp=select.spp,
		metadata=metadata
		)
}	
	