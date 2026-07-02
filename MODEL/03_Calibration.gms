*######################################################################################################################*
* OPEN-GEM Model Calibration
*######################################################################################################################*
Sets
pren(pr)   Energy Products /ENE01*ENE05/
prfuel(pr) Fossil Fuels    /ENE01,ENE03,ENE04/
$if %sw_CHM_REC% == "0"     prma(pr)   Materials       /AGR01,ENE02,IND01*IND35,TRA01,SRV01*SRV02/
$if %sw_CHM_REC% == "1"     prma(pr)   Materials       /AGR01,ENE02,IND01*IND36,TRA01,SRV01*SRV02/
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
investments    (cott,stime)                        Exogenous Investments   
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
P_IMP.l(pr,cott,byear) = [(sum(cutt, P_IMPO.l(pr,cott,cutt,byear) * A_IMPO.l(pr,cott,cutt,byear))
                         /  A_IMP.l(pr,cott,byear))]$(A_IMP.l(pr,cott,byear))
                         + 1                        $(A_IMP.l(pr,cott,byear) = 0)
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


investments(cott,byear)   = sum(br, CAL_inv_v(br,cott));

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

average_emf(prfuel,cott)$(sum(br, CAL_etf(prfuel,br,cott)))
                          = sum(br, CAL_mtf(prfuel,br,cott))
                          /sum(br, CAL_etf(prfuel,br,cott));

sectoral_emf(prfuel,br,cott)$(CAL_etf(prfuel,br,cott))
                            = CAL_mtf(prfuel,br,cott)
                            / CAL_etf(prfuel,br,cott);

average_emfh(prfuel,cott)$CAL_etp(prfuel,cott)
                         = CAL_mtp(prfuel,cott)
                         / CAL_etp(prfuel,cott);

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
eaf_adjust(prfuel,cott)$(sum(br, CAL_mtf(prfuel,br,cott)))
                       = sum(br, CAL_mtf(prfuel,br,cott))
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
                                      