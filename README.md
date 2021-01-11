# evolverneck

This repository contains the essential code necessary to verify that the analytic solution found in the paper [*Metastability of lipid necks via geometric triality*](https://arxiv.org/abs/2101.01161) is a locally stable Willmore surface.

Being able to run locally [Surface Evolver](http://facstaff.susqu.edu/brakke/evolver/evolver.html) is a requirement.

This repo contains:

`one_ellipse_one_plane` contains an editable Evolver file where geometrically parameter can be set.

`oeop.fe` contains roughly the same code, but it is optimized for bash script calls. 

`runevolver` bash script that calls _oeop.fe_ upon changing some desired parameters (in the current version, _DIST_ is changed, see below).

`generic_functions.el` is a small library of ad-hoc functions, useful to optimize the geometric flow and to save geometric data in Mathematica-friendly format.

In `one_ellipse_one_plane`, the parameter _DIST_ determines the distance between the sphere center and the horizontal plane. The steric interaction of the plane and of the sphere with the surface are implemented as inequality constraints (see _constraint 1_ and _constraint 2_). 

To run the script do simply:

> evolver one_ellipse_one_plane

and then from the evolver interface run one of the predefined evolution commands. I suggest _namo3_. 
