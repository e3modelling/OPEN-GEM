*######################################################################################################################*
*                                           SCENARIO ASSUMPTIONS                                                       *
*######################################################################################################################*
*  Load Exogenous Assumptions
Parameters
exo_tgk(pr,cott,stime)           Technical progress - Capital
exo_tgl(pr,cott,stime)           Technical progress - Labour
exo_tge(pr,br,cott,stime)        Technical progress - Energy
exo_tgm(pr,br,cott,stime)        Technical progress - Material
exo_tfp(pr,cott,stime)           Total factor productivity
exo_stp(cott,stime)              Social Time Preference
exo_TotPopulation(cott,stime)    Total Population
exo_investments(cott,stime)      Exogenous Investment 
exo_gctv(cott,stime)             Governement Expenditures
exo_txem(br,cott,stime)          Exogenous Carbon Tax on Firms  
exo_txemh(cott,stime)            Exogenous Carbon Tax on Households
;

$if %sw_CHM_REC% == "0"   EXECUTE  "GDXXRW I=%path%\Exogenous_Assumptions.xlsx  O=%path%\Exogenous_Assumptions.gdx    index=INDEX!a1:f100  rwait = 1000";
$if %sw_CHM_REC% == "1"   EXECUTE  "GDXXRW I=%path%\Exogenous_Assumptions_REC.xlsx  O=%path%\Exogenous_Assumptions_REC.gdx    index=INDEX!a1:f100  rwait = 1000";

$if %sw_CHM_REC% == "0"   execute_load      '%path%\Exogenous_Assumptions.gdx',
$if %sw_CHM_REC% == "1"   execute_load      '%path%\Exogenous_Assumptions_REC.gdx',
* Technical progress - Capital
exo_tgk
* Technical progress - Labour
exo_tgl
* Technical progress - Energy
exo_tge
* Technical progress - Material
exo_tgm
* Total factor productivity
exo_tfp
* Social Time Preference
exo_stp
* Population
exo_TotPopulation
* Exogenous investments
exo_investments
* Governement Expenditures
exo_gctv
* Environmental Taxes
exo_txem
exo_txemh
;

tgk(pr,cott,an)                   = exo_tgk(pr,cott,an) ;
tgl(pr,cott,an)                   = exo_tgl(pr,cott,an) ;
tge(prfuel,pr,cott,an)            = exo_tge(prfuel,pr,cott,an) ;
tgm(pr,br,cott,an)                = exo_tgm(pr,br,cott,an);
tfp(pr,cott,an)                   = exo_tfp(pr,cott,an)   ;
tfpexo(pr,cott,an)                = 1;

* Social Time Preference
stp(cott,an)                      = exo_stp(cott,an);

* Population
TotPopulation(cott,an)            = exo_TotPopulation(cott,an)   ;

* Investments
investments(cott,an)              = exo_investments(cott,an)*
                                      P_WPI.l(an)/p_wpi0(an);

* Governement Expenditures
gctv(cott,an)                     = exo_gctv(cott,an);

* Environmental Taxes
txem(br,cott,an)                  = exo_txem(br,cott,an);
txemh(cott,an)                    = exo_txemh(cott,an) ;

