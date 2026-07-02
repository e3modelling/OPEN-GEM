$TITLE  OPEN-GEM - An Open General Equilibrium Model
*######################################################################################################################*
* Database
*######################################################################################################################*
* Select the working directory
$setglobal path  ".\";

* ------------- Switch for activating - Model Developments ------------*
* Switch for adding the chemical recycling sector
$setglobal sw_CHM_REC "1";

* ---------------------------------------------------------------------*
* Raw Data
$include '%path%01_Database.gms';
* Mapping
$include '%path%02_OPENGEM_Mapping.gms';
                     
*######################################################################################################################*
* OPEN-GEM Model Calibration
*######################################################################################################################*
$include '%path%03_Calibration.gms';

*######################################################################################################################*
* Model 
*######################################################################################################################*
* Model time period
$setglobal finalyear   "2050"
$setglobal uperiod     "5"

Set
rtime(stime)  Μodel periods incl. calibration and pre-calibration period /2016,2017,2020,2025,2030,2035,2040,2045,2050/
rtime2(stime) Μodel periods after calibration periods                    
an(stime)     Time set used in recursive runs                            
;

ttime(rtime) = rtime.val;
ttime1(rtime)$((rtime.val < %finalyear%) and ((%finalyear% ge 2020))) = ttime(rtime+1);
ttime1(rtime)$((rtime.val = %finalyear%) and ((%finalyear% ge 2020))) = ttime(rtime)+%uperiod%;

* Running Period after the base year
rtime2(rtime)$(rtime.val >  byear.val) = yes;
an(rtime)    $(rtime.val >= byear.val) = yes;

* Initialize parameters and variables
$include '%path%04_Initialization.gms';

* Model Equations
$include '%path%05_Model_Equations.gms';

*######################################################################################################################*
*  SCENARIO ASSUMPTIONS                                                       *
*######################################################################################################################*
* Select the type of the scenario
* 0: BASELINE, 1: SCENARIO
$setglobal scen_type "0"; 
* Give the name of the scenario (valid if scen_type = 1)
$if %scen_type% == "0"  $setglobal scen_name "BASE";
$if %scen_type% == "1"  $setglobal scen_name "CHM_REC";

* Load the Baseline Assumptions
$include '%path%\06_Baseline_Assumptions.gms';
$if %scen_type% == "1"    $include '%path%\06_Scenario_Assumptions_%scen_name%.gms';

*###############################################################################
*  SIMULATION
*###############################################################################
Parameters
inityear   First period within the loop  /2017/
curyearp   Period within the loop         
endyearp   Last period within the loop   
;

Alias(rtime,runtime);

* Initial values for the base year
curyearp  = inityear;
endyearp  = inityear + card(rtime) -2;
an(rtime) = 0;

loop(runtime$((ord(runtime) eq curyearp-inityear+2)
                        and (curyearp le endyearp)),
* Set current year
an(rtime)$(ord(rtime) eq curyearp-inityear+2)= yes;

solve OPEN_GEM using mcp;

* Shift current year
curyearp=curyearp+1;

* Initial values for the next period and fixing lagged values
$include '%path%07_Initial_Values.gms';

an(rtime)=no;
);

an(rtime)$(ord(rtime)     ge 2
           and ord(rtime) le curyearp-1-inityear+2) = yes;

*###############################################################################
*                                 REPORT
*###############################################################################
* 0: Without Report, 1: With Report
$setglobal   sw_report    "1";

$if %sw_report% == "1"  $include '%path%08_Report.gms';

