# Evolverneck

This repository contains the essential code necessary to verify that the analytic solution found in the paper [*Metastability of lipid necks via geometric triality*](https://arxiv.org/abs/2101.01161) is a locally stable Willmore surface.

Being able to run locally [Surface Evolver](http://facstaff.susqu.edu/brakke/evolver/evolver.html) (SE) is a requirement.

This repository contains:

`one_ellipse_one_plane` the main SE script file.

`oeop.fe` SE file optimized for bash calls. 

`runevolver` bash script that calls _oeop.fe_ upon changing some desired parameters (as of now: _DIST_).

`generic_functions.el` small library of ad-hoc functions, useful to optimize the geometric flow and to save geometric data in Mathematica-friendly format.

## Usage 

Edit the parameter _DIST_ in `one_ellipse_one_plane` to the desired value, then run the main script

> evolver one_ellipse_one_plane

and then, from the SE interface, execute one of the predefined evolution commands (currently,  _namo3_ works best).
