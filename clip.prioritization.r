library(foreign)

clip.prioritization <- function(
						map='ensemble_te_in_bbs_cbc',
						state.code,
						admin='d:/strongholds/states_ras',
						output='d:/climate_strongholds/analyses_states/'
						)
{
	all.states <- read.csv('d:/climate_strongholds/analyses_states/states.csv',header=TRUE)
	state.ras <- read.dbf('d:/climate_strongholds/analyses_states/states51.dbf',as.is=TRUE)
	# print(head(state.ras)); stop('cbw')
	state.id <- all.states[all.states$STUSPS==state.code,'GEOID']
	state.id <- state.ras[state.ras$GEOID==state.id,'VALUE']
	
	# print(state.id)
	state <- raster(admin)
	# plot(state)
	state[state!=state.id] <- NA
	# plot(state)
	
	p <- raster(paste('d:/climate_strongholds/prioritizations/',map,'.img',sep=''))
	# plot(p)
	p <- mask(p, state)
	# plot(p)
	writeRaster(p,paste(output,state.code,'_',map,'.tif',sep=''),overwrite=TRUE)
	# return(p)
}

clip.prioritization(
	map='ensemble_te_in_bbs_cbc',
	state.code='OH',
	admin='d:/climate_strongholds/analyses_states/states_ras',
	output='d:/climate_strongholds/analyses_states/'
	)


# GEOID	STUSPS	NAME
# 1	AL	Alabama
# 2	AK	Alaska
# 60	AS	American Samoa
# 4	AZ	Arizona
# 5	AR	Arkansas
# 6	CA	California
# 8	CO	Colorado
# 69	MP	Commonwealth of the Northern Mariana Islands
# 9	CT	Connecticut
# 10	DE	Delaware
# 11	DC	District of Columbia
# 12	FL	Florida
# 13	GA	Georgia
# 66	GU	Guam
# 15	HI	Hawaii
# 16	ID	Idaho
# 17	IL	Illinois
# 18	IN	Indiana
# 19	IA	Iowa
# 20	KS	Kansas
# 21	KY	Kentucky
# 22	LA	Louisiana
# 23	ME	Maine
# 24	MD	Maryland
# 25	MA	Massachusetts
# 26	MI	Michigan
# 27	MN	Minnesota
# 28	MS	Mississippi
# 29	MO	Missouri
# 30	MT	Montana
# 31	NE	Nebraska
# 32	NV	Nevada
# 33	NH	New Hampshire
# 34	NJ	New Jersey
# 35	NM	New Mexico
# 36	NY	New York
# 37	NC	North Carolina
# 38	ND	North Dakota
# 39	OH	Ohio
# 40	OK	Oklahoma
# 41	OR	Oregon
# 42	PA	Pennsylvania
# 72	PR	Puerto Rico
# 44	RI	Rhode Island
# 45	SC	South Carolina
# 46	SD	South Dakota
# 47	TN	Tennessee
# 48	TX	Texas
# 78	VI	United States Virgin Islands
# 49	UT	Utah
# 50	VT	Vermont
# 51	VA	Virginia
# 53	WA	Washington
# 54	WV	West Virginia
# 55	WI	Wisconsin
# 56	WY	Wyoming

