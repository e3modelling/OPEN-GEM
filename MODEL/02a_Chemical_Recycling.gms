* Chemical Recycling
Scalar CHM_REC_PROD Production Level;
CHM_REC_PROD = 10**(-6);

* Demand
opengem_sec_io("IND36","IND12",cott)   =  CHM_REC_PROD;

* Production Structure
opengem_sec_io("01-CAP","IND36",cott)  = 0.25 * CHM_REC_PROD;
opengem_sec_io("02-LOWS","IND36",cott) = 0.20 * 0.10 * CHM_REC_PROD;
opengem_sec_io("02-TECH","IND36",cott) = 0.20 * 0.10 * CHM_REC_PROD;
opengem_sec_io("02-OMGR","IND36",cott) = 0.20 * 0.10 * CHM_REC_PROD;
opengem_sec_io("02-SHOP","IND36",cott) = 0.20 * 0.10 * CHM_REC_PROD;
opengem_sec_io("02-CLRK","IND36",cott) = 0.20 * 0.10 * CHM_REC_PROD;
opengem_sec_io("IND14","IND36",cott)   = 0.18 * CHM_REC_PROD;
opengem_sec_io("IND09","IND36",cott)   = 0.10 * CHM_REC_PROD;
opengem_sec_io("ENE05","IND36",cott)   = 0.08 * CHM_REC_PROD;
opengem_sec_io("ENE04","IND36",cott)   = 0.06 * CHM_REC_PROD;
opengem_sec_io("TRA01","IND36",cott)   = 0.07 * CHM_REC_PROD;
opengem_sec_io("SRV01","IND36",cott)   = 0.08 * CHM_REC_PROD;
opengem_sec_io("IND33","IND36",cott)   = 0.03 * CHM_REC_PROD;
opengem_sec_io("IND31","IND36",cott)   = 0.03 * CHM_REC_PROD;
opengem_sec_io("SRV02","IND36",cott)   = 0.01 * CHM_REC_PROD;
opengem_sec_io("IND17","IND36",cott)   = 0.01 * CHM_REC_PROD;


