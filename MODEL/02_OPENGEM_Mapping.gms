*######################################################################################################################*
* OPEN-GEM Sets
* ------------------------------------------------------ Sets --------------------------------------------------------*
* Main Timeframe of the Database
Set stime /2016*2050/;
Singleton Set
byear(stime)    Base year             /2017/
pbyear(stime)   Year before base year /2016/
;

$if %sw_CHM_REC% == "0"  $CALL  gdxxrw i=%path%\SETS_OPENGEM.xlsx  o=%path%\SETS_OPENGEM.gdx   index=index!a1
$if %sw_CHM_REC% == "1"  $CALL  gdxxrw i=%path%\SETS_OPENGEM_REC.xlsx  o=%path%\SETS_OPENGEM_REC.gdx   index=index!a1

Sets
* Regions
cott             OPEN-GEM regional classification
* Sectors
pr               OPEN-GEM sectoral classification
* Production factors
fa
* Agents
se
* Government Categories
gv
* Sectoral Aggregation
map_sec(pr,comm)   Mapping OPEN-GEM with GTAP sectoral classification
* Regional Aggregation
map_reg(cott,reg)  Mapping OPEN-GEM with GTAP regional classification
;

* ------------------------------------------------- Load Sets ---------------------------------------------------------*
$if %sw_CHM_REC% == "0"   $gdxin   %path%\SETS_OPENGEM.gdx
$if %sw_CHM_REC% == "1"   $gdxin   %path%\SETS_OPENGEM_REC.gdx
$load    cott  
$load    pr         
$load    fa
$load    se
$load    gv
$load    map_sec
$load    map_reg
$gdxin

Alias (cott,cutt,er,cr,cs), (pr,br), (se,sr);

* OPEN-GEM Parameters
* ------------------------------------------------- Parameters --------------------------------------------------------*
Parameters
opengem_reg_io_chk      (*,*,*,*)              Check Parameter for IO tables
opengem_reg_demand      (*,*,cott)             Value of Total Demand (in m.%currency% 2017)
opengem_reg_supply      (*,*,cott)             Value of Total Supply (in m.%currency% 2017)
opengem_reg_io          (*,*,cott)             opengem Input-Output Tables (in m.%currency% 2017)

opengem_reg_gdp         (*,cott)               GDP at basic prices               -in m.%currency% 2017 - GTAP data
opengem_reg_gdpm        (*,cott)               GDP at purchases prices           -in m.%currency% 2017 - GTAP data

opengem_reg_expbil      (comm,cott,cutt)       Value of Bilateral Exports        -in m.%currency% 2017 - GTAP data
opengem_reg_dutbil      (comm,cott,cutt)       Value of Bilateral Duties         -in m.%currency% 2017 - GTAP data
opengem_reg_tcbil       (comm,comm,cott,cutt)  Value of Bilatera Transport Sales -in m.%currency% 2017 - GTAP data

opengem_reg_io_d        (comm,comm,cott)       Value of Intermediate Consumption in domestic goods  -in m.%currency% 2017 - GTAP data
opengem_reg_io_i        (comm,comm,cott)       Value of Intermediate Consumption in imported goods  -in m.%currency% 2017 - GTAP data
opengem_reg_hc_d        (comm,cott)            Value of Household Consumption in domestic goods     -in m.%currency% 2017 - GTAP data
opengem_reg_hc_i        (comm,cott)            Value of Household Consumption in imported goods     -in m.%currency% 2017 - GTAP data
opengem_reg_inv_d       (comm,cott)            Value of Investment in domestic goods                -in m.%currency% 2017 - GTAP data
opengem_reg_inv_i       (comm,cott)            Value of Investment in imported goods                -in m.%currency% 2017 - GTAP data
opengem_reg_gc_d        (comm,cott)            Value of Government Consumption of domestic goods    -in m.%currency% 2017 - GTAP data
opengem_reg_gc_i        (comm,cott)            Value of Government Consumption of imported goods    -in m.%currency% 2017 - GTAP data

opengem_reg_capstock    (cott)                 Value of Capital Stock -in m.%currency% 2017 - GTAP data

opengem_reg_production  (comm,cott)            Value of production in m %currency%
opengem_reg_population  (cott)                 Population in m persons
;

*------------------------- Construct the opengem Regional IO table ------------------------------------------------------*
Sets
gtapsup(*)  GTAP supply
gtapdem(*)  GTAP demand
;

gtapsup(comm) = comm(comm);
gtapsup(fsup) = fsup(fsup);

gtapdem(comm) = comm(comm);
gtapdem(fdem) = fdem(fdem);

* Regional Aggregation
opengem_reg_io(gtapsup,gtapdem,cott) = sum(reg$map_reg(cott,reg), gtap_ce_ini_io(gtapsup,gtapdem,reg));
opengem_reg_capstock(cott)           = sum(reg$map_reg(cott,reg), gtap_ce_capstock(reg));
opengem_reg_population(cott)         = sum(reg$map_reg(cott,reg), gtap_ce_population(reg));


opengem_reg_io_d(comm,comm1,cott)    = sum(reg$map_reg(cott,reg), gtap_ce_ini_io_d(comm,comm1,reg));
opengem_reg_io_i(comm,comm1,cott)    = sum(reg$map_reg(cott,reg), gtap_ce_ini_io_i(comm,comm1,reg));
opengem_reg_hc_d(comm,cott)          = sum(reg$map_reg(cott,reg), gtap_ce_ini_hc_d(comm,reg));
opengem_reg_hc_i(comm,cott)          = sum(reg$map_reg(cott,reg), gtap_ce_ini_hc_i(comm,reg));
opengem_reg_inv_d(comm,cott)         = sum(reg$map_reg(cott,reg), gtap_ce_ini_inv_d(comm,reg));
opengem_reg_inv_i(comm,cott)         = sum(reg$map_reg(cott,reg), gtap_ce_ini_inv_i(comm,reg));
opengem_reg_gc_d(comm,cott)          = sum(reg$map_reg(cott,reg), gtap_ce_ini_gc_d(comm,reg));
opengem_reg_gc_i(comm,cott)          = sum(reg$map_reg(cott,reg), gtap_ce_ini_gc_i(comm,reg));

*----------------------------------------------------------------------------------------------------------------------*
*                                        Check that the SAM is balanced                                           *
*                                   Check and abort condition if  Demand<>Supply                                    *
opengem_reg_demand("01-Regional Aggregation",comm,cott)
          = sum(comm1, opengem_reg_io(comm,comm1,cott))
          + opengem_reg_io(comm,"01-HC",cott)
          + opengem_reg_io(comm,"02-GC",cott)
          + opengem_reg_io(comm,"03-INV",cott)
          + opengem_reg_io(comm,"04-EXP",cott)
          + opengem_reg_io(comm,"05-VST-EXP",cott);

opengem_reg_supply("01-Regional Aggregation",comm,cott)
          = sum(comm1, opengem_reg_io(comm1,comm,cott))
          + opengem_reg_io("01-CAP",comm,cott)
          + opengem_reg_io("02-LOWS",comm,cott)
          + opengem_reg_io("02-SHOP",comm,cott)
          + opengem_reg_io("02-TECH",comm,cott)
          + opengem_reg_io("02-CLRK",comm,cott)
          + opengem_reg_io("02-OMGR",comm,cott)
          + opengem_reg_io("03-LAND",comm,cott)
          + opengem_reg_io("04-NATR",comm,cott)
          + opengem_reg_io("05-TXK",comm,cott)
          + opengem_reg_io("06-TXL",comm,cott)
          + opengem_reg_io("07-TXLAND",comm,cott)
          + opengem_reg_io("08-TXNATR",comm,cott)
          + opengem_reg_io("09-TXPt",comm,cott)
          + opengem_reg_io("10-TXPn",comm,cott)
          + opengem_reg_io("11-TXE",comm,cott)
          + opengem_reg_io("12-DUT",comm,cott)
          + opengem_reg_io("13-IMP",comm,cott)
          + opengem_reg_io("14-VST-IMP",comm,cott);

opengem_reg_io_chk("01-Regional Aggregation","Demand = Supply",comm,cott)$opengem_reg_supply("01-Regional Aggregation",comm,cott)
            = opengem_reg_demand("01-Regional Aggregation",comm,cott)
             /opengem_reg_supply("01-Regional Aggregation",comm,cott) -1;

abort$(smax((comm,cott), abs(opengem_reg_io_chk("01-Regional Aggregation","Demand = Supply",comm,cott))) gt 0.001)
                                                "IO Table is not balanced", opengem_reg_io_chk;

*----------------------------------------------------------------------------------------------------------------------*
Parameters
Internal_EXP       (comm,cott)                Internal Bilateral exports
Internal_DUT       (comm,cott)                Internal Bilateral Duties
Internal_TSB       (comm,comm,cott)           Internal Bilateral Transport Activity
SelfTrade          (comm,cott)                Share of Internal Trade to Total Trade
sh_TS              (comm,cott)                Share in international transport activity
sh_TSB             (comm,cott,cutt)           Bilateral share in import transport sales
TS_D               (comm,cott)                Difference in Export Transport Sales due to regional aggregation (domestic part)
TS_I               (comm,cott)                Additional Imports in Transport Services due to regional aggregation
TS_EX              (comm,cott)                Difference in Export Transport Sales due to regional aggregation (imported part)
;

*------------------------------  Accounting of Bilateral Trade in regions due to aggregation --------------------------*
opengem_reg_expbil(comm,cott,cutt)       = sum((reg,reg1)$(map_reg(cott,reg)$map_reg(cutt,reg1)),  gtap_ce_ini_expbil(comm,reg,reg1));
opengem_reg_dutbil(comm,cott,cutt)       = sum((reg,reg1)$(map_reg(cott,reg)$map_reg(cutt,reg1)),  gtap_ce_ini_dutbil(comm,reg1,reg));
opengem_reg_tcbil(comm,comm1,cott,cutt)  = sum((reg,reg1)$(map_reg(cott,reg)$map_reg(cutt,reg1)),  gtap_ce_ini_tcbil(comm,comm1,reg1,reg));

* Calculation of the internal Bilateral Trade of the aggregate regions
Internal_EXP(comm,cott)       = opengem_reg_expbil(comm,cott,cott);
Internal_DUT(comm,cott)       = opengem_reg_dutbil(comm,cott,cott);
Internal_TSB(comm,comm1,cott) = opengem_reg_tcbil(comm,comm1,cott,cott);

SelfTrade(comm,cott)$(sum(cutt, opengem_reg_expbil(comm,cutt,cott)
                              + opengem_reg_dutbil(comm,cott,cutt))
                              + sum((comm1,cutt), opengem_reg_tcbil(comm1,comm,cott,cutt)))
                    =( Internal_EXP(comm,cott)
                     + Internal_DUT(comm,cott)
                     + sum(comm1, Internal_TSB(comm1,comm,cott)))/
                     (sum(cutt, opengem_reg_expbil(comm,cutt,cott)
                              + opengem_reg_dutbil(comm,cott,cutt))
                              + sum((comm1,cutt),opengem_reg_tcbil(comm1,comm,cott,cutt)));

* Change in share of domestic - imported goods due to regional aggregation
opengem_reg_io_d(comm,comm1,cott)   = opengem_reg_io_d(comm,comm1,cott)   + SelfTrade(comm,cott) * opengem_reg_io_i(comm,comm1,cott);
opengem_reg_io_i(comm,comm1,cott)   = opengem_reg_io_i(comm,comm1,cott)   - SelfTrade(comm,cott) * opengem_reg_io_i(comm,comm1,cott);
opengem_reg_hc_d(comm,cott)         = opengem_reg_hc_d(comm,cott)         + SelfTrade(comm,cott) * opengem_reg_hc_i(comm,cott)   ;
opengem_reg_hc_i(comm,cott)         = opengem_reg_hc_i(comm,cott)         - SelfTrade(comm,cott) * opengem_reg_hc_i(comm,cott)   ;
opengem_reg_inv_d(comm,cott)        = opengem_reg_inv_d(comm,cott)        + SelfTrade(comm,cott) * opengem_reg_inv_i(comm,cott)  ;
opengem_reg_inv_i(comm,cott)        = opengem_reg_inv_i(comm,cott)        - SelfTrade(comm,cott) * opengem_reg_inv_i(comm,cott)  ;
opengem_reg_gc_d(comm,cott)         = opengem_reg_gc_d(comm,cott)         + SelfTrade(comm,cott) * opengem_reg_gc_i(comm,cott)   ;
opengem_reg_gc_i(comm,cott)         = opengem_reg_gc_i(comm,cott)         - SelfTrade(comm,cott) * opengem_reg_gc_i(comm,cott)   ;

* Change in duties due to regional aggregation
opengem_reg_io("12-DUT",comm,cott)  = opengem_reg_io("12-DUT",comm,cott)  - Internal_DUT(comm,cott);
opengem_reg_io("09-TXPt",comm,cott) = opengem_reg_io("09-TXPt",comm,cott) + Internal_DUT(comm,cott);

* Change in Exports, Imports due to regional aggregation
opengem_reg_io(comm,"04-EXP",cott) = opengem_reg_io(comm,"04-EXP",cott) - Internal_EXP(comm,cott);
opengem_reg_io("13-IMP",comm,cott) = opengem_reg_io("13-IMP",comm,cott) - Internal_EXP(comm,cott);


* -------------------------------- Accounting of Transportation Costs -------------------------------------------------*
* Hypothesis of the share of Internal Transport Activity which is paid to domestic Transport Services
* (Hypothesis: equal to the share in international transport activity)
sh_TS(comm,cott)$sum(cutt, opengem_reg_io(comm,"05-VST-EXP",cutt))
                = opengem_reg_io(comm,"05-VST-EXP",cott)/
                  sum(cutt, opengem_reg_io(comm,"05-VST-EXP",cutt));

sh_TSB(comm,cott,cutt)$(1-sh_TS(comm,cott)) = sh_TS(comm,cutt)/(1-sh_TS(comm,cott));
sh_TSB(comm,cott,cott) = 0;

* Calculation of the Internal Transport Activity of the aggregate region which is paid to Domestic Transport Services
*  This number should be substracted from Import and Export Transport Sales and added to the
*  intermediate consumption of Transport services for each sector as Consumption of domestic goods)
TS_D(comm,cott) =  sum(comm1, Internal_TSB(comm,comm1,cott))*sh_TS(comm,cott);

* Calculation of the Internal Transport Activity of the aggregate region which is paid to Imported Transport Services
* This number should be substracted from Import Transport Sales and added to the
* intermediate consumption of Transport services for each sector as Consumption of imported goods
* This number should also be added to Imports of Tranport Services from other regions
TS_I(comm,cott) =  sum(comm1, Internal_TSB(comm,comm1,cott))*(1-sh_TS(comm,cott));

* Calculation of the Exports transport sales which is related to Internal Transport Activity of the aggregate regions
* that is paid to Transport Services.
* This number should be substracted from Export Transport Sales and added to Exports
TS_EX(comm,cott) = sum(cutt, sh_TSB(comm,cutt,cott)*TS_I(comm,cutt));

* Change in Transportation Costs due to regional aggregation
opengem_reg_io("14-VST-IMP",comm,cott) = opengem_reg_io("14-VST-IMP",comm,cott)
                                      - sum(comm1, Internal_TSB(comm1,comm,cott));
* Change in Intermediate Consumption
opengem_reg_io(comm,comm1,cott) = opengem_reg_io(comm,comm1,cott) + Internal_TSB(comm,comm1,cott);
* Change in Import Transport Services
opengem_reg_io("13-IMP",comm,cott) = opengem_reg_io("13-IMP",comm,cott) +  TS_I(comm,cott);
* Change in Export Transport Services
opengem_reg_io(comm,"04-EXP",cott) = opengem_reg_io(comm,"04-EXP",cott) +  TS_EX(comm,cott);
* Change in Export Transport Sales
opengem_reg_io(comm,"05-VST-EXP",cott) = opengem_reg_io(comm,"05-VST-EXP",cott)
                                       - TS_D(comm,cott)
                                       - TS_EX(comm,cott);

* Zero diagonal elements in Bilateral Trade Matrix
opengem_reg_expbil(comm,cott,cott)       = 0;
opengem_reg_dutbil(comm,cott,cott)       = 0;
opengem_reg_tcbil(comm,comm1,cott,cott)  = 0;

* Change in Bilateral Exports
opengem_reg_expbil(comm,cott,cutt)  = opengem_reg_expbil(comm,cott,cutt)
                                    + sh_TSB(comm,cutt,cott)*TS_I(comm,cutt);

opengem_reg_io_d(comm,comm1,cott)   = opengem_reg_io_d(comm,comm1,cott)
                                    + Internal_TSB(comm,comm1,cott)*sh_TS(comm,cott);

opengem_reg_io_i(comm,comm1,cott)   = opengem_reg_io_i(comm,comm1,cott)
                                    + Internal_TSB(comm,comm1,cott)*(1-sh_TS(comm,cott));

*----------------------------------------------------------------------------------------------------------------------*
*                                          Check that the GTAP SAM is balanced                                         *
*                                      Check and abort condition if  Demand<>Supply                                    *
opengem_reg_demand("02-Regional Aggregation",comm,cott) = sum(comm1, opengem_reg_io(comm,comm1,cott))
                                                   + opengem_reg_io(comm,"01-HC",cott)  + opengem_reg_io(comm,"02-GC",cott)
                                                   + opengem_reg_io(comm,"03-INV",cott) + opengem_reg_io(comm,"04-EXP",cott)
                                                   + opengem_reg_io(comm,"05-VST-EXP",cott);

opengem_reg_supply("02-Regional Aggregation",comm,cott) = sum(comm1, opengem_reg_io(comm1,comm,cott))
                                                   + opengem_reg_io("01-CAP",comm,cott)
                                                   + opengem_reg_io("02-LOWS",comm,cott)   + opengem_reg_io("02-SHOP",comm,cott)
                                                   + opengem_reg_io("02-TECH",comm,cott)   + opengem_reg_io("02-CLRK",comm,cott)
                                                   + opengem_reg_io("02-OMGR",comm,cott)
                                                   + opengem_reg_io("03-LAND",comm,cott)   + opengem_reg_io("04-NATR",comm,cott)
                                                   + opengem_reg_io("05-TXK",comm,cott)    + opengem_reg_io("06-TXL",comm,cott)
                                                   + opengem_reg_io("07-TXLAND",comm,cott) + opengem_reg_io("08-TXNATR",comm,cott)
                                                   + opengem_reg_io("09-TXPt",comm,cott)   + opengem_reg_io("10-TXPn",comm,cott)
                                                   + opengem_reg_io("11-TXE",comm,cott)    + opengem_reg_io("12-DUT",comm,cott)
                                                   + opengem_reg_io("13-IMP",comm,cott)    + opengem_reg_io("14-VST-IMP",comm,cott);


opengem_reg_io_chk("02-Regional Aggregation","Demand = Supply",comm,cott)$opengem_reg_supply("02-Regional Aggregation",comm,cott)
            = opengem_reg_demand("02-Regional Aggregation",comm,cott)/opengem_reg_supply("02-Regional Aggregation",comm,cott) -1;

abort$(smax((comm,cott), abs(opengem_reg_io_chk("02-Regional Aggregation","Demand = Supply",comm,cott))) gt 0.001)
                                                                       "Regional IO Tables are not balanced", opengem_reg_io_chk;

*                                          Checks on Bilateral Trade                                                   *
opengem_reg_io_chk("02-Regional Aggregation","Bilateral Exports = Exports",comm, cott) =
         sum(cutt, opengem_reg_expbil(comm,cott,cutt)) - opengem_reg_io(comm,"04-EXP",cott);

opengem_reg_io_chk("02-Regional Aggregation","Bilateral Duties = Duties", comm, cott) =
         sum(cutt, opengem_reg_dutbil(comm,cott,cutt)) - opengem_reg_io("12-DUT",comm,cott);

opengem_reg_io_chk("02-Regional Aggregation","Bilateral Trans. Cost = Trans. Cost", comm, cott) =
         sum((comm1,cutt), opengem_reg_tcbil(comm1,comm,cott,cutt)) - opengem_reg_io("14-VST-IMP",comm,cott);

opengem_reg_io_chk("02-Regional Aggregation","IO Split Domestic - Imported", comm, cott) =
         sum(comm1, abs(opengem_reg_io_d(comm,comm1,cott) + opengem_reg_io_i(comm,comm1,cott) - opengem_reg_io(comm,comm1,cott)));

opengem_reg_io_chk("02-Regional Aggregation","HC Split Domestic - Imported", comm, cott) =
         opengem_reg_hc_d(comm,cott) + opengem_reg_hc_i(comm,cott) - opengem_reg_io(comm,"01-HC",cott);

opengem_reg_io_chk("02-Regional Aggregation","GC Split Domestic - Imported", comm, cott) =
         opengem_reg_gc_d(comm,cott) + opengem_reg_gc_i(comm,cott) - opengem_reg_io(comm,"02-GC",cott);

opengem_reg_io_chk("02-Regional Aggregation","INV Split Domestic - Imported", comm, cott)=
         opengem_reg_inv_d(comm,cott) + opengem_reg_inv_i(comm,cott) - opengem_reg_io(comm,"03-INV",cott);


* GDP in Market and Basic Prices
opengem_reg_gdp("02-Regional Aggregation",cott)
         = sum(comm, opengem_reg_io("01-CAP",comm,cott)
         + opengem_reg_io("02-LOWS",comm,cott)
         + opengem_reg_io("02-SHOP",comm,cott)  + opengem_reg_io("02-TECH",comm,cott)
         + opengem_reg_io("02-CLRK",comm,cott)  + opengem_reg_io("02-OMGR",comm,cott)
         + opengem_reg_io("03-LAND",comm,cott)  + opengem_reg_io("04-NATR",comm,cott)
         + opengem_reg_io("05-TXK",comm,cott)   + opengem_reg_io("06-TXL",comm,cott)
         + opengem_reg_io("07-TXLAND",comm,cott)+ opengem_reg_io("08-TXNATR",comm,cott)
         + opengem_reg_io("10-TXPn",comm,cott));

opengem_reg_gdpm("02-Regional Aggregation",cott)
         = sum(comm, opengem_reg_io("01-CAP",comm,cott)
         + opengem_reg_io("02-LOWS",comm,cott)
         + opengem_reg_io("02-SHOP",comm,cott)  + opengem_reg_io("02-TECH",comm,cott)
         + opengem_reg_io("02-CLRK",comm,cott)  + opengem_reg_io("02-OMGR",comm,cott)
         + opengem_reg_io("03-LAND",comm,cott)  + opengem_reg_io("04-NATR",comm,cott)
         + opengem_reg_io("05-TXK",comm,cott)   + opengem_reg_io("06-TXL",comm,cott)
         + opengem_reg_io("07-TXLAND",comm,cott)+ opengem_reg_io("08-TXNATR",comm,cott)
         + opengem_reg_io("10-TXPn",comm,cott)  + opengem_reg_io("09-TXPt",comm,cott)
         + opengem_reg_io("11-TXE",comm,cott)   + opengem_reg_io("12-DUT",comm,cott));

* Production
opengem_reg_production(comm,cott) = sum(comm1, opengem_reg_io(comm1,comm,cott))
                             + opengem_reg_io("01-CAP",comm,cott)
                             + opengem_reg_io("02-LOWS",comm,cott)
                             + opengem_reg_io("02-SHOP",comm,cott)
                             + opengem_reg_io("02-TECH",comm,cott)
                             + opengem_reg_io("02-CLRK",comm,cott)
                             + opengem_reg_io("02-OMGR",comm,cott)
                             + opengem_reg_io("03-LAND",comm,cott)
                             + opengem_reg_io("04-NATR",comm,cott)
                             + opengem_reg_io("05-TXK",comm,cott)
                             + opengem_reg_io("06-TXL",comm,cott)
                             + opengem_reg_io("07-TXLAND",comm,cott)
                             + opengem_reg_io("08-TXNATR",comm,cott)
                             + opengem_reg_io("10-TXPn",comm,cott)
                             + opengem_reg_io("11-TXE",comm,cott)
;

*----------------------------------------------------------------------------------------------------------------------*
* --------------------------------------- Energy and Environment ------------------------------------------------------*
* ---------------------------------------------- PARAMETERS -----------------------------------------------------------*
Parameters
opengem_reg_ene(*,*,cott)                Energy Data (in Mtoe)
opengem_reg_emi(*,*,cott)                Emissions Data (in MtCO2)
opengem_reg_exi(comm,cott,cott)          Aggregated Bilateral trade of energy (in Mtoe)
;

* ---------------------------------------- Mapping with GTAP Database -------------------------------------------------*
opengem_reg_ene(comm,comm1,cott)    = sum(reg$map_reg(cott,reg), gtap_ce_ini_ene(comm,comm1,reg));
opengem_reg_ene(comm,"01-HC",cott)  = sum(reg$map_reg(cott,reg), gtap_ce_ini_ene(comm,"01-HC",reg));
opengem_reg_ene(comm,"02-GC",cott)  = sum(reg$map_reg(cott,reg), gtap_ce_ini_ene(comm,"02-GC",reg));
opengem_reg_ene(comm,"03-INV",cott) = sum(reg$map_reg(cott,reg), gtap_ce_ini_ene(comm,"03-INV",reg));

opengem_reg_emi(comm,comm1,cott)    = sum(reg$map_reg(cott,reg), gtap_ce_ini_emi(comm,comm1,reg));
opengem_reg_emi(comm,"01-HC",cott)  = sum(reg$map_reg(cott,reg), gtap_ce_ini_emi(comm,"01-HC",reg));
opengem_reg_emi(comm,"02-GC",cott)  = sum(reg$map_reg(cott,reg), gtap_ce_ini_emi(comm,"02-GC",reg));
opengem_reg_emi(comm,"03-INV",cott) = sum(reg$map_reg(cott,reg), gtap_ce_ini_emi(comm,"03-INV",reg));

opengem_reg_exi(comm,cott,cutt)    = sum((reg,reg1)$(map_reg(cott,reg)$map_reg(cutt,reg1)),  gtap_ce_EXI(comm,reg,reg1));
opengem_reg_exi(comm,cott,cott)     = 0;

*----------------------------------------------------------------------------------------------------------------------*
* Elasticities 
*---------------------------------------------------------------------------------------------------------*
Parameter
opengem_reg_ESUBM(comm,cott)          CES elasticity of import demand across source
opengem_reg_ESUBD(comm,cott)          CES elasticity between domestic and imported goods
opengem_reg_ELFVAEN(comm,cott)        Elasticity of substitution: value-added and energy
opengem_reg_ESUBVA(comm,cott)         Inter-factor substitution elasticity   
;

opengem_reg_ESUBM(comm,cott)$sum(reg$map_reg(cott,reg), gtap_ce_production(comm,reg))
                               = sum(reg$map_reg(cott,reg), gtap_ce_ESUBM(comm,reg)*gtap_ce_production(comm,reg))
                               / sum(reg$map_reg(cott,reg), gtap_ce_production(comm,reg));                           
opengem_reg_ESUBD(comm,cott)$sum(reg$map_reg(cott,reg), gtap_ce_production(comm,reg))
                               = sum(reg$map_reg(cott,reg), gtap_ce_ESUBD(comm,reg)*gtap_ce_production(comm,reg))
                               / sum(reg$map_reg(cott,reg), gtap_ce_production(comm,reg));                             
opengem_reg_ELFVAEN(comm,cott)$sum(reg$map_reg(cott,reg), gtap_ce_production(comm,reg))
                               = sum(reg$map_reg(cott,reg), gtap_ce_ELFVAEN(comm,reg)*gtap_ce_production(comm,reg))
                               / sum(reg$map_reg(cott,reg), gtap_ce_production(comm,reg));
opengem_reg_ESUBVA(comm,cott)$sum(reg$map_reg(cott,reg), gtap_ce_production(comm,reg))
                               = sum(reg$map_reg(cott,reg), gtap_ce_ESUBVA(comm,reg)*gtap_ce_production(comm,reg))
                               / sum(reg$map_reg(cott,reg), gtap_ce_production(comm,reg));

* ------------------------------------------------- Parameters --------------------------------------------------------*
Parameters
opengem_sec_io_chk      (*,*,*,*)                Check Parameter for IO tables
opengem_sec_io          (*,*,*)                  Input-Output Tables (in m.%currency% 2017)
opengem_sec_demand      (*,pr,cott)              Value of Total Demand - in m.%currency% 2017
opengem_sec_supply      (*,pr,cott)              Value of Total Supply - in m.%currency% 2017

opengem_sec_gdp         (*,cott)                 GDP at basic prices     - in m.%currency% 2017
opengem_sec_gdpm        (*,cott)                 GDP at purchases prices - in m.%currency% 2017

opengem_sec_expbil      (pr,cott,cutt)           Value of Bilateral Exports         - in m.%currency% 2017
opengem_sec_dutbil      (pr,cott,cutt)           Value of Bilateral Duties          - in m.%currency% 2017
opengem_sec_tcbil       (pr,br,cott,cutt)        Value of Bilateral Transport Sales - in m.%currency% 2017

opengem_sec_capstock    (cott)                   Value of Capital Stock - in m.%currency% 2017
opengem_sec_population  (cott)                   Population in m persons
;

*------------------------- Construct the GEME3 Sectoral IO table ------------------------------------------------------*
opengem_sec_expbil(pr,cott,cutt)     = sum(comm$map_sec(pr,comm), opengem_reg_expbil(comm,cott,cutt));
opengem_sec_dutbil(pr,cott,cutt)     = sum(comm$map_sec(pr,comm), opengem_reg_dutbil(comm,cott,cutt));
opengem_sec_tcbil(pr,br,cott,cutt)   = sum((comm,comm1)$(map_sec(pr,comm)$map_sec(br,comm1)), opengem_reg_tcbil(comm,comm1,cott,cutt));

* Sectoral Aggregation
opengem_sec_io(pr,br,cott)     = sum((comm,comm1)$(map_sec(pr,comm)$map_sec(br,comm1)),  opengem_reg_io(comm,comm1,cott));
opengem_sec_io(pr,fdem,cott)   = sum(comm$map_sec(pr,comm), opengem_reg_io(comm,fdem,cott));
opengem_sec_io(fsup,br,cott)   = sum(comm$map_sec(br,comm), opengem_reg_io(fsup,comm,cott));

* Capital Stock
opengem_sec_capstock(cott)     = opengem_reg_capstock(cott);
* Population
opengem_sec_population(cott)   = opengem_reg_population(cott);

* Normalize transport margins
Parameter
adj_trm_imp   Adjustment in transport margins
adj_trm_exp   Adjustment in transport margins
adj_trm(cott) Adjustment in transport margins by country
;


adj_trm_imp = sum((br,cott,cutt), opengem_sec_tcbil("TRA01",br,cott,cutt))
            - sum((br,cott),      opengem_sec_io("14-VST-IMP",br,cott));

adj_trm_exp = sum((br,cott,cutt), opengem_sec_tcbil("TRA01",br,cott,cutt))
            - sum(cott,           opengem_sec_io("TRA01","05-VST-EXP",cott));
 
adj_trm(cott) = adj_trm_exp * opengem_sec_io("TRA01","05-VST-EXP",cott)
                   /sum(cutt, opengem_sec_io("TRA01","05-VST-EXP",cutt));

opengem_sec_io("TRA01","05-VST-EXP",cott) = opengem_sec_io("TRA01","05-VST-EXP",cott)
                                          + adj_trm(cott);  

opengem_sec_io("09-TXPt","TRA01",cott)    = opengem_sec_io("09-TXPt","TRA01",cott)
                                          + adj_trm(cott);
        

*------------------------- Adding Chemical Recycling Sector --------------------------------------------------*
$if %sw_CHM_REC% == "1"    $include '%path%\02a_Chemical_Recycling.gms';      
                   
*----------------------------------------------------------------------------------------------------------------------*
*                                        Check that the GTAP SAM is balanced                                           *
*                                      Check and abort condition if  Demand<>Supply                                    *
opengem_sec_demand("01-Sectoral Aggregation",pr,cott) = sum(br, opengem_sec_io(pr,br,cott))
                                                      + sum(fdem, opengem_sec_io(pr,fdem,cott));

opengem_sec_supply("01-Sectoral Aggregation",pr,cott) = sum(br, opengem_sec_io(br,pr,cott))
                                                      + sum(fsup, opengem_sec_io(fsup,pr,cott));

opengem_sec_io_chk("01-Sectoral Aggregation","Demand = Supply",pr,cott)$opengem_sec_supply("01-Sectoral Aggregation",pr,cott)
                = opengem_sec_demand("01-Sectoral Aggregation",pr,cott)/opengem_sec_supply("01-Sectoral Aggregation",pr,cott) -1;

abort$(smax((pr,cott), abs(opengem_sec_io_chk("01-Sectoral Aggregation","Demand = Supply",pr,cott))) gt 0.001)
                                                                      "OPEN-GEM IO Tables are not balanced", opengem_sec_io_chk;

* GDP in Market and Basic Prices
opengem_sec_gdp("01-Sectoral Aggregation",cott) = sum(pr, opengem_sec_io("01-CAP",pr,cott) + opengem_sec_io("02-LOWS",pr,cott)
                + opengem_sec_io("02-SHOP",pr,cott) + opengem_sec_io("02-TECH",pr,cott)  + opengem_sec_io("02-CLRK",pr,cott)
                + opengem_sec_io("02-OMGR",pr,cott) + opengem_sec_io("03-LAND",pr,cott)  + opengem_sec_io("04-NATR",pr,cott)
                + opengem_sec_io("05-TXK",pr,cott)  + opengem_sec_io("06-TXL",pr,cott)   + opengem_sec_io("07-TXLAND",pr,cott)
                + opengem_sec_io("08-TXNATR",pr,cott) + opengem_sec_io("10-TXPn",pr,cott));

opengem_sec_gdpm("01-Sectoral Aggregation",cott) = sum(pr, opengem_sec_io("01-CAP",pr,cott) + opengem_sec_io("02-LOWS",pr,cott)
                + opengem_sec_io("02-SHOP",pr,cott) + opengem_sec_io("02-TECH",pr,cott)  + opengem_sec_io("02-CLRK",pr,cott)
                + opengem_sec_io("02-OMGR",pr,cott) + opengem_sec_io("03-LAND",pr,cott)  + opengem_sec_io("04-NATR",pr,cott)
                + opengem_sec_io("05-TXK",pr,cott)  + opengem_sec_io("06-TXL",pr,cott)   + opengem_sec_io("07-TXLAND",pr,cott)
                + opengem_sec_io("08-TXNATR",pr,cott) + opengem_sec_io("10-TXPn",pr,cott)+ opengem_sec_io("09-TXPt",pr,cott)
                + opengem_sec_io("11-TXE",pr,cott)  + opengem_sec_io("12-DUT",pr,cott));


* Adjustment to fully align demand and supply
opengem_sec_io("09-TXPt",pr,cott) = opengem_sec_io("09-TXPt",pr,cott) 
                                  + opengem_sec_demand("01-Sectoral Aggregation",pr,cott)
                                  - opengem_sec_supply("01-Sectoral Aggregation",pr,cott);

*----------------------------------------------------------------------------------------------------------------------*
* --------------------------------------- Energy and Environment ------------------------------------------------------*
* ---------------------------------------------- PARAMETERS -----------------------------------------------------------*
Parameters
opengem_sec_ene(pr,*,cott)        Energy Data (in Mtoe)
opengem_sec_emi(pr,*,cott)        Emissions Data (in MtCO2)
opengem_sec_exi(pr,cott,cott)     Aggregated Bilateral trade of energy (in Mtoe)
;

opengem_sec_ene(pr,br,cott)       = sum((comm,comm1)$(map_sec(pr,comm)$map_sec(br,comm1)),  opengem_reg_ene(comm,comm1,cott));
opengem_sec_ene(pr,fdem,cott)     = sum(comm$map_sec(pr,comm), opengem_reg_ene(comm,fdem,cott));

opengem_sec_emi(pr,br,cott)       = sum((comm,comm1)$(map_sec(pr,comm)$map_sec(br,comm1)),  opengem_reg_emi(comm,comm1,cott));
opengem_sec_emi(pr,fdem,cott)     = sum(comm$map_sec(pr,comm), opengem_reg_emi(comm,fdem,cott));

opengem_sec_exi(pr,cott,cutt)     = sum(comm$map_sec(pr,comm), opengem_reg_exi(comm,cott,cutt));
opengem_sec_exi(pr,cott,cott)     = 0;

*----------------------------------------------------------------------------------------------------------------------*
* Elasticities 
*----------------------------------------------------------------------------------------------------------------------*
Parameter
opengem_sec_ESUBM(pr,cott)          CES elasticity of import demand across source
opengem_sec_ESUBD(pr,cott)          CES elasticity between domestic and imported goods
opengem_sec_ELFVAEN(pr,cott)        Elasticity of substitution: value-added and energy
opengem_sec_ESUBVA(pr,cott)         Inter-factor substitution elasticity   
;

opengem_sec_ESUBM(pr,cott)$sum(comm$map_sec(pr,comm), opengem_reg_production(comm,cott))
                               = sum(comm$map_sec(pr,comm), opengem_reg_ESUBM(comm,cott)*opengem_reg_production(comm,cott))
                               / sum(comm$map_sec(pr,comm), opengem_reg_production(comm,cott));                           
opengem_sec_ESUBD(pr,cott)$sum(comm$map_sec(pr,comm), opengem_reg_production(comm,cott))
                               = sum(comm$map_sec(pr,comm), opengem_reg_ESUBD(comm,cott)*opengem_reg_production(comm,cott))
                               / sum(comm$map_sec(pr,comm), opengem_reg_production(comm,cott));                             
opengem_sec_ELFVAEN(pr,cott)$sum(comm$map_sec(pr,comm), opengem_reg_production(comm,cott))
                               = sum(comm$map_sec(pr,comm), opengem_reg_ELFVAEN(comm,cott)*opengem_reg_production(comm,cott))
                               / sum(comm$map_sec(pr,comm), opengem_reg_production(comm,cott));
opengem_sec_ESUBVA(pr,cott)$sum(comm$map_sec(pr,comm), opengem_reg_production(comm,cott))
                               = sum(comm$map_sec(pr,comm), opengem_reg_ESUBVA(comm,cott)*opengem_reg_production(comm,cott))
                               / sum(comm$map_sec(pr,comm), opengem_reg_production(comm,cott));

* Elasticities for Chemical Recycling
$if %sw_CHM_REC% == "1"  opengem_sec_ESUBM("IND36",cott)   = opengem_sec_ESUBM("IND09",cott)  ;
$if %sw_CHM_REC% == "1"  opengem_sec_ESUBD("IND36",cott)   = opengem_sec_ESUBD("IND09",cott)  ; 
$if %sw_CHM_REC% == "1"  opengem_sec_ELFVAEN("IND36",cott) = opengem_sec_ELFVAEN("IND09",cott);
$if %sw_CHM_REC% == "1"  opengem_sec_ESUBVA("IND36",cott)  = opengem_sec_ESUBVA("IND09",cott) ;
                        
