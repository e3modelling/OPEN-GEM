*######################################################################################################################*
*                                           SCENARIO ASSUMPTIONS                                                       *
*######################################################################################################################*
* Additional to the Baseline Assumptions
Parameters
change_theta_dmpr(pr,br,cott,stime)     Change value share in the production structure
;

* Change in the value share of primary plastics to include chemical recycling in the production structure
change_theta_dmpr("IND09","IND12","DEU",rtime)$(rtime.val > 2025) =  - 0.5 * theta_dmpr("IND09","IND12","DEU",rtime);
change_theta_dmpr("IND36","IND12","DEU",rtime)$(rtime.val > 2025) =  + 0.5 * theta_dmpr("IND09","IND12","DEU",rtime);

* Apply the change to the model parameter
theta_dmpr(pr,br,cott,rtime)$(change_theta_dmpr(pr,br,cott,rtime))
                            = theta_dmpr(pr,br,cott,rtime)
                            + change_theta_dmpr(pr,br,cott,rtime);

* Tax on OIl Production
txproduction("ENE03",er,rtime)$(rtime.val > 2025)
                              = txproduction("ENE03",er,rtime)
                              + 0.5;