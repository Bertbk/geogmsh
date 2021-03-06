SetFactory("OpenCASCADE");

//Teapot !
// height = 1

DefineConstant[
  h = {0.06, Min 0.01, Max 1, Step 0.01, Name 'Output/03Mesh size', ReadOnly 1, AutoCheck 0}
];

Mesh.CharacteristicLengthMin = h;
Mesh.CharacteristicLengthMax = h;

Vscale = 159.;//do not change please
//Top of the teapot
ptopest = newp; Point(ptopest)={0, 0, 159/Vscale, h}; // TOP
pTop[]= {};
cpt = -1;
cpt++; pTop[cpt]=newp; Point(pTop[cpt])={10/Vscale, 0,  159/Vscale, h};
cpt++; pTop[cpt]=newp; Point(pTop[cpt])={22/Vscale, 0., 154./Vscale, h} ;
cpt++; pTop[cpt]=newp; Point(pTop[cpt])={15/Vscale, 0., 138./Vscale , h} ;
cpt++; pTop[cpt]=newp; Point(pTop[cpt])={55/Vscale, 0., 137/Vscale , h} ;
cpt++; pTop[cpt]=newp; Point(pTop[cpt])={64/Vscale, 0., 122/Vscale , h} ;

ltop = newreg; Line(ltop) = {ptopest,pTop[0]};
lbsplineTop = newreg; Spline(lbsplineTop) = {pTop[]};

// Body of the teapot
pctlr_1 = newp; Point(pctlr_1) = {60/Vscale, 0., 87/Vscale , h};
pctlr_2 = newp; Point(pctlr_2) = {80/Vscale, 0., 10/Vscale , h};
pbottom = newp; Point(pbottom) = {64/Vscale, 0., 0, h} ;
pbottom_center = newp; Point(pbottom_center) = {0, 0., 0, h} ;

lbsplineBody = newreg; Spline(lbsplineBody) = {6, pctlr_1, pctlr_2, pbottom};
lb_center = newreg; Spline(lb_center) = {pbottom, pbottom_center};
Extrude { {0,0,1}, {0,0,0}, Pi} { Line{ltop, lbsplineTop, lbsplineBody, lb_center} ;}
Extrude { {0,0,1}, {0,0,0}, -Pi} { Line{ltop, lbsplineTop, lbsplineBody, lb_center} ;}
Surface Loop(1) = {1:8};
Volume(1) = {1};
//Must remove dupplicates line/surface
BooleanFragments{Volume{1};Delete;}{Surface{1:16};Delete;}


// Bec
//The wire guide for extrusion
pcb[] = {};
cpt = -1;
//For Spline
cpt ++; pcb[cpt] = newp; Point(pcb[cpt]) = {0, 60/Vscale,  67/Vscale ,  h/2};
cpt ++; pcb[cpt] = newp; Point(pcb[cpt]) = {0, 80/Vscale,  74/Vscale ,  h/2};
cpt ++; pcb[cpt] = newp; Point(pcb[cpt]) = {0, 95/Vscale,  98/Vscale , h/2};
cpt ++; pcb[cpt] = newp; Point(pcb[cpt]) = {0, 130/Vscale, 120/Vscale , h/2};
lbspline = newreg; Spline(lbspline) = {pcb[]};
// Get the disk ON the body
//The circle to extrude, arround pcb[0]
R = 10/Vscale;
ndisk = newreg; Disk(ndisk) = {0, 60/Vscale, 67/Vscale , R};
Rotate { {1,0,0}, {0, 60/Vscale, 67/Vscale }, Pi/2} { Surface{ndisk};}
mywire = newreg; Wire(mywire) = {lbspline};
Extrude { Surface{ndisk}; } Using Wire { mywire }
BooleanFragments{Volume{2};Delete;}{Surface{18:21};Delete;}


//Anse
tor = 3; Torus(tor)={0,-90/Vscale,67/Vscale , 35/Vscale, R};
Rotate { {0,1,0}, {0, -60/Vscale, 67/Vscale }, Pi/2} { Volume{tor};}
Rotate { {1,0,0}, {0, -90/Vscale, 67/Vscale }, Pi/2} { Volume{tor};} //this is to avoid an aditionnal surface

// Difference
BooleanDifference{Volume{2};Delete;}{Volume{1};}
BooleanDifference{Volume{3};Delete;}{Volume{1};}
BooleanFragments{Volume{1};Delete;}{Volume{2:3}; Delete;}

//Physical Surface
Physical Volume(1) = {1:3}; // Volume of Teapot
Physical Surface(10) = {1:7,9,12:14}; //Exterior surface of Teapot
