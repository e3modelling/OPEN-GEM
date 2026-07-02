*######################################################################################################################*
* Model 
*######################################################################################################################*
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
   A_INVP(pr,er,an) =E= tinvpv(pr,er,an) * investments(er,an)/P_INVP(pr,er,an);


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
   P_IMP(pr,er,an) =E= [(sum(cr,  betashare(pr,er,cr,an)**(sigmai(pr,er,an))*(P_IMPO(pr,er,cr,an))**(1-sigmai(pr,er,an))))
                                  **(1/(1-sigmai(pr,er,an)))]$(sum(cr, betashare(pr,er,cr,an)) ne 0)
                                                          + 1$(sum(cr, betashare(pr,er,cr,an)) eq 0)
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
P_WPI.fx(byear)      = 1;

V_FSEFA.fx(se,fa,cott,rtime)$(txfsefa(se,fa,cott,rtime) = 0) = 0;
V_VA.fx("LAB",br,cott,rtime)$(a_lav0(br,cott,rtime)= 0) = 0;
V_VA.fx("CAP",br,cott,rtime)$(a_kav0(br,cott,rtime)= 0) = 0;

* Numeraire
P_WPI.fx(rtime)             $(rtime.val gt byear.val)
                            = 1.0 ;
P_IO.fx("SRV01","ROW",rtime)$(rtime.val ge byear.val)
                            = P_WPI.l(rtime) * P_IO.l("SRV01","ROW",byear);
