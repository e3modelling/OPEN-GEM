*######################################################################################################################*
* Initial values for the next period and fixing lagged values
*######################################################################################################################*
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

