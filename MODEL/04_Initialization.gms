*######################################################################################################################*
* Initialisation of parameters - Generating the parameter values for the run periods
*-----------------------------------------------------
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

