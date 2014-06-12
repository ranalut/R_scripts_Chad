### risk, opportunity, and no uncertainty for priority species in each season

call zig3.exe -r run_files/settings_opportunity_CBC_TE.dat run_files/TE_in_CBC_25.spp prioritizations/opportunity_TE_in_CBC.txt -1.0 0 0.0 0
call zig3.exe -r run_files/settings_opportunity_BBS_TE.dat run_files/TE_in_BBS_25.spp prioritizations/opportunity_TE_in_BBS.txt -1.0 0 0.0 0

call zig3.exe -r run_files/settings_risk_CBC_TE.dat run_files/TE_in_CBC_25.spp prioritizations/risk_TE_in_CBC.txt 1.0 0 0.0 0
call zig3.exe -r run_files/settings_risk_BBS_TE.dat run_files/TE_in_BBS_25.spp prioritizations/risk_TE_in_BBS.txt 1.0 0 0.0 0

call zig3.exe -r run_files/settings_none_CBC_TE.dat run_files/TE_in_CBC_25.spp prioritizations/none_TE_in_CBC.txt 0 0 0.0 0
call zig3.exe -r run_files/settings_none_BBS_TE.dat run_files/TE_in_BBS_25.spp prioritizations/none_TE_in_BBS.txt 0 0 0.0 0
