
# Run multi-species strongholds

# Adjustable Settings
spp.file <- 'langham_priority_spp.csv'
	# 'af_priority_spp.csv'
	# 'mn_multispecies_no_grasslands.csv'
	# 'az_multispecies_first_20140718.csv'
	# "Climate Camp Species Lists - CLIMATE_CAMP_ALL.csv"
	# 'priority_species_22may14.csv' 
	# 'test_priority_species_1jul14.csv'
geography <- 'misc' # 'misc' # 'states' # 'flyways'
run.zonation <- TRUE
priority <- read.csv(paste("D:/Climate_Strongholds/analyses_",geography,"/",spp.file,sep=''), stringsAsFactors=FALSE)
previous <- '' # Initialize this counter

requests <- colnames(priority)
	# test <- colnames(priority) %in% c("AOU54_COMMON_NAME","AOU54_SPECIES","BBL_ABBREV","SUMMER","WINTER")
	# requests <- requests[test==FALSE]
	# requests <- 'la_delta'
	# 'fl_coastal' # 'tx_coastal' # 'tx_desert' # 'mn_grasslands' # 'la_delta' 
	# 'test2'
	# 'NC_pine_island_priority' # 'NC_pine_island_responsibility' # 'NC_coastal' 
	# 'Any' # NA # 'Pacific' # 'Central' # 'Mississippi' # 'Atlantic' # 'Any'

print(requests)
# stop('cbw')

for (n in requests)
{
	prioritize <- n
	season <- ifelse(grepl('winter',n),'CBC','BBS')
	prefix <- sub('_summer','',n); prefix <- sub('_winter','',prefix)
	if (grepl(prefix,previous)==TRUE) { ensemble.seasons <- TRUE }
	else { ensemble.seasons <- FALSE }
	cat('prioritize',prioritize,'season',season,'prefix',prefix,'ensemble',ensemble.seasons,'\n',sep=' ')
	# stop('cbw')
	source('build.files.r') # Look here for all other settings, scripts, and file paths.
	previous <- n
}

