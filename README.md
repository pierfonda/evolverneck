# evolverneck

This repository contains the essential code necessary to verify that the analytic solution found in the paper [*Metastability of lipid necks via geometric triality*](https://arxiv.org/abs/2101.01161) is a locally stable Willmore surface.

Being able to run locally [Surface Evolver](http://facstaff.susqu.edu/brakke/evolver/evolver.html) (SE) is a requirement.

This repository contains:

`one_ellipse_one_plane` the main SE script file.

`oeop.fe` SE file optimized for bash calls. 

`runevolver` bash script that calls _oeop.fe_ upon changing some desired parameters (as of now: _DIST_).

`generic_functions.el` small library of ad-hoc functions, useful to optimize the geometric flow and to save geometric data in Mathematica-friendly format.

# Usage 

In `one_ellipse_one_plane`, the parameter _DIST_ determines the distance between the sphere center and the horizontal plane. The steric interaction of the plane and of the sphere with the surface are implemented as inequality constraints (see _constraint 1_ and _constraint 2_). 

To run the script do simply:

> evolver one_ellipse_one_plane

and then from the evolver interface run one of the predefined evolution commands. I suggest _namo3_. 
