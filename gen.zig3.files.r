# File-generating function
gen.zig3.files <- function(theData, workspace, season, label, label.spp, temp_dat, append.bat, run.zig)
{
	theData <- theData[theData$BBL_ABBREV %in% label.spp,]
	cat(season,' Species',theData$BBL_ABBREV,'\n')
	sink(paste(workspace, label, '.txt',sep=''), append=TRUE)
		cat(season,' Species',theData$BBL_ABBREV,'\n')
	sink()
	
	sink(paste(workspace, label, '.bat',sep=''), append=append.bat)
		cat(paste('call zig4.exe -r ',workspace,'run_files/',label,'_settings_opportunity_in_',season,'.dat ',workspace,'run_files/',label,'_',season,'_25.spp ',workspace,'prioritizations/opportunity_',label,'_in_',season,'.txt -1.0 0 0.0 0 --use-threats 4 --grid-output-formats tif',sep=''),'\n\n')
		cat(paste('call zig4.exe -r ',workspace,'run_files/',label,'_settings_risk_in_',season,'.dat ',workspace,'run_files/',label,'_',season,'_25.spp ',workspace,'prioritizations/risk_',label,'_in_',season,'.txt 1.0 0 0.0 0 --use-threats 4 --grid-output-formats tif',sep=''),'\n\n')
		cat(paste('call zig4.exe -r ',workspace,'run_files/',label,'_settings_none_in_',season,'.dat ',workspace,'run_files/',label,'_',season,'_25.spp ',workspace,'prioritizations/none_',label,'_in_',season,'.txt 0 0 0.0 0 --use-threats 4 --grid-output-formats tif',sep=''),'\n\n')
	sink()
	
	# Generate .spp files
	outname<-paste(workspace, 'run_files/', label, "_",season,"_25.spp", sep="")
	write.table(theData$SPP_FILE, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)

	outname<-paste(workspace, 'run_files/', label, "_risk_",season,".spp", sep="")
	write.table(theData$RISK_FILE, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)

	outname<-paste(workspace, 'run_files/', label, "_opportunity_",season,".spp", sep="")
	write.table(theData$OPP_FILE, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)

	# Drop the loops, need one per scenario*season combo.
	temp_dat[30,1]<-paste("Info-gap weights file = ",workspace,"run_files/", label, "_risk_",season,".spp", sep="")
	outname<-paste(workspace, 'run_files/', label, "_settings_risk_in_",season,".dat", sep="")
	write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)

	temp_dat[30,1]<-paste("Info-gap weights file = ",workspace,"run_files/", label, "_opportunity_",season,".spp", sep="")
	outname<-paste(workspace, 'run_files/', label, "_settings_opportunity_in_",season,".dat", sep="")
	write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)

	temp_dat[29,1]<-paste("use info-gap weights  = 0", sep="")
	outname<-paste(workspace, 'run_files/', label, "_settings_none_in_",season,".dat", sep="")
	write.table(temp_dat, outname, qmethod=c("escape"), quote=F, row.names=F, col.names=F)
	
	if (run.zig==TRUE)
	{
		# shell(paste('zig4run.exe ',workspace, label, '.bat',sep=''))
		shell(paste('zig4.exe -r ',workspace,'run_files/',label,'_settings_opportunity_in_',season,'.dat ',workspace,'run_files/',label,'_',season,'_25.spp ',workspace,'prioritizations/opportunity_',label,'_in_',season,'.txt -1.0 0 0.0 0 --use-threads 16 --grid-output-formats tif',sep=''))
		shell(paste('zig4.exe -r ',workspace,'run_files/',label,'_settings_risk_in_',season,'.dat ',workspace,'run_files/',label,'_',season,'_25.spp ',workspace,'prioritizations/risk_',label,'_in_',season,'.txt 1.0 0 0.0 0 --use-threads 16 --grid-output-formats tif',sep=''))
		shell(paste('call zig4.exe -r ',workspace,'run_files/',label,'_settings_none_in_',season,'.dat ',workspace,'run_files/',label,'_',season,'_25.spp ',workspace,'prioritizations/none_',label,'_in_',season,'.txt 0 0 0.0 0 --use-threads 16 --grid-output-formats tif',sep=''))
	}
}
