*######################################################################################################################*
* Databases
*######################################################################################################################*
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


