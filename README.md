# rules_of_CIL_nanofibers
README - Analysis and simulation code for Rules of contact inhibition of locomotion for cells on suspended nanofibers

This code and data corresponds with the paper "Rules of contact inhibition of locomotion for cells on suspended nanofibers" 
by Jugroop Singh, Aldwin Pagulayan, Brian A. Camley, and Amrinder Nain. Simulation code and analysis code primarily by Brian Camley. This code originally archived at https://doi.org/10.5281/zenodo.4584099 and reproduced here for convenience.

There are two folders: "experiment" and "simulation." 

experiment:
Each of the scripts in experiment should be run individually in order to generate the figures, as well as associated p-values, etc.

simulation:
The code in simulation can be run using the "run_everything.m" script. This should recreate the relevant simulation plots and data. 
Note that by default this will load pre-run simulation data and show the results. It is also possible to re-run all of the simulations
by setting the rerun flag = true at the beginning of the code.

This code has been tested with Matlab R2020b.

This code uses elements of "beeswarm.m" Ian Stevenson, CC-BY 2019, modified by Brian Camley to allow beeswarm plots with varying mark types, etc.

None of this code is up to software engineering standards, and it should not be trusted to generalize; it is provided for transparency, and
because it is better for science for us to share our ugly code. If there is any confusion/issue, please contact Brian Camley. 
