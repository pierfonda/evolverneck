PROCEDURE gg (real sc)
{
DO g >> "temp_energy.tmp" WHILE scale>sc;
}

PROCEDURE ggm (real sc, integer maxint)
{
local inx;
inx:=1;
DO {g >> "temp_energy.tmp"; inx:=inx+1;} WHILE scale>sc AND inx<maxint;
}

PROCEDURE rr (real lm)
{ 
foreach edge ee where ee.length*ee.vertex[1].z>lm or ee.length*ee.vertex[2].z>lm do refine ee;
}

PROCEDURE set_density (real density_value)
{ 
foreach facet ff do { set ff density density_value}; 
}

PROCEDURE dgg (real dd)
{
DO
	{
	oldte:=total_energy;
	g;
	dte:=(total_energy-oldte)/oldte;
	} 
WHILE 
	abs(dte)>dd;
}

PROCEDURE dg ()
{
	oldte:=total_energy;
	g;
	dte:=(total_energy-oldte)/oldte;
	printf "%f\n",dte;
	} 

PROCEDURE uV (integer int)
{
	{u;V} int;
	} 


PROCEDURE rb (real lm)
{ 
foreach edge ee where ee on_boundary 1 and ee.length>lm do refine ee
}


PROCEDURE rH (real HM)
{ 
foreach edge ee where ee.vertex[1].sqcurve > HM or ee.vertex[2].sqcurve > HM do refine ee
}

PROCEDURE rHM (real Hm,real HM)
{ 
foreach edge ee where (ee.vertex[1].sqcurve > Hm and ee.vertex[1].sqcurve < HM) or (ee.vertex[2].sqcurve > Hm and ee.vertex[2].sqcurve < HM) do refine ee
}

PROCEDURE infovertex (integer int)
{
	avarea:=0;
	foreach vertex[int].facet ff do avarea:=avarea+ff.area/vertex[int].valence;
	printf "Vertex %d has coordinates (%2.2f,%2.2f,%2.2f)\n",int,vertex[int].x,vertex[int].y,vertex[int].z;
	printf "It has mean curvature %2.3f, while has squared mean curvature %2.3f.\n",vertex[int].mean_curvature,vertex[int].sqcurve;
	printf "It is linked to %d triangles, with average area of %2.3f.\n",vertex[int].valence,avarea;
} 

PROCEDURE project_on_ellipse_above (real AX, real AY, real AZ, real dist, real Zlim)
{
	foreach vertex vv where vv.z>Zlim do {
		local lambda;
		local lx,ly,lz;
		lambda:=sqrt((vv.x/AX)^2+(vv.y/AY)^2+((vv.z-AZ-dist)/AZ)^2);
		vv.x:=vv.x/lambda;
		vv.y:=vv.y/lambda;
		vv.z:=vv.z/lambda+(AZ+dist)*(1-1/lambda);
	}
} 

PROCEDURE project_on_ellipse_below (real AX, real AY, real AZ, real dist, real Zlim)
{
	foreach vertex vv where vv.z<Zlim do {
		local lambda;
		local lx,ly,lz;
		lambda:=sqrt((vv.x/AX)^2+(vv.y/AY)^2+((vv.z-AZ-dist)/AZ)^2);
		vv.x:=vv.x/lambda;
		vv.y:=vv.y/lambda;
		vv.z:=vv.z/lambda-(AZ+dist)*(1-1/lambda);
	}
} 

PROCEDURE project_on_ellipse_lambda (real AX, real AY, real AZ, real dist, real lambdalim)
{
	foreach vertex vv  do {
		local lambda;
		local lx,ly,lz;
		lambda:=sqrt((vv.x/AX)^2+(vv.y/AY)^2+((vv.z-AZ-dist)/AZ)^2);
		if(lambda<lambdalim) then
			{
			vv.x:=vv.x/lambda;
			vv.y:=vv.y/lambda;
			vv.z:=vv.z/lambda+(AZ+dist)*(1-1/lambda);
			}
		else printf "%f\n", lambda;
	}
} 


FUNCTION real tae (real xu, real yu, real zu, real xd, real yd, real zd, real xt, real yt, real zt)	
{
	local trarea; 
	local l1,l2,l3;
	local ss;
	l1:=sqrt((xu-xd)^2+(yu-yd)^2+(zu-zd)^2);
	l2:=sqrt((xt-xd)^2+(yt-yd)^2+(zt-zd)^2);
	l3:=sqrt((xt-xu)^2+(yt-yu)^2+(zt-zu)^2);
	//printf "Edge length: %f %f %f",l1,l2,l3;
	ss:=(l1+l2+l3)/2;
	trarea:=sqrt(ss*(ss-l1)*(ss-l2)*(ss-l3));
	return trarea;
}

PROCEDURE sumcurv ()
{
	sqcurv:=0;
	curvsq:=0;
	totarea:=0;
	foreach vertex vv do {
			vvarea:=0;
			foreach vv.facet ff do vvarea:=vvarea+tae(ff.vertex[1].x,ff.vertex[1].y,ff.vertex[1].z,ff.vertex[2].x,ff.vertex[2].y,ff.vertex[2].z,ff.vertex[3].x,ff.vertex[3].y,ff.vertex[3].z)/3;
			sqcurv:=sqcurv+vvarea*vv.sqcurve;
			//printf "(%f,%f) at %d\n",vv.sqcurve,vvarea*vv.sqcurve, vv.id;
			curvsq:=curvsq+vvarea*vv.mean_curvature^2;
			totarea:=totarea+vvarea;
			};
	printf "(Willmore 1: %4.4f, Willmore 2: %4.4f, Total energy: %4.4f, Total area: %4.4f )\n",sqcurv,curvsq,TOTAL_ENERGY,totarea;
}

PROCEDURE sumcurvpi ()
{
	sqcurv:=0;
	curvsq:=0;
	totarea:=0;
	foreach vertex vv do {
			vvarea:=0;
			foreach vv.facet ff do vvarea:=vvarea+tae(ff.vertex[1].x,ff.vertex[1].y,ff.vertex[1].z,ff.vertex[2].x,ff.vertex[2].y,ff.vertex[2].z,ff.vertex[3].x,ff.vertex[3].y,ff.vertex[3].z)/3;
			sqcurv:=sqcurv+vvarea*vv.sqcurve;
			//printf "(%f,%f) at %d\n",vv.sqcurve,vvarea*vv.sqcurve, vv.id;
			curvsq:=curvsq+vvarea*vv.mean_curvature^2;
			totarea:=totarea+vvarea;
			};
	printf "%4.4f\t%4.4f\t%4.4f\t%4.4f\n",sqcurv/3.141592,curvsq/3.141592,TOTAL_ENERGY/3.141592,totarea;
}

PROCEDURE sumcurvn ()
{
	sqcurv:=0;
	curvsq:=0;
	totarea:=0;
	foreach vertex vv do {
			vvarea:=0;
			foreach vv.facet ff do vvarea:=vvarea+tae(ff.vertex[1].x,ff.vertex[1].y,ff.vertex[1].z,ff.vertex[2].x,ff.vertex[2].y,ff.vertex[2].z,ff.vertex[3].x,ff.vertex[3].y,ff.vertex[3].z)/3;
			sqcurv:=sqcurv+vvarea*vv.sqcurve;
			//printf "(%f,%f) at %d\n",vv.sqcurve,vvarea*vv.sqcurve, vv.id;
			curvsq:=curvsq+vvarea*vv.mean_curvature^2;
			totarea:=totarea+vvarea;
			};
	printf "%4.4f\t%4.4f\t%4.4f\t%4.4f\n",sqcurv,curvsq,TOTAL_ENERGY,totarea;
}

PROCEDURE zast() 
{
	zs:=0;
	foreach vertex vv do if vv.z>zs then zs:=vv.z; 
	//printf "%f\n",zs;
}


// Give colors to face so one can visually track their evolution and refinement
PROCEDURE colorz() { 
	set facets color black where id % 16 == 0 ;
	set facets color blue where id % 16 == 1;
	set facets color green where id % 16 == 2 ;
	set facets color cyan where id % 16 == 3 ;
	set facets color red where id % 16 == 4 ;
	set facets color magenta where id % 16 == 5 ;
	set facets color brown where id % 16 == 6 ;
	set facets color lightgray where id % 16 == 7 ;
	set facets color darkgray where id % 16 == 8 ;
	set facets color lightblue where id % 16 == 9 ;
	set facets color lightgreen where id % 16 == 10 ;
	set facets color lightcyan where id % 16 == 11 ;
	set facets color lightred where id % 16 == 12 ;
	set facets color lightmagenta where id % 16 == 13 ;
	set facets color yellow where id % 16 == 14 ;
	set facets color white where id % 16 == 15 ;
	}


// Undo the previous command
PROCEDURE uncolorz(){ set facets color lightgray;}
