*######################################################################################################################*
*                                           SCENARIO REPORTING                                                         *
*######################################################################################################################*
* Main Reporting Parameters
Parameters
REPORT_MACRO(*,cott,stime)        Macro Results
REPORT_SECTOR(*,pr,cott,stime)    Sectoral Results    
;

*Macroeconomic Aggregates - GDP in b$ 2017
REPORT_MACRO("GDP",cott,an) = sum(br, P_HC.L(br,cott,byear) * A_HC.l(br,cott,an)
                                    + P_GC.l(br,cott,byear) * A_GC.L(br,cott,an)
                                    + P_INVP.l(br,cott,byear)*A_INVP.L(br,cott,an)
                                    + P_PWE.L(br,cott,byear)*A_YVTWR.L(br,cott,an)
                                    + P_PWE.l(br,cott,byear)*SUM(cutt, A_EXPO.l(br,cott,cutt,an)))
                            - sum((br,cutt), (P_PWE.l(br,cutt,byear)+cif_vtwr(br,cott,cutt,an)*P_TR.L(byear))
                                                                      *A_IMPO.L(br,cott,cutt,an));

*Macro Results - Government Consumption - b$ 2017
REPORT_MACRO("GCVTOT",cott,an)   = sum(br, P_GC.L(br,cott,byear)*A_GC.L(br,cott,an));
*Macro Results - Investment             - b$ 2017
REPORT_MACRO("INVVCO",cott,an)   = sum(br, P_INVP.L(br,cott,byear)*A_INVP.L(br,cott,an));
*Macro Results - Household Consumption  - b$ 2017
REPORT_MACRO("RHCDTOTV",cott,an) = sum(br, P_HC.L(br,cott,byear)*A_HC.l(br,cott,an));
*Macro Results - Population -  in million of persons
REPORT_MACRO("POP",cott,an)      = TotPopulation (cott,an);
*Sectoral Results - Production - b$ 2017
REPORT_SECTOR("PROD",pr,cott,an) = P_PD.l(pr,cott,byear) * A_XD.l(pr,cott,an);
*Sectoral Results - Exports - b$ 2017
REPORT_SECTOR("EXPORTS",pr,cott,an)    = P_PWE.l(pr,cott,byear)*SUM(cutt, A_EXPO.l(pr,cott,cutt,an));
*Sectoral Results - Imports - b$ 2017 (incl. transport margins and duties)
REPORT_SECTOR("IMPORTS",pr,cott,an)    = sum(cutt, (P_PWE.l(pr,cutt,byear)+cif_vtwr(pr,cott,cutt,an)*P_TR.L(byear))
                                                                          *A_IMPO.L(pr,cott,cutt,an));
*Sectoral Results - Demand  - b$ 2017
REPORT_SECTOR("DEMAND",pr,cott,an)     = P_Y.l(pr,cott,an)*A_Y.l(pr,cott,an);

* Uploading main reporting parameters
execute_unload    '%path%\OPEN_GEM_REPORT.gdx', REPORT_MACRO, REPORT_SECTOR;

* Extracting Results of the OPEN_GEM_REPORT excel File
* For each scenario there are two sheets: MACRO_%scen_name% and SECTOR_%scen_name%
execute "GDXXRW  i=%path%\OPEN_GEM_REPORT.gdx   o=%path%\OPEN_GEM_REPORT.xlsx    par=REPORT_MACRO     Rng=MACRO_%scen_name%!b2    RDIM=2  CDIM=1  DIM=3";
execute "GDXXRW  i=%path%\OPEN_GEM_REPORT.gdx   o=%path%\OPEN_GEM_REPORT.xlsx    par=REPORT_SECTOR    Rng=SECTOR_%scen_name%!b2   RDIM=3  CDIM=1  DIM=4";
