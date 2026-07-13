* Chemical Recycling
Scalar CHM_REC_PROD Production Level;
CHM_REC_PROD = 10**(-6);

* Demand
opengem_sec_io("IND36","IND12",cott)   =  CHM_REC_PROD;

* Production Structure
* Capital
opengem_sec_io("01-CAP","IND36",cott)  = 0.57 * CHM_REC_PROD;
* Labour
opengem_sec_io("02-LOWS","IND36",cott) = 0.20 * 0.21 * CHM_REC_PROD;
opengem_sec_io("02-TECH","IND36",cott) = 0.20 * 0.21 * CHM_REC_PROD;
opengem_sec_io("02-OMGR","IND36",cott) = 0.20 * 0.21 * CHM_REC_PROD;
opengem_sec_io("02-SHOP","IND36",cott) = 0.20 * 0.21 * CHM_REC_PROD;
opengem_sec_io("02-CLRK","IND36",cott) = 0.20 * 0.21 * CHM_REC_PROD;
* Equipment
opengem_sec_io("IND33","IND36",cott)   = 0.14  * CHM_REC_PROD;
* Fuels
opengem_sec_io("ENE04","IND36",cott)   = 0.005 * CHM_REC_PROD;
* Electricity
opengem_sec_io("ENE05","IND36",cott)   = 0.04  * CHM_REC_PROD;
* Services
opengem_sec_io("SRV01","IND36",cott)   = 0.035 * CHM_REC_PROD;



