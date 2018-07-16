DefineConstant[
  k = {10, Min 1, Max 100, Step 0.1, Name 'Input/00Wavenumber'},
  nlambda = {10, Min 1, Max 100, Step 1, Name 'Input/01Nb. points per wavelength'},
  lambda = {2*Pi/k, Name 'Output/02Wavelength', ReadOnly 1, AutoCheck 0},
  h = {lambda/nlambda, Name 'Output/03Mesh size', ReadOnly 1, AutoCheck 0}
];

DefineConstant[
  ABC = {0, Choices{0="No", 1="Yes"}, Name "FEM/0ABC"},
  ABC_R = {1.4, Min 1, Max 3, Step 0.1, Name "FEM/0ABC Radius", ReadOnly !ABC},
  INTERNAL_VOLUME = {1, Choices {0="No", 1="Yes"}, Name "FEM/1Teapot Volume"}
];

Include "teapot.geo";

If(ABC)
  Sphere(1000) = {0,0,0.5, ABC_R};
  BooleanFragments{Volume{1:3};}{Volume{1000};Delete;}
  Physical Volume(2) = {4}; // Outide Teapot
  Physical Surface(11) = {15};
EndIf

If(!INTERNAL_VOLUME)
  Delete{Volume{1:3};}
EndIf
