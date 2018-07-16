DefineConstant[
  k = {10, Min 1, Max 100, Step 0.1, Name 'Input/00Wavenumber'},
  nlambda = {10, Min 1, Max 100, Step 1, Name 'Input/01Nb. points per wavelength'},
  lambda = {2*Pi/k, Name 'Output/02Wavelength', ReadOnly 1, AutoCheck 0},
  h = {lambda/nlambda, Name 'Output/03Mesh size', ReadOnly 1, AutoCheck 0},
  L={1, Min 0.1, Max 100, Step 0.1, Name "Geo/00Length (dilation factor)"},
  ABC = {0, Choices{0="No", 1 ="Yes"}, Name "FEM/0ABC"},
  ABC_X = {0.8, Min 0.6, Max 5, Step 0.1, Name "FEM/1ABC X-rad", ReadOnly !ABC, AutoCheck 1},
  ABC_Z = {0.3, Min 0.1, Max 1.5, Step 0.01, Name "FEM/1ABC Z-rad", ReadOnly !ABC, AutoCheck 1},
  SYMMETRIC = {0, Choices{0="No", 1 ="Yes"}, Name "FEM/2Symmetric only"}
];

Include "submarine.geo";


//ABC
If(ABC)
  Sphere(500) = {L/2, 0, 0, ABC_Z};
  Dilate {{L/2, 0, 0}, {ABC_X/ABC_Z, 1, 1}} { Volume{500}; }
  BooleanFragments{Volume{1};}{Volume{500};Delete;}
  Physical Volume(2) = {2}; // Outide Submarine
  Physical Surface(12) = {139}; // ABC
EndIf


If(SYMMETRIC)
  Box(500) = {L/2 - ABC_X - ABC_Z, -1.5*ABC_X,0,  L + 2*ABC_X, 3*ABC_X, 2*ABC_Z};
  Delete Physicals;
  If(ABC)
     BooleanDifference{Volume{1:2}; Delete;}{Volume{500};Delete;}
     SurfSub[] = Boundary{Volume{1};};
     SurfSub[] -=140;
     Physical Volume(1) = {1}; //submarine
     Physical Volume(2) = {2}; // outside submarine
     Physical Surface(11) = {SurfSub[] }; // Boundary of Submarine
     Physical Surface(12) = {147}; // ABC
     Physical Surface(101) = {140}; // Symetric Plane (inside Submarine)
     Physical Surface(102) = {148}; // Symetric Plane (outside  Submarine)
  Else
     BooleanDifference{Volume{1}; Delete;}{Volume{500};Delete;}
     SurfSub[] = Boundary{Volume{1};};
     SurfSub[] -=2;
     Physical Volume(1) = {1}; //submarine
     Physical Surface(11) = {SurfSub[] }; // Boundary of Submarine
     Physical Surface(101) = {2}; // Symetric Plane (inside Submarine)    
  EndIf
EndIf


If(L != 1)
  Dilate { {1,1,1}, L } { Point{:}; Line{:}; Surface{:}; Volume{:};} 
EndIf
