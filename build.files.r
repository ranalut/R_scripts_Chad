# Scripts
source('gen.zig3.files.r')
source('build.ensembles.r')

# Settings
geography <- 'misc' # 'states' # 'flyways'
prioritize <- 'test2'
	# 'NC_pine_island_priority' # 'NC_pine_island_responsibility' # 'NC_coastal' 
	# 'Any' # NA # 'Pacific' # 'Central' # 'Mississippi' # 'Atlantic' # 'Any'
season <- c('CBC','BBS') # 'CBC' # 'BBS'
true.false <- list(CBC=FALSE,BBS=TRUE)
workspace <- paste("D:/Climate_Strongholds/analyses_",geography,"/",prioritize,"/",sep='')
spp.file <- 'test_priority_species_1jul14.csv'

# Priority species
priority <- read.csv(paste("D:/Climate_Strongholds/analyses_",geography,"/",spp.file,sep=''), stringsAsFactors=FALSE)
the.rows <- grep('X', priority[,prioritize], ignore.case=TRUE)
select.spp <- priority$BBL_ABBREV[the.rows]
cat(prioritize,' priority species: ',select.spp,'\nNumber of Species: ',length(select.spp),'\n')
# stop('cbw')

# Other inputs
CBC <- read.csv("D:/Climate_Strongholds/CBC_list_2014_03_07_all_species.csv", stringsAsFactors=FALSE)
BBS <- read.csv("D:/Climate_Strongholds/BBS_list_2014_03_07_all_species.csv",stringsAsFactors=FALSE)
all.spp <- list(CBC=CBC,BBS=BBS)
strong <- raster('D:/Climate_Strongholds/prioritizations/ensemble_TE_in_BBS_CBC.img')

dir.create(paste(workspace,'run_files/',sep=''), recursive=TRUE)
temp.dat.file <- read.csv("D:/Climate_Strongholds/prioritizations_single_species/dat_template.csv", stringsAsFactors=FALSE)

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
		append.bat=true.false[[k]]
		)
}
# stop('cbw')

# As yet, I cannot figure out how to use command line to run the batch file.
readline(prompt="\n\nLoad and run the Zonation project\nThen press [enter] to continue")
# command <- paste('zig3 -r D:/Climate_Strongholds/analyses_states/NC_coastal/NC_coastal.bat',,sep='')
# command <- 'D: && cd D:/Climate_Strongholds/analyses_misc/test20/ && test20.bat'
# shell(command)
	
for (k in season)
{
	ensemble.zig3(
		prioritize=prioritize, 
		season=k, 
		strong=strong, 
		workspace=workspace,
		valid.models=all.spp[[k]],
		label.spp=select.spp
		)
}	
	