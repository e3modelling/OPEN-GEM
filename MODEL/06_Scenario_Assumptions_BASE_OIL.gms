*######################################################################################################################*
*                                           SCENARIO ASSUMPTIONS                                                       *
*######################################################################################################################*
* Additional to the Baseline Assumptions

* Tax on OIl Production
txproduction("ENE03",er,rtime)$(rtime.val > 2025)
                              = txproduction("ENE03",er,rtime)
                              + 0.5;