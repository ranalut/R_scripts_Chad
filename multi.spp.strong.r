
# Run multi-species strongholds

# Adjustable Settings
spp.file <- 'az_multispecies_first_20140718.csv'
	# "Climate Camp Species Lists - CLIMATE_CAMP_ALL.csv"
	# 'priority_species_22may14.csv' 
	# 'test_priority_species_1jul14.csv'
geography <- 'states' # 'misc' # 'states' # 'flyways'
run.zonation <- TRUE
priority <- read.csv(paste("D:/Climate_Strongholds/analyses_",geography,"/",spp.file,sep=''), stringsAsFactors=FALSE)

requests <- colnames(priority)
test <- colnames(priority) %in% c("AOU54_COMMON_NAME","AOU54_SPECIES","BBL_ABBREV","SUMMER","WINTER")
requests <- requests[test==FALSE]
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
	source('build.files.r') # Look here for all other settings, scripts, and file paths.
}

