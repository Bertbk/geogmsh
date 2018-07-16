SetFactory("OpenCASCADE");

DefineConstant[
 h = {0.02, Min 0.01, Max 10, Step 0.01, Name "Geo/1Element mesh size"} 
];

//Radius of the submarin "cylinder"
R = 0.046;

Mesh.CharacteristicLengthMax=h;
Mesh.CharacteristicLengthMin=h;

//Body
Point(1) = {0,0,0,h};
Point(2) = {0.046, 0.046,0,h};
Point(3) = {0.86, 0.046,0,h};
Point(4) = {0.93, 0.035,0,h};
Point(5) = {1, 0,0,h};

Line(1) = {2,3};
Spline(2)= {3:5};
Circle(3)= {R, 0, 0, R, Pi/2, Pi};

Extrude { {1,0,0}, {0,0,0}, Pi} { Line{1,2,3} ;}
Extrude { {1,0,0}, {0,0,0}, -Pi} { Line{1,2,3} ;}

// Sail
Point(100) = {0.255, 0, 0,h};
Point(101) = {0.38, 0, 0,h};
Point(102) = {0.27, R/4,0,h};
Point(103) = {0.35, R/5,0,h};

Point(104) = {0.27, -R/4,0,h};
Point(105) = {0.35, -R/5,0,h};

Spline(100) = {100, 102, 103, 101};
Spline(101) = {100, 104, 105, 101};

Line Loop(100) = {100,-101};
Surface(100) = {100};
Extrude {0,0,0.1}{Surface{100};}

// Stern Planes ("Wings in the back")
Point(200) = {0.91, 0.085, 0,h};
Point(201) = {0.95, 0.085, 0,h};
Point(202) = {0.915, 0.085, R/6,h};
Point(203) = {0.94, 0.085, R/8,h};
Point(204) = {0.915, 0.085, -R/6,h};
Point(205) = {0.94, 0.085, -R/8,h};

Spline(200) = {200, 202, 203, 201};
Spline(201) = {200, 204, 205, 201};

Translate {0, -2*0.085, 0} { Duplicata{ Line{200,201}; } }
Translate {0, -0.085, 0} { Duplicata{ Line{200,201}; } }
Dilate { {0.95, 0, 0 } , { 1.5,1,1 }} { Line{204,205}; }
Curve Loop(210) = {200,201};
Curve Loop(211) = {202,203};
Curve Loop(212) = {204,205};
ThruSections(220) = {210,212, 211};

// Rudder ("sail in the back")
Point(300) = {0.91, 0, 0.084, h};
Point(301) = {0.95, 0, 0.084, h};
Point(302) = {0.915, R/6, 0.084,h};
Point(303) = {0.94, R/8, 0.084,h};
Point(304) = {0.915, -R/6, 0.084,h};
Point(305) = {0.94, -R/8, 0.084,h};
Spline(300) = {300, 302, 303, 301};
Spline(301) = {300, 304, 305, 301};

Translate {0, 0, -0.085} { Duplicata{ Line{300,301}; } }
Dilate { {0.95, 0, 0 } , { 1.5,1,1 }} { Line{302,303}; }
Curve Loop(310) = {300,301};
Curve Loop(311) = {302,303};
ThruSections(320) = {310,311};
//Cleaning
Delete {Volume{1, 320, 220};}
// Symmetrize
Symmetry {0, 0, 1} { Duplicata{ Surface{108:110}; } }

//Fragmentations
BooleanFragments{Surface{1:6};Delete;}{Surface{100:114};Delete;}

Delete{Surface{100, 116, 118, 119, 120, 122, 123, 124, 125, 127, 130, 132, 134, 135, 137, 138, 140:145, 147:156, 158, 159, 160, 161, 162, 163, 165:171};}

SurfSub[] = {3, 4,6, 103, 106, 107, 110, 114, 115, 117, 121, 126, 128, 129, 131, 133, 136, 139, 146, 157, 164};


// Volume
surfl = newreg ; Surface Loop(surfl) = {SurfSub[]};
Volume(1) = {surfl};
BooleanFragments{Volume{1};Delete;}{Surface{:};Delete;}
// boolean fragments to remove possible dupplicate surface due to surface loop

// Physical entities
Physical Volume(1) = {1}; // Inside Submarine
SurfSub[] = Boundary{Volume{1};};
Physical Surface(11) = {SurfSub[] }; // Boundary of Submarine
