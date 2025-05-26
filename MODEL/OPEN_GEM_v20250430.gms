$TITLE  OPEN-GEM version April 30, 2025
*######################################################################################################################*
* Database
*######################################################################################################################*
* Select the working directory
$setglobal path  "D:\Projects\224_HORIZON_TRANSIENCE\05_Model";

* Data source: GTAP Circular Economy Data Base - v11
* Set the main PATHs of the GTAP Database GDX Files
$setglobal gtap_path  "%path%\GTAP_Database";
$setglobal GTAPDate   "v20250320"
$setglobal currency   "USD"

* Sets in the GTAP Database
Set
comm        Commodities
reg         Regions
endw        Primary factors
TARTYPE     Tariff type
*Emissions
ghg         Green House Gas emissions
lu_cat      Land Use category
lu_subcat   Land Use subcategory
;

* Load the sets
$GDXIN %gtap_path%\GTAP_v11_circular_GSDFDAT_%GTAPDate%.gdx
$LOAD comm = comm
$LOAD reg  = reg
$LOAD endw = endw
$LOAD TARTYPE = TARTYPE
$GDXIN

$GDXIN %gtap_path%\GTAP_v11_circular_GSDFNCO2_%GTAPDate%.GDX
$LOAD ghg         = EM
$LOAD lu_cat      = LU_CAT
$LOAD lu_subcat   = LU_SUBCAT
$GDXIN

Alias (comm, comm1),(reg,reg1);

* Subsets
Sets
labcat(endw)
/
tech_aspros     Technical and professional workers
clerks          Clerical workers
service_shop    Service shop
off_mgr_pros    Management
ag_othlowsk     Agriculture and other low-skill workers
/

lndcat(endw)
/
Land            Land
/

rescat(endw)
/
NatlRes         Natural resources
/

energy(comm)
/
COA             Coal
OIL             Oil
GAS             Gas
P_C             'Petroleum, coal products'
TnD             Electricity transmission and distribution
NuclearBL       Nuclear power
CoalBL          Coal power baseload
GasBL           Gas power baseload
WindBL          Wind power
HydroBL         Hydro power base load
OilBL           Oil power baseload
OtherBL         Other baseload
GasP            Gas power peakload
HydroP          Hydro power peakload
OilP            Oil power peakload
SolarP          Solar power
GDT             'Gas manufacture, distribution'
/

fuels(comm)
/
COA             Coal
OIL             Oil
GAS             Gas
P_C             'Petroleum, coal products'
GDT             'Gas manufacture, distribution'
/

trans(comm)
/
OTP             Transport nec
WTP             Water transport
ATP             Air transport
/

fsup    /"01-CAP","02-LOWS","02-TECH","02-OMGR","02-SHOP","02-CLRK","03-LAND","04-NATR",
         "05-TXK","06-TXL","07-TXLAND","08-TXNATR","09-TXPt","10-TXPn","11-TXE",
         "12-DUT","13-IMP","14-VST-IMP"/
prodsup /"01-CAP","02-LOWS","02-TECH","02-OMGR","02-SHOP","02-CLRK","03-LAND","04-NATR",
         "05-TXK","06-TXL","07-TXLAND","08-TXNATR","10-TXPn"/
fdem    /"01-HC","02-GC","03-INV","04-EXP","05-VST-EXP"/
;
*######################################################################################################################*
* Parameters in the GTAP Database
Parameter
gtap_ce_VDFB(COMM,COMM,REG)         domestic purchases by firms at basic prices
gtap_ce_VDFP(COMM,COMM,REG)         domestic purchases by firms at producers prices
gtap_ce_VDPP(COMM,REG)              domestic purchases by households at producers prices
gtap_ce_VDPB(COMM,REG)              domestic purchases by households at basic prices
gtap_ce_VDGP(COMM,REG)              domestic purchases by government at producers prices
gtap_ce_VDGB(COMM,REG)              domestic purchases by government at basic prices
gtap_ce_VDIP(COMM,REG)              domestic purchases by investment at producers prices
gtap_ce_VDIB(COMM,REG)              domestic purchases by investment at basic prices
gtap_ce_VMFP(COMM,COMM,REG)         imported purchases by firms at producers prices
gtap_ce_VMFB(COMM,COMM,REG)         imported purchases by firms at basic prices
gtap_ce_VMPP(COMM,REG)              import purchases by households at producers prices
gtap_ce_VMPB(COMM,REG)              import purchases by households at basic prices
gtap_ce_VMGP(COMM,REG)              import purchases by government at producers prices
gtap_ce_VMGB(COMM,REG)              import purchases by government at basic prices
gtap_ce_VMIP(COMM,REG)              import purchases by investment at producers prices
gtap_ce_VMIB(COMM,REG)              import purchases by investment at basic prices
gtap_ce_VFOB(COMM,REG,REG)          non-margin exports at FOB prices
gtap_ce_VXSB(COMM,REG,REG)          non-margin exports at basic prices
gtap_ce_VCIF(COMM,REG,REG)          imports at CIF prices
gtap_ce_VMSB(COMM,REG,REG)          imports at basic prices
gtap_ce_VRRV(COMM,REG,REG)          export tax equivalent of voluntary export restraints
gtap_ce_VST (COMM,REG)              margin exports
gtap_ce_VTWR(COMM,COMM,REG,REG)     margins by margin commodity
gtap_ce_MAKS(COMM,COMM,REG)         MAKE matrix (before output tax subsidy)
gtap_ce_MAKB(COMM,COMM,REG)         MAKE matrix at basic prices
gtap_ce_VDEP(REG)                   capital depreciation
gtap_ce_EVOS(ENDW,COMM,REG)         value of endowment supply in region r net of direct tax
gtap_ce_EVFP(ENDW,COMM,REG)         primary factor purchases at producers prices
gtap_ce_EVFB(ENDW,COMM,REG)         primary factor purchases by firms at basic prices
gtap_ce_SAVE(REG)                   net saving by region
gtap_ce_VKB (REG)                   capital stock
gtap_ce_POP (REG)                   population
gtap_ce_ADRV(COMM,REG,REG)          anti-dumping duty
gtap_ce_FBEP(ENDW,COMM,REG)         gross factor-based tax (if > 0) or subsidy (if < 0)
gtap_ce_FTRV(ENDW,COMM,REG)         gross factor employment tax revenue
gtap_ce_MFRV(COMM,REG,REG)          export tax equivalent of MFA quota premia
gtap_ce_OSEP(COMM,REG)              net ordinary output tax (if > 0) or subsidy (if < 0)
gtap_ce_PTAX(COMM,COMM,REG)         activity tax on commodity c by activity a in r
gtap_ce_PURV(COMM,REG,REG)          protection - price undertaking export subsidy equivalent
gtap_ce_TFRV(COMM,REG,REG)          ordinary import duty
gtap_ce_XTRV(COMM,REG,REG)          ordinary export tax
gtap_ce_VMTS(TARTYPE,COMM,REG,REG)  Import tariff revenue by type of tariffs paid
;

$GDXIN "%gtap_path%\GTAP_v11_circular_GSDFDAT_%GTAPDate%.gdx"
$LOAD gtap_ce_VDFB = VDFB
$LOAD gtap_ce_VDFP = VDFP
$LOAD gtap_ce_VDPP = VDPP
$LOAD gtap_ce_VDPB = VDPB
$LOAD gtap_ce_VDGP = VDGP
$LOAD gtap_ce_VDGB = VDGB
$LOAD gtap_ce_VDIP = VDIP
$LOAD gtap_ce_VDIB = VDIB
$LOAD gtap_ce_VMFP = VMFP
$LOAD gtap_ce_VMFB = VMFB
$LOAD gtap_ce_VMPP = VMPP
$LOAD gtap_ce_VMPB = VMPB
$LOAD gtap_ce_VMGP = VMGP
$LOAD gtap_ce_VMGB = VMGB
$LOAD gtap_ce_VMIP = VMIP
$LOAD gtap_ce_VMIB = VMIB
$LOAD gtap_ce_VFOB = VFOB
$LOAD gtap_ce_VXSB = VXSB
$LOAD gtap_ce_VCIF = VCIF
$LOAD gtap_ce_VMSB = VMSB
$LOAD gtap_ce_VST  = VST 
$LOAD gtap_ce_VTWR = VTWR
$LOAD gtap_ce_MAKS = MAKS
$LOAD gtap_ce_MAKB = MAKB
$LOAD gtap_ce_VDEP = VDEP
$LOAD gtap_ce_EVOS = EVOS
$LOAD gtap_ce_EVFP = EVFP
$LOAD gtap_ce_EVFB = EVFB
$LOAD gtap_ce_SAVE = SAVE
$LOAD gtap_ce_VKB  = VKB 
$LOAD gtap_ce_POP  = POP 
$LOAD gtap_ce_FBEP = FBEP
$LOAD gtap_ce_FTRV = FTRV
$LOAD gtap_ce_PTAX = PTAX
$LOAD gtap_ce_VMTS = VMTS
$GDXIN

*######################################################################################################################*
* Input Output tables from the GTAP Circular Economy Data Base - v11
*---------------------------------------------------------------------------------------------------------*
Parameters
gtap_ce_ini_io(*,*,*)               gtap_ce Input-Output Table in m %currency%
gtap_ce_gdp(*,*)                    gtap_ce Macroeconomics
gtap_ce_ini_demand(*,comm,reg)      Total Demand in m %currency%
gtap_ce_ini_supply(*,comm,reg)      Total Supply in m %currency%
gtap_ce_ini_io_chk(*,*,*,*)         Checks in IO Table

gtap_ce_ini_io_d(comm,comm,reg)     gtap_ce Intermediate Demand for Domestic Commodities at producers prices in m %currency%
gtap_ce_ini_io_i(comm,comm,reg)     gtap_ce Intermediate Demand for Imported Commodities at producers prices in m %currency%
gtap_ce_ini_hc_d(comm,reg)          gtap_ce Household Demand for Domestic Commodities at producers prices in m %currency%
gtap_ce_ini_hc_i(comm,reg)          gtap_ce Household Demand for Imported Commodities at producers prices in m %currency%
gtap_ce_ini_inv_d(comm,reg)         gtap_ce Investment Demand for Domestic Commodities at producers prices in m %currency%
gtap_ce_ini_inv_i(comm,reg)         gtap_ce Investment Demand for Imported Commodities at producers prices in m %currency%
gtap_ce_ini_gc_d(comm,reg)          gtap_ce Government Demand for Domestic Commodities at producers prices in m %currency%
gtap_ce_ini_gc_i(comm,reg)          gtap_ce Government Demand for Imported Commodities at producers prices in m %currency%

gtap_ce_capstock(reg)               gtap_ce capital stock in m %currency%

gtap_ce_ini_expbil(comm,reg,reg)      Value of Bilateral Exports        -in m.%currency% 2017 - GTAP data
gtap_ce_ini_dutbil(comm,reg,reg)      Value of Bilateral Duties         -in m.%currency% 2017 - GTAP data
gtap_ce_ini_tcbil(comm,comm,reg,reg)  Value of Bilatera Transport Sales -in m.%currency% 2017 - GTAP data

gtap_ce_production(comm,reg)        gtap_ce production in m %currency%
gtap_ce_population(reg)             gtap_ce population in m persons
;

gtap_ce_ini_io_d(comm,comm1,reg)      = gtap_ce_VDFP(comm,comm1,reg);
gtap_ce_ini_io_i(comm,comm1,reg)      = gtap_ce_VMFP(comm,comm1,reg);
gtap_ce_ini_hc_d(comm,reg)            = gtap_ce_VDPP(comm,reg);
gtap_ce_ini_hc_i(comm,reg)            = gtap_ce_VMPP(comm,reg);
gtap_ce_ini_inv_d(comm,reg)           = gtap_ce_VDIP(comm,reg);
gtap_ce_ini_inv_i(comm,reg)           = gtap_ce_VMIP(comm,reg);
gtap_ce_ini_gc_d(comm,reg)            = gtap_ce_VDGP(comm,reg);
gtap_ce_ini_gc_i(comm,reg)            = gtap_ce_VMGP(comm,reg);

gtap_ce_ini_io(comm,comm1,reg)        = gtap_ce_ini_io_d(comm,comm1,reg)
                                      + gtap_ce_ini_io_i(comm,comm1,reg);
gtap_ce_ini_io(comm,"01-HC",reg)      = gtap_ce_ini_hc_d(comm,reg)
                                      + gtap_ce_ini_hc_i(comm,reg);
gtap_ce_ini_io(comm,"02-GC",reg)      = gtap_ce_ini_gc_d(comm,reg)
                                      + gtap_ce_ini_gc_i(comm,reg);
gtap_ce_ini_io(comm,"03-INV",reg)     = gtap_ce_ini_inv_d(comm,reg)
                                      + gtap_ce_ini_inv_i(comm,reg);
gtap_ce_ini_io(comm,"04-EXP",reg)     = sum(reg1, gtap_ce_VFOB(comm,reg,reg1));
gtap_ce_ini_io(comm,"05-VST-EXP",reg) = gtap_ce_VST(comm,reg);

* Values at market (basic) prices
gtap_ce_ini_io("01-CAP",comm,reg)    = gtap_ce_EVFB("capital",comm,reg);
gtap_ce_ini_io("02-LOWS",comm,reg)   = gtap_ce_EVFB("ag_othlowsk",comm,reg);
gtap_ce_ini_io("02-SHOP",comm,reg)   = gtap_ce_EVFB("service_shop",comm,reg);
gtap_ce_ini_io("02-TECH",comm,reg)   = gtap_ce_EVFB("tech_aspros",comm,reg);
gtap_ce_ini_io("02-CLRK",comm,reg)   = gtap_ce_EVFB("clerks",comm,reg);
gtap_ce_ini_io("02-OMGR",comm,reg)   = gtap_ce_EVFB("off_mgr_pros",comm,reg);
gtap_ce_ini_io("03-LAND",comm,reg)   = gtap_ce_EVFB("Land",comm,reg);
gtap_ce_ini_io("04-NATR",comm,reg)   = gtap_ce_EVFB("NatlRes",comm,reg);

* Taxes less subsidies on primary factors of production
gtap_ce_ini_io("05-TXK",comm,reg)     = gtap_ce_EVFP("capital",comm,REG)
                                      - gtap_ce_EVFB("capital",comm,REG);
gtap_ce_ini_io("06-TXL",comm,reg)     = sum(labcat,  gtap_ce_EVFP(labcat,comm,REG)
                                                   - gtap_ce_EVFB(labcat,comm,REG));
gtap_ce_ini_io("07-TXLAND",comm,reg)  = sum(lndcat,  gtap_ce_EVFP(lndcat,comm,REG)
                                                   - gtap_ce_EVFB(lndcat,comm,REG));
gtap_ce_ini_io("08-TXNATR",comm,reg)  = sum(rescat,  gtap_ce_EVFP(rescat,comm,REG)
                                                   - gtap_ce_EVFB(rescat,comm,REG));

* Taxes on products
gtap_ce_ini_io("09-TXPt",comm,reg) = sum(comm1, gtap_ce_VDFP(comm,comm1,reg) - gtap_ce_VDFB(comm,comm1,reg))
                                   + sum(comm1, gtap_ce_VMFP(comm,comm1,reg) - gtap_ce_VMFB(comm,comm1,reg))
                                   + gtap_ce_VDPP(comm,reg) - gtap_ce_VDPB(comm,reg)
                                   + gtap_ce_VMPP(comm,reg) - gtap_ce_VMPB(comm,reg)
                                   + gtap_ce_VDGP(comm,reg) - gtap_ce_VDGB(comm,reg)
                                   + gtap_ce_VMGP(comm,reg) - gtap_ce_VMGB(comm,reg)
                                   + gtap_ce_VDIP(comm,reg) - gtap_ce_VDIB(comm,reg)
                                   + gtap_ce_VMIP(comm,reg) - gtap_ce_VMIB(comm,reg)
;

* Taxes on production
gtap_ce_ini_io("10-TXPn",comm,reg)    =  sum(comm1, gtap_ce_PTAX(COMM1,comm,REG)) ;

* Taxes less subsidies on exports
gtap_ce_ini_io("11-TXE",comm,reg)     =  sum(reg1, gtap_ce_VFOB(COMM,REG,REG1))
                                      -  sum(reg1, gtap_ce_VXSB(COMM,REG,REG1));

* Imports, Duties and Transport Margins
gtap_ce_ini_io("12-DUT",comm,reg)      =  sum((TARTYPE,reg1), gtap_ce_VMTS(TARTYPE,COMM,REG1,REG));
gtap_ce_ini_io("13-IMP",comm,reg)      =  sum(reg1, gtap_ce_VFOB(COMM,REG1,REG));
gtap_ce_ini_io("14-VST-IMP",comm1,reg) =  sum((comm,reg1), gtap_ce_VTWR(comm,comm1,reg1,reg));

* Bilateral Accounts
gtap_ce_ini_expbil(comm,reg,reg1)       = gtap_ce_VFOB(comm,reg,reg1);
gtap_ce_ini_dutbil(comm,reg,reg1)       = sum(TARTYPE, gtap_ce_VMTS(TARTYPE,comm,reg,reg1));
gtap_ce_ini_tcbil(comm,comm1,reg,reg1)  = gtap_ce_VTWR(comm,comm1,reg,reg1);

*----------------------------------------------------------------------------------------------------------------------*
*                                        Check that the gtap_ce SAM is balanced                                           *
*                                      Check and abort condition if  Demand<>Supply                                    *
gtap_ce_ini_demand("01-Sectoral Aggregation",comm,reg)
    = sum(comm1, gtap_ce_ini_io(comm,comm1,reg))
               + gtap_ce_ini_io(comm,"01-HC",reg)
               + gtap_ce_ini_io(comm,"02-GC",reg)
               + gtap_ce_ini_io(comm,"03-INV",reg)
               + gtap_ce_ini_io(comm,"04-EXP",reg)
               + gtap_ce_ini_io(comm,"05-VST-EXP",reg);

gtap_ce_ini_supply("01-Sectoral Aggregation",comm,reg)
    = sum(comm1, gtap_ce_ini_io(comm1,comm,reg))
               + gtap_ce_ini_io("01-CAP",comm,reg)
               + gtap_ce_ini_io("02-LOWS",comm,reg)
               + gtap_ce_ini_io("02-SHOP",comm,reg)
               + gtap_ce_ini_io("02-TECH",comm,reg)
               + gtap_ce_ini_io("02-CLRK",comm,reg)
               + gtap_ce_ini_io("02-OMGR",comm,reg)
               + gtap_ce_ini_io("03-LAND",comm,reg)
               + gtap_ce_ini_io("04-NATR",comm,reg)
               + gtap_ce_ini_io("05-TXK",comm,reg)
               + gtap_ce_ini_io("06-TXL",comm,reg)
               + gtap_ce_ini_io("07-TXLAND",comm,reg)
               + gtap_ce_ini_io("08-TXNATR",comm,reg)
               + gtap_ce_ini_io("09-TXPt",comm,reg)
               + gtap_ce_ini_io("10-TXPn",comm,reg)
               + gtap_ce_ini_io("11-TXE",comm,reg)
               + gtap_ce_ini_io("12-DUT",comm,reg)
               + gtap_ce_ini_io("13-IMP",comm,reg)
               + gtap_ce_ini_io("14-VST-IMP",comm,reg);

gtap_ce_ini_io_chk("01-Sectoral Aggregation","Demand = Supply",comm,reg)$gtap_ce_ini_supply("01-Sectoral Aggregation",comm,reg)
            = gtap_ce_ini_demand("01-Sectoral Aggregation",comm,reg) - gtap_ce_ini_supply("01-Sectoral Aggregation",comm,reg) ;


gtap_ce_ini_io_chk("01-Sectoral Aggregation","Demand = Supply%",comm,reg)$gtap_ce_ini_supply("01-Sectoral Aggregation",comm,reg)
            = gtap_ce_ini_demand("01-Sectoral Aggregation",comm,reg)/gtap_ce_ini_supply("01-Sectoral Aggregation",comm,reg) -1;


abort$(smax((comm,reg), abs(gtap_ce_ini_io_chk("01-Sectoral Aggregation","Demand = Supply%",comm,reg))) gt 0.1)
                                                                                  "gtap_ce IO not balanced", gtap_ce_ini_io_chk;
;

* Capital Stock
gtap_ce_capstock(reg)    = gtap_ce_VKB(reg);

* Population
gtap_ce_population(reg)  = gtap_ce_POP(reg);


* GDP in gtap_ce regional aggregation
gtap_ce_gdp("GDP",reg)    = sum(comm, gtap_ce_ini_io(comm,"01-HC",reg)
                                    + gtap_ce_ini_io(comm,"02-GC",reg)
                                    + gtap_ce_ini_io(comm,"03-INV",reg)
                                    + gtap_ce_ini_io(comm,"04-EXP",reg)
                                    + gtap_ce_ini_io(comm,"05-VST-EXP",reg)
                                    - gtap_ce_ini_io("14-VST-IMP",comm,reg)
                                    - gtap_ce_ini_io("13-IMP",comm,reg));

gtap_ce_gdp("HC",reg)     = sum(comm, gtap_ce_ini_io(comm,"01-HC",reg));
gtap_ce_gdp("GC",reg)     = sum(comm, gtap_ce_ini_io(comm,"02-GC",reg));
gtap_ce_gdp("INV",reg)    = sum(comm, gtap_ce_ini_io(comm,"03-INV",reg));

* Production
gtap_ce_production(comm,reg) = sum(comm1, gtap_ce_ini_io(comm1,comm,reg))
                             + gtap_ce_ini_io("01-CAP",comm,reg)
                             + gtap_ce_ini_io("02-LOWS",comm,reg)
                             + gtap_ce_ini_io("02-SHOP",comm,reg)
                             + gtap_ce_ini_io("02-TECH",comm,reg)
                             + gtap_ce_ini_io("02-CLRK",comm,reg)
                             + gtap_ce_ini_io("02-OMGR",comm,reg)
                             + gtap_ce_ini_io("03-LAND",comm,reg)
                             + gtap_ce_ini_io("04-NATR",comm,reg)
                             + gtap_ce_ini_io("05-TXK",comm,reg)
                             + gtap_ce_ini_io("06-TXL",comm,reg)
                             + gtap_ce_ini_io("07-TXLAND",comm,reg)
                             + gtap_ce_ini_io("08-TXNATR",comm,reg)
                             + gtap_ce_ini_io("10-TXPn",comm,reg)
                             + gtap_ce_ini_io("11-TXE",comm,reg)
;

*######################################################################################################################*
* Energy - GTAP database v.11
*---------------------------------------------------------------------------------------------------------*
Parameter
gtap_ce_EDF(COMM,COMM,REG)   usage of domestic product by firms Mtoe
gtap_ce_EDG(COMM,REG)        government consumption of domestic product Mtoe
gtap_ce_EDP(COMM,REG)        private consumption of domestic product Mtoe
gtap_ce_EDI(COMM,REG)        investment consumption of domestic product Mtoe
gtap_ce_EMF(COMM,COMM,REG)   usage of imports by firms Mtoe
gtap_ce_EMG(COMM,REG)        government consumption of imports Mtoe
gtap_ce_EMP(COMM,REG)        private consumption of imports Mtoe
gtap_ce_EMI(COMM,REG)        investment consumption of imports Mtoe
gtap_ce_EXI(COMM,REG,REG)    volume of trade Mtoe
;

$GDXIN "%gtap_path%\GTAP_v11_circular_GSDFVOLE_%GTAPDate%.gdx"
$LOAD gtap_ce_EDF = EDF
$LOAD gtap_ce_EDG = EDG
$LOAD gtap_ce_EDP = EDP
$LOAD gtap_ce_EDI = EDI
$LOAD gtap_ce_EMF = EMF
$LOAD gtap_ce_EMG = EMG
$LOAD gtap_ce_EMP = EMP
$LOAD gtap_ce_EMI = EMI
$LOAD gtap_ce_EXI = EXI
$GDXIN

Parameters
gtap_ce_ini_ene(*,*,*)              GTAP Energy in Mtoe
;

gtap_ce_ini_ene(comm,comm1,reg)    = gtap_ce_EDF(comm,comm1,reg)
                                   + gtap_ce_EMF(comm,comm1,reg);

gtap_ce_ini_ene(comm,"01-HC",reg)  = gtap_ce_EDP(comm,reg)
                                   + gtap_ce_EMP(comm,reg);

gtap_ce_ini_ene(comm,"02-GC",reg)  = gtap_ce_EDG(comm,reg)
                                   + gtap_ce_EMG(comm,reg);

gtap_ce_ini_ene(comm,"03-INV",reg) = gtap_ce_EDI(comm,reg)
                                   + gtap_ce_EMI(comm,reg);

*######################################################################################################################*
* CO2 Emissions - GTAP database v.11
*---------------------------------------------------------------------------------------------------------*
Parameter
gtap_ce_MDF(COMM,COMM,REG)  Emissions from firms Usage of Domestic Product MtCO2
gtap_ce_MMF(COMM,COMM,REG)  Emissions from firms Usage of Imported Product MtCO2
gtap_ce_MDP(COMM,REG)       Emissions from private Consumption of Domestic Product MtCO2
gtap_ce_MMP(COMM,REG)       Emissions from private Consumption of Imported Product MtCO2
gtap_ce_MDG(COMM,REG)       Emissions from government Consumption of Domestic Product MtCO2
gtap_ce_MMG(COMM,REG)       Emissions from povernment Consumption of Imported Product MtCO2
gtap_ce_MDI(COMM,REG)       Emissions from investment Consumption of Domestic Product MtCO2
gtap_ce_MMI(COMM,REG)       Emissions from investment Consumption of Imported Product MtCO2
;

$GDXIN "%gtap_path%\GTAP_v11_circular_GSDFEMISS_%GTAPDate%.gdx"
$LOAD gtap_ce_MDF = MDF
$LOAD gtap_ce_MMF = MMF
$LOAD gtap_ce_MDP = MDP
$LOAD gtap_ce_MMP = MMP
$LOAD gtap_ce_MDG = MDG
$LOAD gtap_ce_MMG = MMG
$LOAD gtap_ce_MDI = MDI
$LOAD gtap_ce_MMI = MMI
$GDXIN

Parameters
gtap_ce_ini_emi(*,*,*)                GTAP CO2 Emissions in MtCO2
;

gtap_ce_ini_emi(comm,comm1,reg)    =  gtap_ce_MDF(comm,comm1,reg)
                                   +  gtap_ce_MMF(comm,comm1,reg);

gtap_ce_ini_emi(comm,"01-HC",reg)  =  gtap_ce_MDP(comm,reg)
                                   +  gtap_ce_MMP(comm,reg);

gtap_ce_ini_emi(comm,"02-GC",reg)  =  gtap_ce_MDG(comm,reg)
                                   +  gtap_ce_MMG(comm,reg);

gtap_ce_ini_emi(comm,"03-INV",reg) =  gtap_ce_MDI(comm,reg)
                                   +  gtap_ce_MMI(comm,reg);


*######################################################################################################################*
* Elasticities - GTAP database v.11
*---------------------------------------------------------------------------------------------------------*
Parameter
gtap_ce_ESUBM(COMM,REG)          CES elasticity of import demand across source
gtap_ce_ESUBD(COMM,REG)          CES elasticity between domestic and imported goods
gtap_ce_ELFVAEN(COMM,REG)        Elasticity of substitution: value-added and energy
gtap_ce_ESUBVA(COMM,REG)         Inter-factor substitution elasticity   
;

$GDXIN "%gtap_path%\GTAP_v11_circular_GSDFPAR_%GTAPDate%.gdx"
$LOAD gtap_ce_ESUBM   = ESUBM
$LOAD gtap_ce_ESUBD   = ESUBD
$LOAD gtap_ce_ELFVAEN = ELFVAEN
$LOAD gtap_ce_ESUBVA  = ESUBVA
$GDXIN


*######################################################################################################################*
* OPEN-GEM Sets
* ------------------------------------------------------ Sets --------------------------------------------------------*
* Main Timeframe of the Database
Set stime /2016*2050/;
Singleton Set
byear(stime)    Base year             /2017/
pbyear(stime)   Year before base year /2016/
;

$CALL  gdxxrw i=%path%\SETS_OPENGEM.xlsx  o=%path%\SETS_OPENGEM.gdx   index=index!a1

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
$gdxin   %path%\SETS_OPENGEM.gdx
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
*---------------------------------------------------------------------------------------------------------*
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

*######################################################################################################################*
* OPEN-GEM Model Calibration
*######################################################################################################################*
Sets
pren(pr)   Energy Products /ENE01*ENE05/
prfuel(pr) Fossil Fuels    /ENE01,ENE03,ENE04/
prma(pr)   Materials       /AGR01,ENE02,IND01*IND35,TRA01,SRV01*SRV02/
;

Singleton Sets
pr_tra(pr) /TRA01   Transport/
pr_pow(pr) /ENE05   Power/
;

Parameters
* For the Calibration
CAL_indc(pr,br,cott)                   Value of Intermediate Consumption                    -in b.%currency% 2017
CAL_hc(pr,cott)                        Value of Household Consumption                       -in b.%currency% 2017
CAL_gc(pr,cott)                        Value of Government Consumption                      -in b.%currency% 2017 
CAL_inv_v(pr,cott)                     Investment by product                                -in b.%currency% 2017
CAL_exprts(pr,cott)                    Value of Exports                                     -in b.%currency% 2017
CAL_vstexp(pr,cott)                    Value of Export Transport Sales                      -in b.%currency% 2017
CAL_cap(pr,cott)                       Value of Operating surplus                           -in b.%currency% 2017
CAL_lab(pr,cott)                       Value of labour                                      -in b.%currency% 2017
CAL_tax_cap(pr,cott)                   Taxes of Operating surplus                           -in b.%currency% 2017
CAL_tax_lab(pr,cott)                   Taxes of labour                                      -in b.%currency% 2017
CAL_tax_it(pr,cott)                    Value of Indirect Taxes                              -in b.%currency% 2017
CAL_tax_vat(pr,cott)                   Value of VAT Taxes                                   -in b.%currency% 2017
CAL_sub(pr,cott)                       Value of Subsidies on primary production factors     -in b.%currency% 2017
CAL_dut(pr,cott)                       Value of Duties                                      -in b.%currency% 2017
CAL_imprts(pr,cott)                    Value of Imports (FOB)                               -in b.%currency% 2017
CAL_vstimp(pr,cott)                    Value of Import Transport Sales                      -in b.%currency% 2017
CAL_expbil(pr,cott,cott)               Value of Bilateral Exports                           -in b.%currency% 2017
CAL_dutbil(pr,cott,cott)               Value of Bilateral Duties                            -in b.%currency% 2017
CAL_tcbil(pr,br,cott,cott)             Value of Bilateral Transport Sales                   -in b.%currency% 2017
CAL_Capital_Stock(pr,cott)             Value of Capital Stock                               -in b.%currency% 2017 
CAL_etf(pr,br,cott)                    Aggregated Total use of energy by firms              -in Mtoe
CAL_etp(pr,cott)                       Aggregated Private consumption of energy             -in Mtoe
CAL_mtf(pr,br,cott)                    Total CO2 emissions by firms                         -in Mt CO2
CAL_mtp(pr,cott)                       Total CO2 emissions by Government consumption        -in Mt CO2
CAL_exi(pr,cott,cott)                  Aggregated Bilateral trade of energy                 -in Mtoe
CAL_rltlr(cott)                        Real Interest rate
CAL_PD(pr,cott)                        Production prices
CAL_frisch(cott)                       Frisch parameter used in households calibration
CAL_eehc(pr,cott)                      Income elasticity consumption category
CAL_pop_tot(cott)                      Total population in number million of persons
CAL_prod(pr,cott)                      Production                                           -in b.%currency% 2017 

* Checks for the Calibration
check_TRN(*)                           Check of transport margins approach
check_XXD(pr,cott)                     Check for negative values in domestic production
check_theta(*,br,cott)                 Check production nesting scheme
check_HCDTOT(cott)                     Check Household Consumption 
Check_Income(pr,cott)                  Check Income 
Check_CALIB_REG(*,cott)                Calibration Check
Check_CALIB_SEC(*,pr,cott)             Calibration Check 

gdpv                (cott,stime)                     GDP in volume -in b.%currency% 2017
gdpu                (cott,stime)                     GDP in value  -in b.%currency% 2017

* Time
ttime               (stime)                          Period Index
ttime1              (stime)                          Time+Period Index
* Trade
cif_vtwr            (pr,cott,cott,stime)             Demand share for transport margins
txduto              (pr,cott,cott,stime)             Import duty rate (bilateral)
betashare           (pr,cott,cott,stime)             Share coefficient in Armington for substitution among regions
deltashare          (pr,cott,stime)                  Share coefficient in Armington for substitution between domestic - imported
ac                  (pr,cott,stime)                  Scale coefficient in Armington for substitution between domestic - imported
vtag                (stime)                          Output international transport pool by mode
theta_vst           (cott,stime)                     Cost shares international transport pool 
* Energy and Environment
emf                 (pr,stime)                       Emission factor tn of CO2 eq. per toe
aer                 (pr,br,cott,stime)               The ratio of energy combusted to total energy consumed (firms)
bec                 (pr,br,cott,stime)               Emission factor in firms
eaf                 (pr,br,cott,stime)               Emission Adjustement Factor
bech                (pr,cott,stime)                  Emission factor in households
eafh                (pr,cott,stime)                  Emission Adjustement Factor in households
* Private Consumption
stp                 (cott,stime)                     Social time preference
str                 (cott,stime)                     Social time preference relative to rltlr (cal)
bhcfv               (pr,cott,stime)                  LES (lower level) consumption category share parameter
chcfv               (pr,cott,stime)                  LES (lower level) obliged consumption (in volume)
hcbse               (pr,cott,stime)                  Share of in total household consumption (Calibration)
eehca               (pr,cott,stime)                  Income elasticity consumption category (Calibration)
* Public Consumption
gctv                (cott,stime)                     Public consumption in b.%currency%
tgcv                (pr,cott,stime)                  Share of branch in delivery to public consumption
* Capital and investment
decl                (pr,cott,stime)                  Depreciation rate (sectors)
tcinv               (se,cott,stime)                  Investment Financing
tinvpv              (pr,cott,stime)                  Share of branch in delivery to investment
* Population
TotPopulation       (cott,stime)                     Population in million of persons

* Taxes
txproduction        (pr,cott,stime)                  Taxes less subsidies on production
txproducts          (pr,cott,stime)                  Taxes less subsidies on products
* Elasticities
sn1                (pr,cott,stime)                   Elasticity of substitution between KLE and MA
sn2                (pr,cott,stime)                   Elasticity of substitution between KL and ENG
sn3                (pr,cott,stime)                   Elasticity of substitution between intermediate goods
sn5                (pr,cott,stime)                   Elasticity of substitution between energy products and electricity
sn6                (pr,cott,stime)                   Elasticity of substitution between energy products
sn7                (pr,cott,stime)                   Elasticity of substitution between Capital and Labour
sigmax             (pr,cott,stime)                   Substitution elasticity in armington between domestic and imports
sigmai             (pr,cott,stime)                   Substitution elasticity in armington among countries
* technical progress
tgk                (pr,cott,stime)                   Technical progress on capital (cumulated rate)
tgl                (pr,cott,stime)                   Technical progress on labour by skill type
tge                (pr,br,cott,stime)                Technical progress on energy (cumulated rate)
tgm                (pr,br,cott,stime)                Technical progress on materials (cumulated rate)
tfpexo             (pr,cott,stime)                   Exogenous total factor productivity
tfp                (pr,cott,stime)                   Total factor productivity
* Value share in production function
theta_dkle         (pr,cott,stime)                   Value share of KLE bundle in production
theta_dma          (pr,cott,stime)                   Value share of Materials  in production
theta_dkl          (pr,cott,stime)                   Value share of KL in KLE bundle
theta_deng         (pr,cott,stime)                   Value share of ENG in KLE bundle
theta_dmpr         (pr,br,cott,stime)                Value share of intermediate inputs in MA bundle
theta_dkav         (pr,cott,stime)                   Value share of Capital in KL bundle
theta_dlav         (pr,cott,stime)                   Value share of Labour in KL bundle
theta_dele         (pr,cott,stime)                   Value share of ELE in ENG bundle
theta_de           (pr,cott,stime)                   Value share of EN  in ENG bundle
theta_depr         (pr,br,cott,stime)                Value share of intermediate inputs (fuels) in EN bundle
* Institutional transfers
txfsefa            (se,fa,cott,stime)                Share of agents in factor income
tsave              (cott,stime)                      Savings ratio
* Investments
exo_investments    (cott,stime)                      Exogenous Investments   
* Carbon Taxes
txem               (br,cott,stime)                   Exogenous Carbon Tax - Firms
txemh              (cott,stime)                      Exogenous Carbon Tax - Households

* Benchmark values for Activities
a_invp0            (pr,cott,stime)                   Benchmark value of deliveries to Investment
a_xd0              (pr,cott,stime)                   Benchmark production by branch
a_kle0             (pr,cott,stime)                   Benchmark production by branch
a_ma0              (pr,cott,stime)                   Benchmark demand of materials by branch
a_kl0              (pr,cott,stime)                   Benchmark capital labour bundle
a_eng0             (pr,cott,stime)                   Benchmark demand of energy by branch
a_ele0             (pr,cott,stime)                   Benchmark demand of energy- labour bundle by branch
a_en0              (pr,cott,stime)                   Benchmark demand in fuels by branch
a_kav0             (pr,cott,stime)                   Benchmark capital demand 
a_lav0             (pr,cott,stime)                   Benchmark labour demand
a_io0              (pr,br,cott,stime)                Benchmark input output table in volume
a_hc0              (br,cott,stime)                   Benchmark household consumption by product
* Benchmark values for Prices
p_pwe0             (pr,cott,stime)                   Benchmark value of unit cost of Export
p_invp0            (pr,cott,stime)                   Benchmark value of unit cost of deliveries to Investment
p_wpi0             (stime)                           Benchmark value of price index for taxes and subsidies at quantum (numeraire)
p_pc0              (cott,stime)                      Benchmark value of private consumption price
p_pd0              (pr,cott,stime)                   Benchmark value of unit cost of production corrected for Permit Endowment
p_pdbsr0           (pr,cott,stime)                   Benchmark value of unit cost of Production
p_kle0             (pr,cott,stime)                   Benchmark unit cost of KLE bundle
p_ma0              (pr,cott,stime)                   Benchmark unit cost of materials
p_kl0              (pr,cott,stime)                   Benchmark unit cost of KL bundle
p_eng0             (pr,cott,stime)                   Benchmark unit cost of ENG bundle
p_kav0             (pr,cott,stime)                   Benchmark unit cost of Capital
p_lav0             (pr,cott,stime)                   Benchmark unit cost of Labour
p_en0              (pr,cott,stime)                   Benchmark unit cost of EN bundle
p_ele0             (pr,cott,stime)                   Benchmark unit cost of ENL bundle
p_io0              (pr,cott,stime)                   Benchmark unit cost of intermediate inputs
p_y0               (pr,cott,stime)                   Benchmark unit cost of domestic demand
p_hc0              (pr,cott,stime)                   Benchmark price of household consumption
p_gc0              (pr,cott,stime)                   Benchmark price of government consumption
;

Variables
* Activities
A_YVST              (stime)                          Internation transport services                - activity
A_YVTWR             (pr,cott,stime)                  Exports to international transport pool       - activity
A_XD                (pr,cott,stime)                  Production                                    - activity
A_XXD               (pr,cott,stime)                  Deliveries to Domestic Market                 - activity
A_EXPO              (pr,cott,cott,stime)             Bilateral Exports by branch                   - activity
A_IMPO              (pr,cott,cott,stime)             Bilateral Imports by branch                   - activity
A_IMP               (pr,cott,stime)                  Imports                                       - activity
A_Y                 (pr,cott,stime)                  Domestic Demand                               - activity
A_IO                (pr,br,cott,stime)               IO Deliveries among branches                  - activity
A_HC                (pr,cott,stime)                  Deliveries to Private Consumption by branch   - activity
A_GC                (pr,cott,stime)                  Deliveries to Public Consumption by branch    - activity
A_INVP              (pr,cott,stime)                  Deliveries for Investment by branch           - activity
A_LAV               (pr,cott,stime)                  Demand for labor by skill type                - activity
A_KAV               (pr,cott,stime)                  Demand for capital                            - activity
A_KAVC              (pr,cott,stime)                  Capital stock by branch at the beginning of the period  - activity
A_EN                (pr,cott,stime)                  Fuel Demand by branch in mtoe                 - activity
A_ENG               (pr,cott,stime)                  Energy demand  in mtoe                        - activity
A_ELE               (pr,cott,stime)                  Electricity Demand by branch in mtoe          - activity
A_MA                (pr,cott,stime)                  Demand of Materials                           - activity
A_KL                (pr,cott,stime)                  Capital Labour bundle                         - activity
A_KLE               (pr,cott,stime)                  Capital- Labour - Energy bundle               - activity
A_POPV              (cott,stime)                     Total labour force                            - activity
A_CO2EMM_BR         (br,cott,stime)                  CO2 Energy related Emissions firms m.ton CO2-eq.
A_CO2EMM_HOUS       (cott,stime)                     CO2 Energy related Emissions Households m.ton CO2-eq.

* Prices
P_PD                (pr,cott,stime)                  Unit cost of Production corrected for Permit Endowment  - price (%currency% per unit of output)
P_XD                (pr,cott,stime)                  Unit cost of production                                 - price (%currency% per unit of output)
P_PDBSR             (pr,cott,stime)                  Unit cost of Production (from dual production function) - price (%currency% per unit of output)
P_PWE               (pr,cott,stime)                  Unit cost of Export in international currency           - price (%currency% per unit of output)
P_IMPO              (pr,cott,cott,stime)             Unit cost of Bilateral Imports                          - price (%currency% per unit of output)
P_IMP               (pr,cott,stime)                  Unit cost of Imports incl. duties and trans. costs      - price (%currency% per unit of imports)
P_TR                (stime)                          Price international transport margin                    - price (%currency% per unit of output)
P_Y                 (pr,cott,stime)                  Unit cost of Domestic Demand                            - price (%currency% per unit of output)
P_IO                (pr,cott,stime)                  Delivery Price in Intermediate Demand                   - price (%currency% per unit of output)
P_HC                (pr,cott,stime)                  Unit cost of delivery to Private Consumption            - price (%currency% per unit of output)
P_GC                (pr,cott,stime)                  Unit cost of delivery to Public Consumption             - price (%currency% per unit of output)
P_INVP              (pr,cott,stime)                  Unit cost of Deliveries to Investment                   - price (%currency% per unit of output)
P_LAV               (pr,cott,stime)                  Unit cost of Labor by sector                            - price (%currency% per unit of labour)
P_L                 (cott,stime)                     Unit cost of Labor                                      - price (%currency% per unit of labour)
P_KAV               (pr,cott,stime)                  Unit Cost of Capital                                    - price (%currency% per unit of capital)
P_K                 (cott,stime)                     Unit Cost of Capital                                    - price (%currency% per unit of capital)
P_INV               (pr,cott,stime)                  Unit cost of Investment                                 - price (%currency% per unit of output)
P_ENPR              (pr,br,cott,stime)               Unit cost of Energy incl abatement cost                 - price (%currency% per unit of output)
P_ELE               (pr,cott,stime)                  Price of Electricity                                    - price (%currency% per unit of output)
P_EN                (pr,cott,stime)                  Price of Fuel Aggregate                                 - price (%currency% per unit of output)
P_ENG               (pr,cott,stime)                  Unit cost of energy                                     - price (%currency% per unit of output)
P_MA                (pr,cott,stime)                  Unit cost of Material Aggregate                         - price (%currency% per unit of output)
P_KL                (pr,cott,stime)                  Unit cost of Capital Labour bundle                      - price (%currency% per unit of output)
P_KLE               (pr,cott,stime)                  Unit cost of Capital- Labour - Energy bundle            - price (%currency% per unit of output)
P_WPI               (stime)                          World Price Index                                       - price
P_PC                (cott,stime)                     Price indice of Private Consumption                     - price

* Values
V_FGRB              (gv,pr,cott,stime)               Government revenues                           - accounting item (value)
V_FSEFA             (se,fa,cott,stime)               Payments by Factors to Sectors                - accounting item (value)
V_FSEFAT            (fa,cott,stime)                  Total Payments by Factors                     - accounting item (value)
V_FSESE             (se,sr,cott,stime)               Transfers between Sectors                     - accounting item (value)
V_FC                (se,cott,stime)                  Consumption by Sector                         - accounting item (value)
V_YDISP             (cott,stime)                     Disposable Income                             - accounting item (value)
V_VA                (fa,pr,cott,stime)               Value Added by Factor and Branch              - accounting item (value)
V_SAVE              (se,cott,stime)                  Savings by institutional sector               - accounting item (value)
V_INV               (se,cott,stime)                  Investment by institutional sector            - accounting item (value)
V_SURPL             (se,cott,stime)                  Surplus or deficit by institutional sector    - accounting item (value)
V_HCDTOT            (cott,stime)                     Total household consumption in value          - accounting item (value)

* Rates - Shares - Taxes
RLTLR               (cott,stime)                     Real Interest Rate
RLTLRWORLD          (stime)                          World closure
TXENV               (br,cott,stime)                  Environmental taxes - Firms
TXENVH              (cott,stime)                     Environmental taxes - Household       
;

* Model equations
Equations
epd(br,cott,stime)                     Unit Cost of Goods (less value of grf. permits)
esales(pr,cott,stime)                  Price of Domestically Produced Good
esupply(br,cott,stime)                 Supply Price of Exports (in international currency)
epy(pr,cott,stime)                     Composite Price of Good on the Domestic Market (Armington Price Eq.)
epio(pr,cott,stime)                    Price of Good for Intermediate Consumption (with taxes)
epenpr(pr,br,cott,stime)               Unit User's Cost of Energy (with taxes and abatement cost)
epel(br,cott,stime)                    Unit User's Cost of Electricity (with taxes and abatement cost)
epgc(pr,cott,stime)                    Price of Good for Public Consumption (with taxes)
ephc(pr,cott,stime)                    Price of Good for Private Consumption (with taxes)
epinvp(pr,cott,stime)                  Price of Good for Investment (deliveries) (with taxes)
EEQUILABOUR(cott,stime)                Equilibrium in Labour Market
EEPLAV(pr,cott,stime)                  Unit cost of Labour
EEQUICAPITAL(cott,stime)               Equilibrium in Capital Market
EEPKAV(pr,cott,stime)                  Unit cost of Capital
exd(br,cott,stime)                     Unit Production Cost of Good by BR
epkle(pr,cott,stime)                   Price of KLE bundle
epm(pr,cott,stime)                     Unit Cost of Material Aggregate (non energy)
epkl(pr,cott,stime)                    Price of KL bundle
epe(br,cott,stime)                     Unit User's Cost of Fuel Aggregate (with taxes and abatement cost)
epeng(pr,cott,stime)                   Price of ENG bundle
ekav(pr,cott,stime)                    Demand for Capital Services by Branch
elav(pr,cott,stime)                    Demand for labour
ekle(pr,cott,stime)                    Demand for KLE bundle
ema(pr,cott,stime)                     Demand for TRAMA bundle
ekl(pr,cott,stime)                     Demand for Capital and Labor services (KL)
eeng(pr,cott,stime)                    Demand for ENG bundle
eenl(pr,cott,stime)                    Demand for Electricity by Branch
een(pr,cott,stime)                     Demand for EN (fuels) Aggregate by Branch
eiovtot(pr,br,cott,stime)              Deliveries from Branches to Branches for Intermediate Consumption
einvpv(pr,cott,stime)                  Deliveries from Branches to Branches for Investment
einv(se,cott,stime)                    Total Investment Expenditure by Sector
ekavc(pr,cott,stime)                   Capital Stock Available Next Period
eydisp(cott,stime)                     Disposable Income of Households
etsave(cott,stime)                     Consumption Expenditure by H
egcv(pr,cott,stime)                    Deliveries to Public Consumption by BR
eHCV(pr,cott,stime)                    Deliveries to Private Consumption by BR
exdtot(br,cott,stime)                  Total Domestic Production by BR
eydem(pr,cott,stime)                   Total Domestic Demand
eabsor(pr,cott,stime)                  Demand for Domestic Production by Domestic Consumers (Armington)
epwxo(pr,cott,cott,stime)              Import Price (in international currency)
epimpl(pr,cott,stime)                  Composite Import Price with Duties (Armington)
eexpol(br,cott,cott,stime)             Export Demand (bilateral)
eimpl(br,cott,stime)                   Total Imports (Comp.+non Comp. linked model)
eimpo(br,cott,cott,stime)              Bilateral Import Demand (Armington)
zpf_vst(stime)                         Zero profits international transport services
mkt_vst(stime)                         Market clearing international transport services
def_yvtwr(pr,cott,stime)               Definition exports to international transport pool
efgrbtotl(gv,pr,cott,stime)            Transfers from Branches to G (by govern. category linked model)
efsese(se,sr,cott,stime)               Transfers from Sectors to Sectors
evatot(fa,pr,cott,stime)               Value Added by Factor and Branch
efsefa(se,fa,cott,stime)               Transfers from Factors to Sectors
efcftot(se,cott,stime)                 Consumption Expenditure by Sector
esavel(se,cott,stime)                  Savings by Sector (linked model)
esurpl(se,cott,stime)                  Surplus by Sector
eemmbr(br,cott,stime)                  CO2 Energy related emissions by Branches
eemmhous(cott,stime)                   CO2 Energy related emissions in H
etxenv(br,cott,stime)                  Carbon Tax - Firms 
etxenvh(cott,stime)                    Carbon Tax - Household 
ewpi(stime)                            World Price Index                                       - price
;

* Intermediate Consumption
CAL_indc(pr,br,cott) = opengem_sec_io(pr,br,cott)/1000;
* Household Consumption
CAL_hc(pr,cott)      = opengem_sec_io(pr,"01-HC",cott)/1000;
* Government Consumption
CAL_gc(pr,cott)      = opengem_sec_io(pr,"02-GC",cott)/1000;
* Investment
CAL_inv_v(pr,cott)   = opengem_sec_io(pr,"03-INV",cott)/1000;
* Exports
CAL_exprts(pr,cott)  = opengem_sec_io(pr,"04-EXP",cott)/1000;
* Transport Margins
CAL_vstexp(pr,cott)  = opengem_sec_io(pr,"05-VST-EXP",cott)/1000;

* Capital
CAL_cap(br,cott)     = opengem_sec_io("01-CAP",br,cott)/1000
                     + opengem_sec_io("03-LAND",br,cott)/1000
                     + opengem_sec_io("04-NATR",br,cott)/1000;

* Labour
CAL_lab(br,cott)     = opengem_sec_io("02-LOWS",br,cott)/1000
                     + opengem_sec_io("02-SHOP",br,cott)/1000
                     + opengem_sec_io("02-TECH",br,cott)/1000
                     + opengem_sec_io("02-CLRK",br,cott)/1000
                     + opengem_sec_io("02-OMGR",br,cott)/1000;

* Taxes on products
CAL_tax_it(pr,cott)  = opengem_sec_io("09-TXPt",pr,cott)/1000;

* Taxes on production
CAL_sub(br,cott)     = opengem_sec_io("10-TXPn",br,cott)/1000
                     + opengem_sec_io("11-TXE",br,cott)/1000
                     + opengem_sec_io("05-TXK",br,cott)/1000  
                     + opengem_sec_io("06-TXL",br,cott)/1000
                     + opengem_sec_io("07-TXLAND",br,cott)/1000
                     + opengem_sec_io("08-TXNATR",br,cott)/1000;

* Duties
CAL_dut(br,cott)     = opengem_sec_io("12-DUT",br,cott)/1000;

* Imports
CAL_imprts(br,cott)  = opengem_sec_io("13-IMP",br,cott)/1000;

* Margins
CAL_vstimp(br,cott)  = opengem_sec_io("14-VST-IMP",br,cott)/1000;


* Adjustments due to negative price of domestic production
CAL_tax_it("ENE01","FRA") = CAL_tax_it("ENE01","FRA") + CAL_sub("ENE01","FRA");
CAL_sub("ENE01","FRA")    = 0;

CAL_tax_it(pr_tra,cott)   = CAL_tax_it(pr_tra,cott) + CAL_sub(pr_tra,cott);
CAL_sub(pr_tra,cott)      = 0;

* Bilateral Exports, Margins, Duties
CAL_expbil(pr,cott,cutt)   = opengem_sec_expbil(pr,cott,cutt)/1000;
CAL_dutbil(pr,cott,cutt)   = opengem_sec_dutbil(pr,cott,cutt)/1000;
CAL_tcbil(pr,br,cott,cutt) = opengem_sec_tcbil(pr,br,cott,cutt)/1000;

* Capital Stock
CAL_Capital_Stock(pr,cott) = opengem_sec_capstock(cott)/1000 * CAL_cap(pr,cott)
                           / sum(br, CAL_cap(br,cott));

* Energy
CAL_etf(pr,br,cott)        = opengem_sec_ene(pr,br,cott);
CAL_etp(pr,cott)           = opengem_sec_ene(pr,"01-HC",cott);
CAL_exi(pr,cott,cutt)      = opengem_sec_exi(pr,cott,cutt);

* Emissions
CAL_mtf(pr,br,cott)        = opengem_sec_emi(pr,br,cott);
CAL_mtp(pr,cott)           = opengem_sec_emi(pr,"01-HC",cott);

* Common Assumptions for all regions
* Investment
decl(pr,cott,pbyear)       = 0.04;
decl(pr,cott,byear)        = 0.04;
* Elasticities
sn1(pr,cott,byear)         = 0.20;
sn2(pr,cott,byear)         = opengem_sec_ELFVAEN(pr,cott);
sn3(pr,cott,byear)         = 0.25;
sn5(pr,cott,byear)         = 0.90;
sn6(pr,cott,byear)         = 0.90;
sn7(pr,cott,byear)         = opengem_sec_ESUBVA(pr,cott);
sigmax(pr,cott,byear)      = opengem_sec_ESUBD(pr,cott);
sigmai(pr,cott,byear)      = opengem_sec_ESUBM(pr,cott);
* Carbon Tax
txem(br,cott,byear)        = 0;
txemh(cott,byear)          = 0;

* Consumption
CAL_frisch(cott)           = -2.00;
* Unit Cost of Production
CAL_PD(pr,cott)            =  1.00;
* Real Interest Rate
CAL_rltlr(cott)            =  0.02;
* Income Elasticity
CAL_eehc(pr,cott)          =  1.00;
* Population
CAL_pop_tot(cott)          = opengem_sec_population(cott);
* Production
CAL_prod(br,cott)          = sum(pr, CAL_indc(pr,br,cott))
                           + CAL_cap(br,cott) 
                           + CAL_lab(br,cott);

* Normalization it Transport Margins
CAL_vstexp(pr_tra,cott)    = CAL_vstexp(pr_tra,cott) *
                             sum((br,er,cr), CAL_tcbil(pr_tra,br,er,cr))
                           / sum(er, CAL_vstexp(pr_tra,er));

*----------------------------------------------------------------------------------------------------------------------*
* CALIBRATION OF THE MODEL                                                      
*----------------------------------------------------------------------------------------------------------------------*
* Governement Taxes (Payments by Branches to Public Sector)
V_FGRB.l("SUB",pr,cott,byear) = CAL_sub(pr,cott)   ;
V_FGRB.l("IT",pr,cott,byear)  = CAL_tax_it(pr,cott);
V_FGRB.l("DUT",pr,cott,byear) = CAL_dut(pr,cott)   ;

* Real Interest rate
RLTLR.L(cott,byear)        = CAL_rltlr(cott);

* Use of the Harberger convention to set prices
P_PD.l(pr,cott,byear)      = CAL_PD(pr,cott);

* Fossil Fuels and Electricity
A_XD.l(pr,cott,byear)      = sum(br, CAL_etf(pr,br,cott)) + CAL_etp(pr,cott)
                           + sum(cutt, CAL_exi(pr,cott,cutt))
                           - sum(cutt, CAL_exi(pr,cutt,cott));

P_PD.l(pr,cott,byear)$A_XD.l(pr,cott,byear)
                           = CAL_prod(pr,cott)/A_XD.l(pr,cott,byear);

* Total Production
P_PDBSR.l(pr,cott,byear)   = P_PD.l(pr,cott,byear);
A_XD.l(pr,cott,byear)      = CAL_prod(pr,cott)/P_PD.l(pr,cott,byear);

* Subsidies (Ad quantum tax)
txproduction(pr,cott,byear)$A_XD.l(pr,cott,byear)
                           = V_FGRB.l("SUB",pr,cott,byear)/A_XD.l(pr,cott,byear);

* Sale price including subsidies
P_PWE.l(pr,cott,byear)     = P_PD.l(pr,cott,byear) + txproduction(pr,cott,byear);
P_XD.l(pr,cott,byear)      = P_PD.l(pr,cott,byear) + txproduction(pr,cott,byear);
P_TR.l(byear)              = 1;

*----------------------------------------------------------------------------------------------------------------------*
* Trade
* Volume of Bilateral Exports
A_EXPO.l(pr,cott,cutt,byear) = CAL_expbil(pr,cott,cutt)/P_PWE.l(pr,cott,byear);
A_IMPO.l(pr,cutt,cott,byear) = A_EXPO.l(pr,cott,cutt,byear);

*----------------------------------------------------------------------------------------------------------------------*
*                                        International Transport services
*----------------------------------------------------------------------------------------------------------------------*
p_pwe0(pr_tra,cott,byear)   = P_PWE.l(pr_tra,cott,byear);

Parameters
vvtwrag_vol(br,cott,cott)
vstag_vol(br,cott) 
;

vvtwrag_vol(br,cott,cutt)    = CAL_tcbil(pr_tra,br,cott,cutt)/P_PWE.l(pr_tra,cutt,byear);

cif_vtwr(br,cott,cutt,byear) = (CAL_tcbil(pr_tra,br,cott,cutt)
                               /A_IMPO.l(br,cott,cutt,byear))$A_IMPO.l(br,cott,cutt,byear)+0 ;

vstag_vol(pr_tra,cott)       = CAL_vstexp(pr_tra,cott)/P_TR.l(byear);

theta_vst(cott,byear)$sum(cutt, vstag_vol(pr_tra,cutt))
                             = vstag_vol(pr_tra,cott)/sum(cutt, vstag_vol(pr_tra,cutt));

A_YVTWR.l(pr_tra,cott,byear) = vstag_vol(pr_tra,cott);

vtag(byear)                  = sum(cott, vstag_vol(pr_tra,cott));

A_YVST.l(byear)              = 1;


check_TRN("Dem_Sup1")= sum((br,cott,cutt), CAL_tcbil(pr_tra,br,cott,cutt))
                     - sum(cott, CAL_vstexp(pr_tra,cott));
check_TRN("Dem_Sup2")= sum(cott, P_TR.l(byear) * vstag_vol(pr_tra,cott))
                     - sum((br,cott,cutt), P_PWE.l(pr_tra,cutt,byear)*vvtwrag_vol(br,cott,cutt));
check_TRN("zpf_VST") = P_TR.l(byear)
                     - sum(cott, theta_vst(cott,byear));
check_TRN("mkt_VST") = sum(cott,  sum(byear, P_TR.l(byear) * vstag_vol(pr_tra,cott)))
                     - sum((pr,cott,cutt), A_EXPO.l(pr,cott,cutt,byear)*cif_vtwr(pr,cutt,cott,byear));

abort$(abs(check_TRN("mkt_VST")) gt 1e-4)
                                 "Demand and Supply of transport services not equal", check_TRN;
abort$(abs(check_TRN("zpf_VST")) gt 1e-4)
                                 "Zero profit of transport services not satisfied",   check_TRN;

*----------------------------------------------------------------------------------------------------------------------*
*                                        Production for domestic consumption
*----------------------------------------------------------------------------------------------------------------------*
A_XXD.l(br,cott,byear)  = A_XD.l(br,cott,byear)
                        - sum(cutt, A_EXPO.l(br,cott,cutt,byear))
                        - A_YVTWR.l(br,cott,byear);

* Check for Negative production
check_XXD(br,cott)$(A_XXD.l(br,cott,byear) < 0) = 1;

abort$(smax((br,cott), abs(check_XXD(br,cott))) gt 1e-4)
         "Negative production for domestic consumption", check_XXD;

*----------------------------------------------------------------------------------------------------------------------*
* Calculation of tax ratios related to imports (Ad quantum tax)
txduto(pr,cott,cutt,byear)$A_IMPO.l(pr,cott,cutt,byear)
                           = CAL_dutbil(pr,cott,cutt)
                            /A_IMPO.l(pr,cott,cutt,byear);

* Total Imports
A_IMP.l(pr,cott,byear)$sum(cutt, A_IMPO.l(pr,cott,cutt,byear))
                           = CAL_imprts(pr,cott)
                           /(sum(cutt, P_PWE.l(pr,cutt,byear)*A_IMPO.l(pr,cott,cutt,byear))/
                             sum(cutt, A_IMPO.l(pr,cott,cutt,byear))                      );

* Unit cost of Bilateral Imports
P_IMPO.l(pr,cott,cutt,byear) = P_PWE.l(pr,cutt,byear)
                             + cif_vtwr(pr,cott,cutt,byear)*P_TR.l(byear)
                             + txduto(pr,cott,cutt,byear);

* Unit cost of Imports
P_IMP.l(pr,cott,byear)$A_IMP.l(pr,cott,byear)
                             = (sum(cutt, P_IMPO.l(pr,cott,cutt,byear) * A_IMPO.l(pr,cott,cutt,byear))
                             /  A_IMP.l(pr,cott,byear));
;

* Calibration of armington coefficient (share among regions)
betashare(br,cott,cutt,byear)$((A_IMP.l(br,cott,byear) gt 0) and (A_IMPO.l(br,cott,cutt,byear) gt 0))
 = (((A_IMPO.l(br,cott,cutt,byear)/(A_IMP.l(br,cott,byear)))**(1/(sigmai(br,cott,byear))))
                                 / (P_IMP.l(br,cott,byear)/P_IMPO.l(br,cott,cutt,byear)));

* Composite Goods
A_Y.l(br,cott,byear) = A_XXD.l(br,cott,byear) + A_IMP.l(br,cott,byear);

P_Y.l(pr,cott,byear)$(A_Y.l(pr,cott,byear))
                    = (P_IMP.l(pr,cott,byear) * A_IMP.l(pr,cott,byear)
                     + P_XD.l(pr,cott,byear)  * A_XXD.l(pr,cott,byear)
                      )/A_Y.l(pr,cott,byear);

deltashare(pr,cott,byear)$A_XXD.l(pr,cott,byear)
                        = P_IMP.l(pr,cott,byear)/P_XD.l(pr,cott,byear)
                        *(A_IMP.l(pr,cott,byear)/A_XXD.l(pr,cott,byear))**(1/sigmax(pr,cott,byear))
                        /(1+(P_IMP.l(pr,cott,byear)/P_XD.l(pr,cott,byear)
                        *(A_IMP.l(pr,cott,byear)/A_XXD.l(pr,cott,byear))**(1/sigmax(pr,cott,byear))));
                                                  
ac(br,cott,byear)$A_XXD.l(br,cott,byear)
                = ((deltashare(br,cott,byear)**sigmax(br,cott,byear)*P_IMP.l(br,cott,byear)**(1-sigmax(br,cott,byear))
                + (1-deltashare(br,cott,byear))**(sigmax(br,cott,byear))*P_XD.l(br,cott,byear)
                **(1-sigmax(br,cott,byear)) )**(1/(1-sigmax(br,cott,byear))) )/P_Y.l(br,cott,byear);

* Tax Rates
txproducts(pr,cott,byear)$(A_Y.l(pr,cott,byear) ne 0)
                         = V_FGRB.l("IT",pr,cott,byear)/A_Y.l(pr,cott,byear);

* Consumer Prices
P_IO.l(pr,cott,byear)    = txproducts(pr,cott,byear)+P_Y.l(pr,cott,byear);
P_HC.l(pr,cott,byear)    = txproducts(pr,cott,byear)+P_Y.l(pr,cott,byear);
P_GC.l(pr,cott,byear)    = txproducts(pr,cott,byear)+P_Y.l(pr,cott,byear);
P_INVP.l(pr,cott,byear)  = txproducts(pr,cott,byear)+P_Y.l(pr,cott,byear);

* Energy Prices
P_ENPR.l(pren,br,cott,byear) = P_IO.l(pren,cott,byear);
P_ELE.l(br,cott,byear)       = P_IO.l(pr_pow,cott,byear);

* Demand
A_IO.l(pr,br,cott,byear)     = CAL_indc(pr,br,cott)/P_IO.l(pr,cott,byear);

A_HC.l(pr,cott,byear)        = CAL_hc(pr,cott)   /P_HC.l(pr,cott,byear);
A_GC.l(pr,cott,byear)        = CAL_gc(pr,cott)   /P_GC.l(pr,cott,byear);
A_INVP.l(pr,cott,byear)      = CAL_inv_v(pr,cott)/P_INVP.l(pr,cott,byear);

* Labour
A_LAV.l(pr,cott,byear)       = CAL_pop_tot(cott) * CAL_lab(pr,cott)
                                         / sum(br, CAL_lab(br,cott));

P_L.l(cott,byear)            = sum(pr, CAL_lab(pr,cott)) /sum(pr, A_LAV.l(pr,cott,byear));
P_LAV.l(pr,cott,byear)       = P_L.l(cott,byear);

* Capital and Investment
P_K.l(cott,byear)            = sum(br, CAL_cap(br,cott))/sum(br, CAL_Capital_Stock(br,cott));
P_KAV.l(pr,cott,byear)       = P_K.l(cott,byear);    

A_KAV.l(pr,cott,byear)       = CAL_cap(pr,cott)/P_KAV.l(pr,cott,byear);

tinvpv(pr,cott,byear)        = P_INVP.l(pr,cott,byear) * A_INVP.l(pr,cott,byear)
                             / sum(br, CAL_inv_v(br,cott));

* For Base year
ttime(pbyear) = pbyear.val;
ttime1(pbyear)= byear.val;
* For Next period after byear
ttime(byear)  = byear.val;
ttime1(byear) = 2020;


A_KAVC.l(pr,cott,pbyear) = A_KAV.l(pr,cott,byear);
A_KAVC.l(pr,cott,byear)  = (1-decl(pr,cott,byear))**(ttime1(byear)-ttime(byear))
                          *A_KAV.l(pr,cott,byear)
                         + (1-(1-decl(pr,cott,byear))**(ttime1(byear)- ttime(byear)))
                           /decl(pr,cott,byear) *A_INVP.l(pr,cott,byear);

* Base year prices
p_invp0(pr,cott,byear) = P_INVP.l(pr,cott,byear);
a_invp0(pr,cott,byear) = A_INVP.l(pr,cott,byear);

* Value Added
V_VA.l("LAB",pr,cott,byear) = P_LAV.l(pr,cott,byear)*A_LAV.l(pr,cott,byear);
V_VA.l("CAP",pr,cott,byear) = P_KAV.l(pr,cott,byear)*A_KAV.l(pr,cott,byear);

*----------------------------------------------------------------------------------------------------------------------*
* RATES for FACTORS INCOME ALLOCATION
V_FSEFA.L("H","LAB",cott,byear) = 1.00 * sum(pr, V_VA.l("LAB",pr,cott,byear));
V_FSEFA.L("H","CAP",cott,byear) = 1.00 * sum(pr, V_VA.l("CAP",pr,cott,byear));

txfsefa(se,fa,cott,byear)$(sum(br,V_VA.l(fa,br,cott,byear)))
                          = V_FSEFA.l(se,fa,cott,byear)/sum(br, V_VA.l(fa,br,cott,byear));
*----------------------------------------------------------------------------------------------------------------------*
* RATES for INCOME ALLOCATION among SECTORS
V_FSESE.L(se,sr,cott,byear)= 0;
V_FC.L(se,cott,byear)      = [ sum(pr, CAL_hc(pr,cott))       ]$(sameas(se,"H"))
                           + [ 0.0                            ]$(sameas(se,"F"))
                           + [ sum(pr, CAL_gc(pr,cott))       ]$(sameas(se,"G"))
                           + [ sum(pr, CAL_exprts(pr,cott))
                           +   sum(pr, CAL_vstexp(pr,cott))   ]$(sameas(se,"W"));

*----------------------------------------------------------------------------------------------------------------------*
* INCOME
V_YDISP.l(cott,byear) = sum(fa, V_FSEFA.l("H",fa,cott,byear))
                      + sum(sr, V_FSESE.l("H",sr,cott,byear))
                      - sum(sr, V_FSESE.l(sr,"H",cott,byear));

*----------------------------------------------------------------------------------------------------------------------*
* Quantities in production function
A_MA.l(br,cott,byear)       = sum(prma,   A_IO.l(prma,br,cott,byear));
A_ELE.l(br,cott,byear)      = A_IO.l(pr_pow,br,cott,byear);
A_EN.l(br,cott,byear)       = sum(prfuel, A_IO.l(prfuel,br,cott,byear));
A_ENG.l(br,cott,byear)      = A_ELE.l(br,cott,byear) + A_EN.l(br,cott,byear);
A_KL.l(br,cott,byear)       = CAL_lab(br,cott) + CAL_cap(br,cott);
A_KLE.l(br,cott,byear)      = A_ENG.l(br,cott,byear)   + A_KL.l(br,cott,byear);

* Prices
P_EN.l(br,cott,byear) $(A_EN.l(br,cott,byear))
                      = sum(prfuel, A_IO.l(prfuel,br,cott,byear)*P_IO.l(prfuel,cott,byear))
                      / A_EN.l(br,cott,byear);

P_MA.l(br,cott,byear) $(A_MA.l(br,cott,byear))
                      = sum(prma, A_IO.l(prma,br,cott,byear)*P_IO.l(prma,cott,byear))
                      / A_MA.l(br,cott,byear);

P_ENG.l(br,cott,byear)$(A_ENG.l(br,cott,byear))
                      =(P_ELE.l(br,cott,byear)*A_ELE.l(br,cott,byear)
                      + P_EN.l(br,cott,byear) *A_EN.l(br,cott,byear))
                      / A_ENG.l(br,cott,byear);

P_KL.l(br,cott,byear) $(A_KL.l(br,cott,byear))
                      =(P_LAV.l(br,cott,byear)*A_LAV.l(br,cott,byear)
                      + P_KAV.l(br,cott,byear)*A_KAV.l(br,cott,byear))
                      / A_KL.l(br,cott,byear);

P_KLE.l(br,cott,byear)$(A_KLE.l(br,cott,byear))
                      =(P_KL.l(br,cott,byear) *A_KL.l(br,cott,byear)
                      + P_ENG.l(br,cott,byear)*A_ENG.l(br,cott,byear))
                      / A_KLE.l(br,cott,byear);

* Share - Distribution parameters
theta_dkle(br,cott,byear)$(A_XD.l(br,cott,byear) and A_KLE.l(br,cott,byear))
                         = P_KLE.l(br,cott,byear) *  A_KLE.l(br,cott,byear)
                         /(P_PD.l(br,cott,byear)  *  A_XD.l(br,cott,byear));

theta_dma(br,cott,byear) $(A_XD.l(br,cott,byear) and A_MA.l(br,cott,byear))
                         = P_MA.L(br,cott,byear)  *  A_MA.l(br,cott,byear)
                         /(P_PD.l(br,cott,byear)  *  A_XD.l(br,cott,byear));

theta_dmpr(prma,br,cott,byear)$(A_XD.l(br,cott,byear) and A_MA.l(br,cott,byear))
                         =  P_IO.L(prma,cott,byear)* A_IO.l(prma,br,cott,byear)
                         / (P_MA.l(br,cott,byear)  * A_MA.l(br,cott,byear));

theta_dkl(br,cott,byear) $(A_XD.l(br,cott,byear) and A_KLE.l(br,cott,byear))
                         = P_KL.L(br,cott,byear)  *  A_KL.l(br,cott,byear)
                         /(P_KLE.l(br,cott,byear) *  A_KLE.l(br,cott,byear));

theta_deng(br,cott,byear)$(A_XD.l(br,cott,byear) and A_KLE.l(br,cott,byear)) 
                         = P_ENG.l(br,cott,byear) *  A_ENG.l(br,cott,byear)
                         /(P_KLE.l(br,cott,byear) *  A_KLE.l(br,cott,byear));

theta_dkav(br,cott,byear)$(A_XD.l(br,cott,byear) and A_KL.l(br,cott,byear)) 
                         = P_KAV.L(br,cott,byear) * A_KAV.l(br,cott,byear)
                         /(P_KL.l(br,cott,byear)  * A_KL.l(br,cott,byear));

theta_dlav(br,cott,byear)$(A_XD.l(br,cott,byear) and A_KL.l(br,cott,byear)) 
                         = P_LAV.L(br,cott,byear) * A_LAV.l(br,cott,byear)
                         /(P_KL.l(br,cott,byear)  * A_KL.l(br,cott,byear));

theta_de(br,cott,byear)  $(A_XD.l(br,cott,byear) and A_ENG.l(br,cott,byear)) 
                         = P_EN.L(br,cott,byear)  * A_EN.l(br,cott,byear)
                         /(P_ENG.l(br,cott,byear)  * A_ENG.l(br,cott,byear));

theta_dele(br,cott,byear)$(A_XD.l(br,cott,byear) and A_ENG.l(br,cott,byear)) 
                         = P_ELE.L(br,cott,byear)  * A_ELE.l(br,cott,byear)
                         /(P_ENG.l(br,cott,byear)  * A_ENG.l(br,cott,byear));

                     
theta_depr(prfuel,br,cott,byear)$(A_XD.l(br,cott,byear) and A_EN.l(br,cott,byear))
                         = P_IO.L(prfuel,cott,byear)* A_IO.l(prfuel,br,cott,byear)
                         /(P_EN.l(br,cott,byear)    * A_EN.l(br,cott,byear));

check_theta("KLE and MA",br,cott) = theta_dkle(br,cott,byear) + theta_dma(br,cott,byear); 
check_theta("MA",br,cott)         = sum(prma, theta_dmpr(prma,br,cott,byear));
check_theta("KL and ENG",br,cott) = theta_dkl(br,cott,byear)  + theta_deng(br,cott,byear); 
check_theta("K and L",br,cott)    = theta_dkav(br,cott,byear) + theta_dlav(br,cott,byear); 
check_theta("EN and ELE",br,cott) = theta_de(br,cott,byear)   + theta_dele(br,cott,byear);
check_theta("FUELS",br,cott)      = sum(prfuel, theta_depr(prfuel,br,cott,byear));

*----------------------------------------------------------------------------------------------------------------------*
* Household Consumption
V_HCDTOT.l(cott,byear) = sum(pr, P_HC.L(pr,cott,byear)*A_HC.l(pr,cott,byear));

* Saving rate
tsave(cott,byear)      = 1 - V_HCDTOT.l(cott,byear)/V_YDISP.l(cott,byear);

* Shares in household consumption
hcbse(pr,cott,byear)   = (A_HC.L(pr,cott,byear)*P_HC.L(pr,cott,byear))
                            /V_HCDTOT.L(cott,byear);
                       
bhcfv(pr,cott,byear)   = CAL_eehc(pr,cott)*hcbse(pr,cott,byear);

chcfv(pr,cott,byear)   = A_HC.l(pr,cott,byear)+(V_HCDTOT.l(cott,byear))*bhcfv(pr,cott,byear)
                       /(P_HC.l(pr,cott,byear)*CAL_frisch(cott));

str(cott,byear)        = (V_HCDTOT.l(cott,byear)-sum(pr, chcfv(pr,cott,byear)*P_HC.l(pr,cott,byear)))
                        /(V_YDISP.l(cott,byear) -sum(pr, chcfv(pr,cott,byear)*P_HC.l(pr,cott,byear)));

stp(cott,byear)        = str(cott,byear)*RLTLR.L(cott,byear);

check_HCDTOT(cott)     = - V_HCDTOT.l(cott,byear)
                       + sum(pr, P_HC.l(pr,cott,byear)*chcfv(pr,cott,byear))
                       + (stp(cott,byear)/RLTLR.l(cott,byear))*
                         (V_YDISP.l(cott,byear)- sum(pr, P_HC.l(pr,cott,byear)*chcfv(pr,cott,byear)));

abort$(smax(cott, abs(check_HCDTOT(cott)))gt 1e-7)
    "Household consumption is not correctly calibrated";

*----------------------------------------------------------------------------------------------------------------------*
* Public Consumption
gctv(cott,byear)      = sum(pr, A_GC.l(pr,cott,byear));
tgcv(pr,cott,byear)   = A_GC.l(pr,cott,byear)/gctv(cott,byear);

*----------------------------------------------------------------------------------------------------------------------*
* Population
TotPopulation(cott,byear) = sum(pr,  A_LAV.l(pr,cott,byear));

*----------------------------------------------------------------------------------------------------------------------*
* Value Added
*-------------------------------------------------------------------------------
gdpu(cott,byear)    =  sum(fa,sum(br, V_VA.l(fa,br,cott,byear)))
                    +  sum(gv,sum(br, V_FGRB.l(gv,br,cott,byear)));

gdpv(cott,byear)    =  gdpu(cott,byear);

V_SAVE.l(se,cott,byear)  = [ V_YDISP.l(cott,byear) - V_HCDTOT.l(cott,byear)        ]$(sameas(se,"H"))
                      + [ sum(fa, V_FSEFA.l(se,fa,cott,byear))
                        + sum(sr, V_FSESE.l(se,sr,cott,byear) - V_FSESE.l(sr,se,cott,byear) )
                      - V_FC.l(se,cott,byear)                              ]$(sameas(se,"F"))
                      + [ sum((gv,br), V_FGRB.l(gv,br,cott,byear))
                        + sum(fa, V_FSEFA.l(se,fa,cott,byear))
                        + sum(sr, V_FSESE.l(se,sr,cott,byear) - V_FSESE.l(sr,se,cott,byear))
                        - V_FC.l(se,cott,byear)                              ]$(sameas(se,"G"))
                      + [ sum(br, P_IMP.l(br,cott,byear) * A_IMP.l(br,cott,byear))
                        - sum(br, V_FGRB.l("DUT",br,cott,byear))
                        + sum(fa, V_FSEFA.l(se,fa,cott,byear))
                        + sum(sr, V_FSESE.l(se,sr,cott,byear) - V_FSESE.l(sr,se,cott,byear))
                        - V_FC.l(se,cott,byear)                              ]$(sameas(se,"W"))
;   

* Investment Financing (share by sector of financing of investments)
tcinv("h",cott,byear)   = 0.15;
tcinv("g",cott,byear)   = 0.55;
tcinv("w",cott,byear)   = 0;
tcinv("f",cott,byear)   = 1- sum(se$(not sameas(se,"f")), tcinv(se,cott,byear));


V_INV.L(se,cott,byear)   = tcinv(se,cott,byear) * sum(br, CAL_inv_v(br,cott));

V_SURPL.L(se,cott,byear) = V_SAVE.L(se,cott,byear)- V_INV.L(se,cott,byear);


exo_investments(cott,byear)   = sum(br, CAL_inv_v(br,cott));

* ----------------------------------------------------------------------------------------------------------------------
*                                                     CO2 Energy Related Emissions
* ----------------------------------------------------------------------------------------------------------------------
Parameters
average_emf(pr,cott)      Average emission factor by the data - Firms
average_emfh(pr,cott)     Average emission factor by the data - Households
sectoral_emf(pr,br,cott)  Sectoral emission factor by the data - Firms
eaf_adjust(pr,cott)       Difference from GTAP database
eafh_adjust(pr,cott)      Difference from GTAP database
;

average_emf(prfuel,cott) = sum(br, CAL_mtf(prfuel,br,cott))
                          /sum(br, CAL_etf(prfuel,br,cott));

sectoral_emf(prfuel,br,cott)$(CAL_etf(prfuel,br,cott))
                            = CAL_mtf(prfuel,br,cott)
                            / CAL_etf(prfuel,br,cott);

average_emfh(prfuel,cott)  = CAL_mtp(prfuel,cott)
                            /CAL_etp(prfuel,cott);

*  Emission Factors
emf("ENE01",byear)  = 3.80;
emf("ENE03",byear)  = 2.86;
emf("ENE04",byear)  = 2.23;

aer(prfuel,br,cott,byear) = 1;
eaf(prfuel,br,cott,byear) = 1;

* Energy vs non-Energy Use
aer(prfuel,br,cott,byear)$sectoral_emf(prfuel,br,cott)
                        = sectoral_emf(prfuel,br,cott)
                        / emf(prfuel,byear);

* Emission Adjustment Factor
eaf(prfuel,br,cott,byear)$(aer(prfuel,br,cott,byear) > 1)
                         = aer(prfuel,br,cott,byear);
 
aer(prfuel,br,cott,byear)$(aer(prfuel,br,cott,byear) > 1)  = 1;

* Emissions Factors
bec(prfuel,br,cott,byear) = emf(prfuel,byear);


* Adjustment to GTAP Database
eaf_adjust(prfuel,cott) = sum(br, CAL_mtf(prfuel,br,cott))
                         /sum(br, bec(prfuel,br,cott,byear)*aer(prfuel,br,cott,byear)*eaf(prfuel,br,cott,byear)*A_IO.l(prfuel,br,cott,byear));

eaf(prfuel,br,cott,byear) = eaf_adjust(prfuel,cott) *  eaf(prfuel,br,cott,byear);

* Households
bech(prfuel,cott,byear) = average_emfh(prfuel,cott);
eafh(prfuel,cott,byear) = 1;

eafh_adjust(prfuel,cott)$(bech(prfuel,cott,byear)*eafh(prfuel,cott,byear)*A_HC.l(prfuel,cott,byear))
  = CAL_mtp(prfuel,cott)/(bech(prfuel,cott,byear)*eafh(prfuel,cott,byear)*A_HC.l(prfuel,cott,byear));

eafh(prfuel,cott,byear) = eafh(prfuel,cott,byear) * eafh_adjust(prfuel,cott);

* Initialise emissions
A_CO2EMM_BR.l(br,cott,byear) = sum(prfuel, bec(prfuel,br,cott,byear)*aer(prfuel,br,cott,byear)*eaf(prfuel,br,cott,byear)*A_IO.l(prfuel,br,cott,byear));
A_CO2EMM_HOUS.l(cott,byear)  = sum(prfuel, bech(prfuel,cott,byear)*eafh(prfuel,cott,byear)*A_HC.l(prfuel,cott,byear));

TXENV.l(br,cott,byear)  = txem(br,cott,byear) ; 
TXENVH.l(cott,byear)    = txemh(cott,byear); 
*----------------------------------------------------------------------------------------------------------------------*
* Base year values
P_WPI.L(byear)          = 1;
RLTLRWORLD.l(byear)     = 1;

*-------------------------------------------------------------------------------------------------------------
* Checks

Check_CALIB_SEC("HC",pr,cott) = A_HC.l(pr,cott,byear) * P_HC.l(pr,cott,byear)
                              - CAL_hc(pr,cott);
Check_CALIB_SEC("GC",pr,cott) = A_GC.l(pr,cott,byear) * P_GC.l(pr,cott,byear)
                              - CAL_gc(pr,cott);                              
Check_CALIB_SEC("INV",pr,cott)= A_INVP.l(pr,cott,byear) * P_INVP.l(pr,cott,byear)
                              - CAL_inv_v(pr,cott);                              
Check_CALIB_SEC("EXP",pr,cott)= sum(cutt, A_EXPO.l(pr,cott,cutt,byear)) * P_PWE.l(pr,cott,byear)
                              - CAL_exprts(pr,cott); 
Check_CALIB_SEC("EXP-VST",pr,cott) = A_YVTWR.L(pr,cott,byear) * P_TR.L(byear)
                                   - CAL_vstexp(pr,cott);

Check_CALIB_SEC("IO_DEM",pr,cott) = sum(br, A_IO.l(pr,br,cott,byear) * P_IO.l(pr,cott,byear))
                                  - sum(br, CAL_indc(pr,br,cott));
Check_CALIB_SEC("IO_SUP",pr,cott) = sum(br, A_IO.l(br,pr,cott,byear) * P_IO.l(br,cott,byear))
                                  - sum(br, CAL_indc(br,pr,cott));
Check_CALIB_SEC("CAP",pr,cott)    = A_KAV.l(pr,cott,byear) *  P_KAV.l(pr,cott,byear)
                                  - CAL_cap(pr,cott);
Check_CALIB_SEC("LAV",pr,cott)    = A_LAV.l(pr,cott,byear) *  P_LAV.l(pr,cott,byear)
                                  - CAL_lab(pr,cott);
Check_CALIB_SEC("LAV",pr,cott)    = A_LAV.l(pr,cott,byear) *  P_LAV.l(pr,cott,byear)
                                  - CAL_lab(pr,cott);

Check_CALIB_SEC("DUT",pr,cott)    = sum(cutt, A_IMPO.l(pr,cott,cutt,byear) * txduto(pr,cott,cutt,byear))
                                  - CAL_dut(pr,cott);

Check_CALIB_SEC("TRM",pr,cott)    = sum(cutt, A_IMPO.l(pr,cott,cutt,byear) * cif_vtwr(pr,cott,cutt,byear)*P_TR.L(byear))
                                  - CAL_vstimp(pr,cott);

Check_CALIB_SEC("IMP",pr,cott)    = sum(cutt, A_IMPO.l(pr,cott,cutt,byear) * P_PWE.l(pr,cutt,byear))
                                  - CAL_imprts(pr,cott);


Check_CALIB_SEC("COMP",pr,cott)   = A_Y.l(pr,cott,byear) * P_Y.l(pr,cott,byear) 
                                  - A_IMP.l(pr,cott,byear) * P_IMP.l(pr,cott,byear) 
                                  - A_XXD.l(pr,cott,byear) * P_XD.l(pr,cott,byear); 

Check_CALIB_SEC("COMP-1",pr,cott) = A_Y.l(pr,cott,byear) * P_Y.l(pr,cott,byear) 
                                  - sum(br, A_IO.l(pr,br,cott,byear)) * P_Y.l(pr,cott,byear)
                                  - A_GC.l(pr,cott,byear) * P_Y.l(pr,cott,byear)
                                  - A_HC.l(pr,cott,byear) * P_Y.l(pr,cott,byear)
                                  - A_INVP.l(pr,cott,byear) * P_Y.l(pr,cott,byear);

Check_CALIB_SEC("COMP-2",pr,cott) = CAL_tax_it(pr,cott)
                                  - sum(br, A_IO.l(pr,br,cott,byear)) * txproducts(pr,cott,byear)
                                  - A_GC.l(pr,cott,byear) * txproducts(pr,cott,byear)
                                  - A_HC.l(pr,cott,byear) * txproducts(pr,cott,byear)
                                  - A_INVP.l(pr,cott,byear) * txproducts(pr,cott,byear);

Check_Income(pr,cott)    = - A_Y.l(pr,cott,byear)
                           + sum(br, A_IO.l(pr,br,cott,byear))
                           + A_GC.l(pr,cott,byear)
                           + A_HC.l(pr,cott,byear)
                           + A_INVP.l(pr,cott,byear);

abort$(smax((pr,cott), abs(Check_Income(pr,cott))) gt 1e-3)
    "Income is not balanced (Check_Income)",  Check_Income;
                                      
*######################################################################################################################*
* Model 
*######################################################################################################################*
* Initialisation of parameters - Generating the parameter values for the run periods
*-----------------------------------------------------
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

* Model parameters
ac(br,er,rtime2)                 = ac(br,er,byear);
betashare(br,er,cr,rtime2)       = betashare(br,er,cr,byear);
deltashare(br,er,rtime2)         = deltashare(br,er,byear);
bhcfv(pr,er,rtime2)              = bhcfv(pr,er,byear);
chcfv(pr,er,rtime2)              = chcfv(pr,er,byear);
decl(pr,er,rtime2)               = decl(pr,er,byear);
stp(er,rtime2)                   = stp(er,byear);
tgcv(pr,er,rtime2)               = tgcv(pr,er,byear);
gctv(er,rtime2)                  = gctv(er,byear);
theta_vst(er,rtime2)             = theta_vst(er,byear);
cif_vtwr(pr,er,cr,rtime2)        = cif_vtwr(pr,er,cr,byear);
vtag(rtime)                      = vtag(byear);
tinvpv(pr,er,rtime2)             = tinvpv(pr,er,byear); 
tcinv(se,er,rtime)               = tcinv(se,er,byear);
txduto(pr,er,cr,rtime2)          = txduto(pr,er,cr,byear);
txfsefa(se,fa,er,rtime2)         = txfsefa(se,fa,er,byear);
txproduction(pr,er,rtime2)       = txproduction(pr,er,byear);
txproducts(pr,er,rtime2)         = txproducts(pr,er,byear);

aer(pr,br,cott,rtime2)           = aer(pr,br,cott,byear);         
bec(pr,br,cott,rtime2)           = bec(pr,br,cott,byear);  
eaf(pr,br,cott,rtime2)           = eaf(pr,br,cott,byear);
bech(pr,cott,rtime2)             = bech(pr,cott,byear);  
eafh(pr,cott,rtime2)             = eafh(pr,cott,byear);  

* Shares in value share forms
theta_dkle(br,er,rtime2)         = theta_dkle(br,er,byear);
theta_dma(br,er,rtime2)          = theta_dma(br,er,byear);
theta_dmpr(pr,br,er,rtime2)      = theta_dmpr(pr,br,er,byear);
theta_dkl(br,er,rtime2)          = theta_dkl(br,er,byear);
theta_deng(br,er,rtime2)         = theta_deng(br,er,byear);
theta_dkav(br,er,rtime2)         = theta_dkav(br,er,byear);
theta_dlav(br,er,rtime2)         = theta_dlav(br,er,byear);
theta_de(br,er,rtime2)           = theta_de(br,er,byear);
theta_dele(br,er,rtime2)         = theta_dele(br,er,byear);
theta_depr(pr,br,er,rtime2)      = theta_depr(pr,br,er,byear);

* Elasticities
sn1(br,er,rtime2)                = sn1(br,er,byear);
sn2(br,er,rtime2)                = sn2(br,er,byear);
sn3(br,er,rtime2)                = sn3(br,er,byear);
sn5(br,er,rtime2)                = sn5(br,er,byear);
sn6(br,er,rtime2)                = sn6(br,er,byear);
sn7(br,er,rtime2)                = sn7(br,er,byear);
sigmax(br,er,rtime2)             = sigmax(br,er,byear);
sigmai(br,er,rtime2)             = sigmai(br,er,byear);

* Prices in base year
p_pdbsr0(pr,er,an)               = P_PDBSR.l(pr,er,byear);
p_kle0(pr,er,an)                 = P_KLE.l(pr,er,byear);
p_ma0(pr,er,an)                  = P_MA.l(pr,er,byear);
p_kav0(pr,er,an)                 = P_KAV.l(pr,er,byear);
p_io0(pr,er,an)                  = P_IO.l(pr,er,byear);
p_kl0(pr,er,an)                  = P_KL.l(pr,er,byear);
p_eng0(pr,er,an)                 = P_ENG.l(pr,er,byear);
p_en0(pr,er,an)                  = P_EN.l(pr,er,byear);
p_ele0(pr,er,an)                 = P_ELE.l(pr,er,byear);
p_lav0(pr,er,an)                 = P_LAV.l(pr,er,byear);
p_pd0(pr,er,an)                  = P_PD.l(pr,er,byear);

p_wpi0(an)                       = P_WPI.l(byear);
p_hc0(pr,er,an)                  = P_HC.l(pr,er,byear);
p_gc0(pr,er,an)                  = P_GC.l(pr,er,byear);
p_pwe0(pr_tra,er,an)             = p_pwe0(pr_tra,er,byear);


* Volumes in base year in value shares form
a_xd0(pr,er,an)                  = A_XD.l(pr,er,byear);
a_kl0(pr,er,an)                  = A_KL.l(pr,er,byear);
a_kle0(pr,er,an)                 = A_KLE.l(pr,er,byear);
a_ma0(pr,er,an)                  = A_MA.l(pr,er,byear);
a_eng0(pr,er,an)                 = A_ENG.l(pr,er,byear);
a_ele0(pr,er,an)                 = A_ELE.l(pr,er,byear);
a_en0(pr,er,an)                  = A_EN.l(pr,er,byear);
a_io0(pr,br,er,an)               = A_IO.l(pr,br,er,byear);
a_kav0(pr,er,an)                 = A_KAV.l(pr,er,byear);
a_lav0(pr,er,an)                 = A_LAV.l(pr,er,byear);
a_hc0(br,er,an)                  = A_HC.l(br,er,byear);

*#######################################################################################################################
*                                                       PRICES
*#######################################################################################################################
*------------------------------------------------- PRODUCTION ----------------------------------------------------------
* Unit cost of production
epd(br,er,an)..
   P_PD(br,er,an)    =E=   P_PDBSR(br,er,an);

* Derived Domestic OUTPUT Prices
esales(pr,er,an)..
   P_XD(pr,er,an)    =E=   P_PD(pr,er,an) + txproduction(pr,er,an)*P_WPI(an)/p_wpi0(an);

* Export output price
esupply(br,er,an)..
   P_PWE(br,er,an)   =E=   P_PD(br,er,an) + txproduction(br,er,an)*P_WPI(an)/p_wpi0(an);
   
*----------------------------------------------------------------------------------------------------------------------*
*                                                   PURCHASE PRICES
*----------------------------------------------------------------------------------------------------------------------*
* Composite Good (Armington function)
epy(pr,er,an)..
   P_Y(pr,er,an)    =E= (((1/ac(pr,er,an))*(deltashare(pr,er,an)**sigmax(pr,er,an)*P_IMP(pr,er,an)**(1-sigmax(pr,er,an))
                         + (1-deltashare(pr,er,an))**(sigmax(pr,er,an))*P_XD(pr,er,an)**(1-sigmax(pr,er,an)))
                         **(1/(1-sigmax(pr,er,an)))));

* Intermediate input purchase price
epio(pr,er,an)..
   P_IO(pr,er,an)    =E=  P_Y(pr,er,an) + txproducts(pr,er,an)*P_WPI(an)/p_wpi0(an);

* Intermediate input price for energy products including enviromental taxes
epenpr(pr,br,er,an)$pren(pr)..
   P_ENPR(pr,br,er,an)  =E=  P_IO(pr,er,an)
                           + TXENV(br,er,an)*bec(pr,br,er,an)*aer(pr,br,er,an)*eaf(pr,br,er,an)
;
                          
* Electricity price
epel(br,er,an)..
   P_ELE(br,er,an)   =E=  P_ENPR(pr_pow,br,er,an);


* Government purchase price
epgc(pr,er,an)..
   P_GC(pr,er,an)    =E=  P_Y(pr,er,an) + txproducts(pr,er,an)*P_WPI(an)/p_wpi0(an);

* Consumer purchase price
ephc(pr,er,an)$(a_hc0(pr,er,an))..
   P_HC(pr,er,an)    =E=  P_Y(pr,er,an) + txproducts(pr,er,an)*P_WPI(an)/p_wpi0(an)
                        + TXENVH(er,an)*bech(pr,er,an)*eafh(pr,er,an);

* Investment purchase price
epinvp(pr,er,an)..
   P_INVP(pr,er,an)  =E=  P_Y(pr,er,an) + txproducts(pr,er,an)*P_WPI(an)/p_wpi0(an);   

*#######################################################################################################################
*                                                   FACTOR MARKETS
*#######################################################################################################################
* LABOUR MARKET
EEQUILABOUR(er,an)..
   SUM(pr,  A_LAV(pr,er,an))   =E=   TotPopulation(er,an)
;

EEPLAV(pr,er,an)..
   P_LAV(pr,er,an) =E= P_L(er,an)
;


* CAPITAL MARKET
EEQUICAPITAL(er,rtime)$(an(rtime))..
   sum(pr, A_KAV(pr,er,rtime)) =E=   sum(pr, A_KAVC(pr,er,rtime-1))
;

EEPKAV(pr,er,an)..
   P_KAV(pr,er,an) =E= P_K(er,an)
;

*#######################################################################################################################
*                                                       PRODUCTION
*#######################################################################################################################
*------------------------------------------------------ TOP LEVEL ------------------------------------------------------
exd(br,er,an)$(a_xd0(br,er,an))..
   P_PDBSR(br,er,an)    =E=
       +[ + p_pdbsr0(br,er,an)*
        ( + theta_dkle(br,er,an)*(P_KLE(br,er,an)/p_kle0(br,er,an))**(1-sn1(br,er,an))/
                                 [tfp(br,er,an)*tfpexo(br,er,an)]**(1-sn1(BR,ER,AN))
          + theta_dma(br,er,an)* (P_MA(br,er,an)/p_ma0(br,er,an))**(1-sn1(br,er,an))/
                                 [tfp(br,er,an)*tfpexo(br,er,an)]**(1-sn1(BR,ER,AN))
        )**(1/(1-sn1(br,er,an)))
        ];

*------------------------------------------------------ 2nd LEVEL ------------------------------------------------------
* 2nd level: Bundle of Capital Labour Energy
epKLE(pr,er,an)$(a_xd0(pr,er,an))..
   P_KLE(pr,er,an)      =E=  p_kle0(pr,er,an)*( theta_dkl(pr,er,an) *(P_KL(pr,er,an) /p_kl0(pr,er,an) )**(1-sn2(pr,er,an))
                                              + theta_deng(pr,er,an)*(P_ENG(pr,er,an)/p_eng0(pr,er,an))**(1-sn2(pr,er,an))
                                              )**(1/(1-sn2(pr,er,an)))
;

* 2nd level: Bundle of Materials
epm(br,er,an)$(a_xd0(br,er,an) and a_ma0(br,er,an))..
   P_MA(br,er,an)       =E=  p_ma0(br,er,an)*( sum(prma, theta_dmpr(prma,br,er,an)*(P_IO(prma,er,an)/p_io0(prma,er,an)
                                             * exp(-tgm(prma,br,er,an)))**(1-sn3(br,er,an))))**(1/(1-sn3(br,er,an)))
;
*------------------------------------------------------ 3rd LEVEL ------------------------------------------------------
* 3rd level: Bundle of Capital and labour
epkl(pr,er,an)$(a_kl0(pr,er,an))..
   P_KL(pr,er,an)       =E= p_kl0(pr,er,an)*( theta_dkav(pr,er,an) * (P_KAV(pr,er,an)/p_kav0(pr,er,an)*exp(-tgk(pr,er,an)))**(1-sn7(pr,er,an))
                                            + theta_dlav(pr,er,an) * (P_LAV(pr,er,an)/p_lav0(pr,er,an)*exp(-tgl(pr,er,an)))**(1-sn7(pr,er,an))
                                            )**(1/(1-sn7(pr,er,an)))
;

*------------------------------------------------------ 4th LEVEL ------------------------------------------------------
* 4. level: Energy products
epe(br,er,an)..
   P_EN(br,er,an) =e= p_en0(br,er,an)*( sum(prfuel, theta_depr(prfuel,br,er,an)*(P_ENPR(prfuel,br,er,an)
                                       /p_io0(prfuel,er,an)*exp(-tge(prfuel,br,er,an)))**(1-sn6(br,er,an))))**(1/(1-sn6(br,er,an)))
;

epeng(pr,er,an)$(a_eng0(pr,er,an)) ..
   P_ENG(pr,er,an) =e= p_eng0(pr,er,an)*(
                 + theta_dele(pr,er,an)*(P_ELE(pr,er,an)/p_ele0(pr,er,an)*exp(-tge(pr_pow,pr,er,an)))**(1-sn5(pr,er,an))
                 + theta_de(pr,er,an) * (P_EN(pr,er,an) /p_en0(pr,er,an)                            )**(1-sn5(pr,er,an))
                                         )**(1/(1-sn5(pr,er,an)))
;

*----------------------------------------------------------------------------------------------------------------------*
*                                                     Market Clearance
*----------------------------------------------------------------------------------------------------------------------*
ekav(pr,er,an)$a_kav0(pr,er,an)..
   A_KAV(pr,er,an) =e= + theta_dkav(pr,er,an) * A_KL(pr,er,an) * (p_kl0(pr,er,an)/p_kav0(pr,er,an))*exp(tgk(pr,er,an)*(sn7(pr,er,an)-1))*
                                               (P_KL(pr,er,an)/P_KAV(pr,er,an)*p_kav0(pr,er,an)/p_kl0(pr,er,an) )**sn7(pr,er,an);

* Labor demand
elav(pr,er,an)$a_lav0(pr,er,an)..
   A_LAV(pr,er,an) =e= + theta_dlav(pr,er,an) * A_KL(pr,er,an) * (p_kl0(pr,er,an)/p_lav0(pr,er,an))*exp(tgl(pr,er,an)*(sn7(pr,er,an)-1))*
                                               (P_KL(pr,er,an)/P_LAV(pr,er,an)* p_lav0(pr,er,an)/p_kl0(pr,er,an))**sn7(pr,er,an);

*----------------------------------------------------------------------------------------------------------------------*
*                                                   DEFINITIONS SUBLEVEL DEMANDS
*----------------------------------------------------------------------------------------------------------------------*
*--------------------------------------------------- STANDARD PRODUCTION -----------------------------------------------
*------------------------------------------------------ TOP LEVEL ------------------------------------------------------
*------------------------------------------------------ 2nd LEVEL ------------------------------------------------------
* 2nd level: Capital Labor Energy bundle 
ekle(pr,er,an)$(a_xd0(pr,er,an))..
   A_KLE(pr,er,an) =e=  +theta_dkle(pr,er,an)*(p_pdbsr0(pr,er,an)/p_kle0(pr,er,an))*A_XD(pr,er,an)*
                                              (P_PDBSR(pr,er,an)/P_KLE(pr,er,an)*p_kle0(pr,er,an)/p_pdbsr0(pr,er,an))
                                               **sn1(pr,er,an) *[tfp(pr,er,an)*tfpexo(pr,er,an)]**(sn1(pr,er,an)-1)
;

* 2nd level: Material inputs 
ema(pr,er,an)$(a_ma0(pr,er,an))..
   A_MA(pr,er,an) =e= + theta_dma(pr,er,an)*(p_pdbsr0(pr,er,an)/p_ma0(pr,er,an))*A_XD(pr,er,an)*
                              (P_PDBSR(pr,er,an)/P_MA(pr,er,an)*p_ma0(pr,er,an)/p_pdbsr0(pr,er,an))**sn1(pr,er,an)
                            * [tfp(pr,er,an)*tfpexo(pr,er,an)]**(sn1(pr,er,an)-1)
;

*------------------------------------------------------ 3rd LEVEL ------------------------------------------------------
* 3rd level: Bundle of Capital and labor
ekl(pr,er,an)$(a_kl0(pr,er,an))..
   A_KL(pr,er,an)  =e= + theta_dkl(pr,er,an)*A_KLE(pr,er,an)*(p_kle0(pr,er,an)/p_kl0(pr,er,an))*
                                            (P_KLE(PR,ER,AN)/P_KL(pr,er,an)*p_kl0(pr,er,an)/p_kle0(pr,er,an))**sn2(pr,er,an)
;


* 3rd level: Energy bundle
eeng(pr,er,an)$(a_xd0(pr,er,an) and theta_deng(pr,er,an))..
   A_ENG(pr,er,an) =e=  theta_deng(pr,er,an)*A_KLE(pr,er,an)*(p_kle0(pr,er,an)/p_eng0(pr,er,an))
                                           *(P_KLE(pr,er,an)/ P_ENG(pr,er,an)*p_eng0(pr,er,an)/p_kle0(pr,er,an) )**sn2(pr,er,an)
;

*------------------------------------------------------ 4th LEVEL ------------------------------------------------------
* 4th level. electricity demand
eenl(pr,er,an)..
   A_ELE(pr,er,an) =e=  theta_dele(pr,er,an)*(p_eng0(pr,er,an)/p_ele0(pr,er,an))*A_ENG(pr,er,an)
                        *(P_ENG(pr,er,an)/P_ELE(pr,er,an)*p_ele0(pr,er,an)/p_eng0(pr,er,an))**sn5(pr,er,an)
                        *exp((tge(pr_pow,pr,er,an))*(sn5(pr,er,an)-1))
;

een(pr,er,an)..
   A_EN(pr,er,an) =e=  theta_de(pr,er,an)*(p_eng0(pr,er,an)/p_en0(pr,er,an))*A_ENG(pr,er,an)
                       *(P_ENG(pr,er,an)/P_EN(pr,er,an)*p_en0(pr,er,an)/p_eng0(pr,er,an))**sn5(pr,er,an)
;


eiovtot(pr,br,er,an)..
   A_IO(pr,br,er,an) =e= ( theta_dmpr(pr,br,er,an)*(p_ma0(br,er,an)/p_io0(pr,er,an))*A_MA(br,er,an)*(P_MA(br,er,an)/P_IO(pr,er,an)
                                *p_io0(pr,er,an) /p_ma0(br,er,an))**sn3(br,er,an)* exp(tgm(pr,br,er,an)*(sn3(br,er,an)-1)))
                        $(a_ma0(br,er,an) and prma(pr) and a_xd0(br,er,an))
                       + ( theta_depr(pr,br,er,an)*(p_en0(br,er,an)/p_io0(pr,er,an))*A_EN(br,er,an)*(P_EN(br,er,an)/P_ENPR(pr,br,er,an)
                                *p_io0(pr,er,an) /p_en0(br,er,an))**sn6(br,er,an)* exp((tge(pr,br,er,an))*(sn6(br,er,an)-1)))
                        $(a_en0(br,er,an) and prfuel(pr) and a_xd0(br,er,an))
                       + (a_io0(pr,br,er,an)* A_ELE(br,er,an)/a_ele0(br,er,an))
                        $(a_ele0(br,er,an) and pr_pow(pr) and a_xd0(br,er,an))
;

*#######################################################################################################################
*                                                       INVESTMENT
*#######################################################################################################################
* Investment Demand by commodity
einvpv(pr,er,an)$(tinvpv(pr,er,an))..
*   A_INVP(pr,er,an) =E= tinvpv(pr,er,an) * sum(se, V_INV(se,er,an))/P_INVP(pr,er,an);
   A_INVP(pr,er,an) =E= tinvpv(pr,er,an) * exo_investments(er,an)/P_INVP(pr,er,an);


* Investment by institutional sector
einv(se,er,an)..
   V_INV(se,er,an) =E=   + [tcinv(se,er,an)* sum(pr, P_INVP(pr,er,an)*A_INVP(pr,er,an))]$(sameas(se,"H"))
                         + [tcinv(se,er,an)* sum(pr, P_INVP(pr,er,an)*A_INVP(pr,er,an))]$(sameas(se,"F"))
                         + [tcinv(se,er,an)* sum(pr, P_INVP(pr,er,an)*A_INVP(pr,er,an))]$(sameas(se,"G"))
                         + [tcinv(se,er,an)* sum(pr, P_INVP(pr,er,an)*A_INVP(pr,er,an))]$(sameas(se,"W"))
;

* Law of motion for capital
ekavc(pr,er,rtime)$(an(rtime))..
   A_KAVC(pr,er,rtime) =E=   (1-decl(pr,er,rtime))**(ttime1(rtime)-ttime1(rtime-1))*A_KAV(pr,er,rtime)
                           + ((1-(1-decl(pr,er,rtime))**(ttime1(rtime)-ttime1(rtime-1)))/decl(pr,er,rtime))
                           * A_INVP(pr,er,rtime)
;

*#######################################################################################################################
*                                                FINAL CONSUMPTION
*#######################################################################################################################
* Household Disposable Income
eydisp(er,an)..
   V_YDISP(er,an) =E=   sum(fa,V_FSEFA("H",fa,er,an))
                      + sum(sr,V_FSESE("H",sr,er,an))
                      - sum(sr,V_FSESE(sr,"H",er,an));

* Private Consumption
etsave(er,an)..
   V_HCDTOT(er,an) =E= sum(pr, P_HC(pr,er,an)*chcfv(pr,er,an))
                       + (stp(er,an)/(RLTLR(er,an)*RLTLRWORLD(an)))
                       * (V_YDISP(er,an) - sum(pr, P_HC(pr,er,an)*chcfv(pr,er,an)));

* Public Consumption
egcv(pr,er,an)..
   A_GC(pr,er,an) =E=  gctv(er,an)*tgcv(pr,er,an);


* Household Demand for Consumption
eHCV(pr,er,an)..
   A_HC(pr,er,an)   =e=   chcfv(pr,er,an) + bhcfv(pr,er,an)/P_HC(pr,er,an)*
                          (V_HCDTOT(er,an) - sum(br, P_HC(br,er,an)*chcfv(br,er,an)));

*#######################################################################################################################
*                                                  TOTAL PRODUCTION
*#######################################################################################################################
* Total production in volume
exdtot(br,er,an)..
   A_XD(br,er,an) =E= A_XXD(br,er,an) + sum(cr, A_EXPO(br,er,cr,an)) + A_YVTWR(br,er,an);

* Total Domestic Demand
eydem(pr,er,an)..
   A_Y(pr,er,an) =E= SUM(br, A_IO(pr,br,er,an)) + A_INVP(pr,er,an) + A_HC(pr,er,an) + A_GC(pr,er,an);

* Armington Allocation
eabsor(pr,er,an)..
   A_XXD(pr,er,an) =E= [(A_Y(pr,er,an)*ac(pr,er,an)**(sigmax(pr,er,an)-1)
                           *(1-deltashare(pr,er,an))**(sigmax(pr,er,an))
                           *(P_Y(pr,er,an)/P_XD(pr,er,an))**(sigmax(pr,er,an)))];


*#######################################################################################################################
*                                                INTERNATIONAL TRADE
*#######################################################################################################################
* EXTERNAL TRADE
* EXPORT and IMPORT PRICES
epwxo(pr,cs,cr,an)..
   P_IMPO(pr,cs,cr,an) =E= P_PWE(pr,cr,an) + cif_vtwr(pr,cs,cr,an)*P_TR(an)
                                           + txduto(pr,cs,cr,an)*P_WPI(an)/p_wpi0(an)
;

epimpl(pr,er,an)..
   P_IMP(pr,er,an) =E= (sum(cr,  betashare(pr,er,cr,an)**(sigmai(pr,er,an))*(P_IMPO(pr,er,cr,an))**(1-sigmai(pr,er,an))))
                                 **(1/(1-sigmai(pr,er,an)))
;

* EXPORT and IMPORT QUANTITIES
eexpol(br,cr,cs,an)..
   A_EXPO(br,cr,cs,an) =E=  A_IMPO(br,cs,cr,an);


eimpl(br,er,an)..
   A_IMP(br,er,an)    =E=  A_Y(br,er,an)*ac(br,er,an)**(sigmax(br,er,an)-1)
                          *deltashare(br,er,an)**sigmax(br,er,an)*(P_Y(br,er,an)/P_IMP(br,er,an))**sigmax(br,er,an)
;

eimpo(br,cr,cs,an)..
   A_IMPO(br,cr,cs,an) =E= A_IMP(br,cr,an) *(P_IMP(br,cr,an)/P_IMPO(br,cr,cs,an)*betashare(br,cr,cs,an))**(sigmai(br,cr,an));

*#######################################################################################################################
*                                             INTERNATIONAL TRANSPORT SERVICE
*#######################################################################################################################
zpf_VST(an)..
      sum(cr, theta_vst(cr,an)*(P_PWE(pr_tra,cr,an)/p_pwe0(pr_tra,cr,an)))  =G=   P_TR(an);

mkt_VST(an)..
     vtag(an)*A_YVST(an) =G=  sum((cr,cs,br), A_EXPO(br,cr,cs,an)*cif_vtwr(br,cs,cr,an));

def_YVTWR(pr,er,an)$(pr_tra(pr))..
     A_YVTWR(pr_tra,er,an) =E=   A_YVST(an)*vtag(an)*theta_vst(er,an);

*#######################################################################################################################
*                                                       TRANSFERS
*#######################################################################################################################
* Government tax income
efgrbtotl(gv,pr,er,an)..
   V_FGRB(gv,pr,er,an) =E=
* duties
    +[ +sum(cr, txduto(pr,er,cr,an) * P_WPI(an)/p_wpi0(an) * A_IMPO(pr,er,cr,an))   ]$sameas(gv,"DUT")
* taxes less subsidies on production
    +[  txproduction(pr,er,an)*P_WPI(an)/p_wpi0(an)*A_XD(pr,er,an)                  ]$sameas(gv,"SUB")
* taxes less subsidies on products
    +[  txproducts(pr,er,an)*P_WPI(an)/p_wpi0(an) *(sum(br, A_IO(pr,br,er,an)) 
                         + A_GC(pr,er,an) + A_HC(pr,er,an) + A_INVP(pr,er,an))      ]$sameas(gv,"IT")
* enviromental taxes
    +[  TXENV(pr,er,an)* A_CO2EMM_BR(pr,er,an)
      + TXENVH(er,an)*bech(pr,er,an)*eafh(pr,er,an)*A_HC(pr,er,an)                  ]$sameas(gv,"ENV")
;

* TRANSFERS between SECTORS
efsese(se,sr,er,an)..
   V_FSESE(se,sr,er,an) =E= 0;

* TRANSFERS between FACTORS and SECTORS
evatot(fa,pr,er,an)..
   V_VA(fa,pr,er,an)    =E=  [P_LAV(pr,er,an)*A_LAV(pr,er,an)        ]$(sameas(fa,"lab"))
                           + [P_KAV(pr,er,an)*A_KAV(pr,er,an)        ]$(sameas(fa,"cap"))
;

efsefa(se,fa,er,an)$(txfsefa(se,fa,er,an))..
   V_FSEFA(se,fa,er,an)   =E= sum(br, txfsefa(se,fa,er,an) * V_VA(fa,br,er,an));

* EPILOGUE
efcftot(se,er,an)..
   V_FC(se,er,an)         =E= [ V_HCDTOT(er,an)                                        ]$(sameas(se,"H"))
                            + [ 0.                                                     ]$(sameas(se,"F"))
                            + [ sum(pr,     P_GC(pr,er,an)*A_GC(pr,er,an) )            ]$(sameas(se,"G"))
                            + [ sum(pr,     P_PWE(pr,er,an)*sum(cr, A_EXPO(pr,er,cr,an)))
                            +   sum(pr_tra, P_PWE(pr_tra,er,an)*A_YVTWR(pr_tra,er,an)) ]$(sameas(se,"W"))
;

esavel(se,er,an)..
   V_SAVE(se,er,an)       =E= [ V_YDISP(er,an) - V_HCDTOT(er,an)        ]$(sameas(se,"H"))
                            + [ sum(fa, V_FSEFA(se,fa,er,an))
                              + sum(sr, V_FSESE(se,sr,er,an) - V_FSESE(sr,se,er,an) )
                              - V_FC(se,er,an)                          ]$(sameas(se,"F"))
                            + [ sum((gv,br), V_FGRB(gv,br,er,an))
                              + sum(fa, V_FSEFA(se,fa,er,an) )
                              + sum(sr, V_FSESE(se,sr,er,an) - V_FSESE(sr,se,er,an))
                              - V_FC(se,er,an)                          ]$(sameas(se,"G"))
* For the world savings are defined as the trade balance
                            + [ sum(br, P_IMP(br,er,an) * A_IMP(br,er,an))
                              - sum(br, V_FGRB("DUT",br,er,an))
                              + sum(fa, V_FSEFA(se,fa,er,an) )
                              + sum(sr, V_FSESE(se,sr,er,an) - V_FSESE(sr,se,er,an))
                              - V_FC(se,er,an)                          ]$(sameas(se,"W"))
;

esurpl(se,er,an)..
   V_SURPL(se,er,an)      =E=   V_SAVE(se,er,an) - V_INV(se,er,an);


*######################################################################################################################*
*                                                   EMISSIONS
*######################################################################################################################*
* Emissions - Firms
eemmbr(br,er,an)..
  A_CO2EMM_BR(br,er,an)    =E= sum(prfuel, bec(prfuel,br,er,an)*aer(prfuel,br,er,an)*eaf(prfuel,br,er,an) * A_IO(prfuel,br,er,an));

* Emissions - Households
eemmhous(er,an)..
  A_CO2EMM_HOUS(er,an)     =E= sum(prfuel, bech(prfuel,er,an)*eafh(prfuel,er,an)*A_HC(prfuel,er,an));

* Carbon price - Firms
etxenv(br,er,an)..
  TXENV(br,er,an)          =E= txem(br,er,an)*P_WPI(an)/p_wpi0(an);

* Carbon price - Household
etxenvh(er,an)..
  TXENVH(er,an)            =E= txemh(er,an)*P_WPI(an)/p_wpi0(an);

*######################################################################################################################*
*                                                       CLOSURES                                                       *
*######################################################################################################################*
* Macro Closure
eWPI(an)..  sum((se,er), V_SAVE(se,er,an)) =e=  sum((se,er), V_INV(se,er,an));

*######################################################################################################################*
*  MODEL DEFINITION
*######################################################################################################################*
MODEL OPEN_GEM
/
epd.p_pd
esales.p_xd
esupply.p_pwe
epy.p_y
epio.p_io
epenpr.p_enpr
epel.p_ele
epgc.p_gc
ephc.p_hc
epinvp.p_invp
EEQUILABOUR.P_L
EEPLAV.P_LAV
EEQUICAPITAL.P_K
EEPKAV.P_KAV
exd.p_pdbsr
epkle.p_kle
epm.p_ma
epkl.p_kl
epe.p_en
epeng.p_eng
ekav.A_KAV
elav.A_LAV
ekle.a_kle
ema.a_ma
ekl.a_kl
eeng.a_eng
eenl.a_ele
een.a_en
eiovtot.a_io
einvpv.a_invp
einv.v_inv
ekavc.a_kavc
eydisp.v_ydisp
etsave.v_hcdtot
egcv.a_gc
eHCV.A_HC
exdtot.a_xd
eydem.a_y
eabsor.a_xxd
epwxo.p_impo
epimpl.p_imp
eexpol.a_expo
eimpl.a_imp
eimpo.a_impo
zpf_vst.a_yvst
mkt_vst.p_tr
def_yvtwr.a_yvtwr
efgrbtotl.v_fgrb
efsese.v_fsese
evatot.v_va
efsefa.v_fsefa
efcftot.v_fc
esavel.v_save
esurpl.v_surpl
eemmbr.A_CO2EMM_BR
eemmhous.A_CO2EMM_HOUS
etxenv.TXENV 
etxenvh.TXENVH
ewpi.rltlrworld
/
;

* Cases without value shares
P_KL.fx(pr,cott,rtime)   $(a_kl0(pr,cott,rtime) = 0) = 1;
p_kl0(pr,cott,rtime)     $(a_kl0(pr,cott,rtime) = 0) = 1;

A_KL.fx(pr,cott,rtime)   $(a_kl0(pr,cott,rtime) = 0) = 0;
A_YVTWR.fx(pr,cott,rtime)$(not pr_tra(pr))           = 0;
A_INVP.fx(pr,cott,rtime) $(tinvpv(pr,cott,rtime)= 0) = 0;
A_LAV.fx(pr,cott,rtime)  $(a_lav0(pr,cott,rtime)= 0) = 0;
A_KAV.fx(pr,cott,rtime)  $(a_kav0(pr,cott,rtime)= 0) = 0;
A_KAVC.fx(pr,cott,rtime) $(rtime.val = 2016)         = A_KAVC.l(pr,cott,rtime);

RLTLR.fx(cott,rtime) = RLTLR.l(cott,byear);
P_WPI.fx(rtime)      = 1;


V_FSEFA.fx(se,fa,cott,rtime)$(txfsefa(se,fa,cott,rtime) = 0) = 0;
V_VA.fx("LAB",br,cott,rtime)$(a_lav0(br,cott,rtime)= 0) = 0;
V_VA.fx("CAP",br,cott,rtime)$(a_kav0(br,cott,rtime)= 0) = 0;

* Numeraire
P_WPI.fx(rtime)             $(rtime.val ge byear.val)
                            = 1.0 ;
P_IO.fx("SRV01","ROW",rtime)$(rtime.val ge byear.val)
                            = P_WPI.l(rtime) * P_IO.l("SRV01","ROW",byear);

*######################################################################################################################*
*                                           SCENARIO ASSUMPTIONS                                                       *
*######################################################################################################################*
* Technical progress
tgk(pr,er,an)                    = 0;
tgl(pr,er,an)                    = 0;
tge(prfuel,pr,er,an)             = 0;
tgm(pr,br,er,an)                 = 0;
tfp(pr,er,an)                    = 1;
tfpexo(pr,er,an)                 = 1;

* Population
TotPopulation(cott,an)           = TotPopulation(cott,byear);

* Investments
exo_investments(cott,an)         = exo_investments(cott,byear);

* Governement Expenditures
gctv(cott,an)                    = gctv(cott,byear);

* Environmental Taxes
txem(br,cott,an)                 = 0;
txemh(cott,an)                   = 0;

*###############################################################################
*                                 SIMULATION
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

* Fixing lagged value for next period
A_KAVC.FX(PR,ER,RTIME-1)$(ord(RTIME) EQ CURYEARP-INITYEAR+2)     = A_KAVC.L(pr,er,rtime-1);

* Starting Values for Next Period Run
A_YVTWR.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)     =A_YVTWR.l(pr,cott,rtime-1);
A_XD.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =A_XD.l(pr,cott,rtime-1);
A_XXD.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =A_XXD.l(pr,cott,rtime-1);
A_EXPO.l(pr,cott,cutt,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2) =A_EXPO.l(pr,cott,cutt,rtime-1);
A_IMPO.l(pr,cott,cutt,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2) =A_IMPO.l(pr,cott,cutt,rtime-1);
A_IMP.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =A_IMP.l(pr,cott,rtime-1);
A_Y.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)         =A_Y.l(pr,cott,rtime-1);
A_IO.l(pr,br,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)     =A_IO.l(pr,br,cott,rtime-1);
A_HC.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =A_HC.l(pr,cott,rtime-1);
A_GC.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =A_GC.l(pr,cott,rtime-1);
A_INVP.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)      =A_INVP.l(pr,cott,rtime-1);
A_LAV.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =A_LAV.l(pr,cott,rtime-1);
A_KAV.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =A_KAV.l(pr,cott,rtime-1);
A_KAVC.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)      =A_KAVC.l(pr,cott,rtime-1);
A_EN.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =A_EN.l(pr,cott,rtime-1);
A_ENG.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =A_ENG.l(pr,cott,rtime-1);
A_ELE.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =A_ELE.l(pr,cott,rtime-1);
A_MA.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =A_MA.l(pr,cott,rtime-1);
A_KL.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =A_KL.l(pr,cott,rtime-1);
A_KLE.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =A_KLE.l(pr,cott,rtime-1);

*Prices
P_PD.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =P_PD.l(pr,cott,rtime-1);
P_XD.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =P_XD.l(pr,cott,rtime-1);
P_PDBSR.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)     =P_PDBSR.l(pr,cott,rtime-1);
P_PWE.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =P_PWE.l(pr,cott,rtime-1);
P_IMPO.l(pr,cott,cutt,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2) =P_IMPO.l(pr,cott,cutt,rtime-1);
P_IMP.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =P_IMP.l(pr,cott,rtime-1);
P_TR.l(rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)                =P_TR.l(rtime-1);
P_Y.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)         =P_Y.l(pr,cott,rtime-1);
P_IO.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =P_IO.l(pr,cott,rtime-1);
P_HC.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =P_HC.l(pr,cott,rtime-1);
P_GC.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =P_GC.l(pr,cott,rtime-1);
P_INVP.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)      =P_INVP.l(pr,cott,rtime-1);
P_LAV.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =P_LAV.l(pr,cott,rtime-1);
P_L.l(cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)            =P_L.l(cott,rtime-1);
P_KAV.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =P_KAV.l(pr,cott,rtime-1);
P_K.l(cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)            =P_K.l(cott,rtime-1);
P_ENPR.l(pr,br,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)   =P_ENPR.l(pr,br,cott,rtime-1);
P_ELE.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =P_ELE.l(pr,cott,rtime-1);
P_EN.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =P_EN.l(pr,cott,rtime-1);
P_ENG.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =P_ENG.l(pr,cott,rtime-1);
P_MA.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =P_MA.l(pr,cott,rtime-1);
P_KL.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =P_KL.l(pr,cott,rtime-1);
P_KLE.l(pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =P_KLE.l(pr,cott,rtime-1);
P_WPI.l(rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)               =P_WPI.l(rtime-1);

*Values
V_FGRB.l(gv,pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)   =V_FGRB.l(gv,pr,cott,rtime-1);
V_FSEFA.l(se,fa,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)  =V_FSEFA.l(se,fa,cott,rtime-1);
V_FSESE.l(se,sr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)  =V_FSESE.l(se,sr,cott,rtime-1);
V_FC.l(se,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =V_FC.l(se,cott,rtime-1);
V_YDISP.l(cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)        =V_YDISP.l(cott,rtime-1);
V_VA.l(fa,pr,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)     =V_VA.l(fa,pr,cott,rtime-1);
V_SAVE.l(se,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)      =V_SAVE.l(se,cott,rtime-1);
V_INV.l(se,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =V_INV.l(se,cott,rtime-1);
V_SURPL.l(se,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)     =V_SURPL.l(se,cott,rtime-1);
V_HCDTOT.l(cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =V_HCDTOT.l(cott,rtime-1);

*Rates-Shares-Taxes
RLTLR.l(cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)          =RLTLR.l(cott,rtime-1);
RLTLRWORLD.l(rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)          =RLTLRWORLD.l(rtime-1); 
TXENV.l(br,cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)       =TXENV.l(br,cott,rtime-1);
TXENVH.l(cott,rtime)$(ord(RTIME) eQ CURyearP-INITyear+2)         =TXENVH.l(cott,rtime-1); 

an(rtime)=no;
);

an(rtime)$(ord(rtime)     ge 2
           and ord(rtime) le curyearp-1-inityear+2) = yes;


*###############################################################################
*                                 REPORT
*###############################################################################
Parameters
REPORT_GDPV(cott,stime)           GDP at market prices   - b$ 2017
REPORT_GCVTOT(cott,stime)         Government Consumption - b$ 2017
REPORT_INVVCO(cott,stime)         Investment             - b$ 2017
REPORT_RHCDTOTV(cott,stime)       Household Consumption  - b$ 2017
REPORT_PRODUCTION(pr,cott,stime)  Sectoral Production    - b$ 2017
;

REPORT_GDPV(cott,an) = sum(br, P_HC.L(br,cott,byear) * A_HC.l(br,cott,an)
                             + P_GC.l(br,cott,byear) * A_GC.L(br,cott,an)
                             + P_INVP.l(br,cott,byear)*A_INVP.L(br,cott,an)
                             + P_PWE.L(br,cott,byear)*A_YVTWR.L(br,cott,an)
                             + P_PWE.l(br,cott,byear)*SUM(cutt, A_EXPO.l(br,cott,cutt,an)))
                     - sum((br,cutt), (P_PWE.l(br,cutt,an)+cif_vtwr(br,cott,cutt,an)*P_TR.L(byear))
                                      *A_IMPO.L(br,cott,cutt,an));

REPORT_GCVTOT(cott,an)   = sum(br, P_GC.L(br,cott,byear)*A_GC.L(br,cott,an));
REPORT_INVVCO(cott,an)   = sum(br, P_INVP.L(br,cott,byear)*A_INVP.L(br,cott,an));
REPORT_RHCDTOTV(cott,an) = sum(br, P_HC.L(br,cott,byear)*A_HC.l(br,cott,an));

REPORT_PRODUCTION(pr,cott,an) = P_PD.l(pr,cott,byear) * A_XD.l(pr,cott,an);



