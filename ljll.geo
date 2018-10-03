SetFactory("OpenCASCADE");

DefineConstant[
  DIM = {2, Choices {2="2",3="3"}, Name "Dim"},
  h = {10, Min 0.01, Max 1, Name "h"}
];

Mesh.CharacteristicLengthMin = h;
Mesh.CharacteristicLengthMax = h;

start = 1;
Point(newp)= {88.34637514384349, - 320.74798619102415, 0, h};
Point(newp)= {34.32566168009206, - 320.18527042577676, 0, h};
Point(newp)= {24.196777905638665,- 370.26697353279627, 0, h};
Point(newp)= {132.23820483314154,- 371.3924050632911, 0, h};
Point(newp)= {182.3199079401611, - 99.60069044879171, 0, h};
Point(newp)= {129.42462600690448,- 99.60069044879171, 0, h};
end = start + 5;

For ii In {start:end-1}
  Line(ii) = {ii,ii+1};
EndFor
Line(end) = {end,start};
Line Loop(1) = {start:end};
Plane Surface(1) = {1};

start = end+1;
Point(newp)= {205.39125431530493,- 429.3521288837744, 0, h};
Point(newp)= {315.12082853855003,- 429.3521288837744, 0, h};
Point(newp)= {323.5615650172612, - 378.70771001150746, 0, h};
Point(newp)= {267.8527042577675, - 378.14499424626007, 0, h};
Point(newp)= {306.11737629459145,- 156.9976985040276, 0, h};
Point(newp)= {252.65937859608744,- 157.56041426927501, 0, h};
end = start + 5;

For ii In {start:end-1}
  Line(ii) = {ii,ii+1};
EndFor
Line(end) = {end,start};
Line Loop(2) = {start:end};
Plane Surface(2) = {2};

start = end+1;
Point(newp)= {281.9205983889528, - 370.26697353279627, 0, h};
Point(newp)= {392.7756041426927, - 370.26697353279627, 0, h};
Point(newp)= {401.7790563866513, - 320.18527042577676, 0, h};
Point(newp)= {344.3820483314154, - 320.18527042577676, 0, h};
Point(newp)= {383.77215189873414,- 99.03797468354429, 0, h};
Point(newp)= {330.87686996547757,- 99.03797468354429, 0, h};
end = start + 5;

For ii In {start:end-1}
  Line(ii) = {ii,ii+1};
EndFor
Line(end) = {end,start};
Line Loop(3) = {start:end};
Plane Surface(3) = {3};


start = end +1;
p1 = newp; Point(p1)= {185.69620253164555,- 156.9976985040276, 0, h};
p2 = newp; Point(p2)= {150.2451093210587, - 356.76179516685846, 0, h};
p3 = newp; Point(p3)= {140.6789413118527, - 378.70771001150746, 0, h};
p4 = newp; Point(p4)= {117.60759493670885,- 385.46029919447636, 0, h};


p5 = newp; Point(p5)= {94.53624856156502, - 381.5212888377445, 0, h};
p6 = newp; Point(p6)= {87.22094361334867, - 424.28768699654773, 0, h};
p7 = newp; Point(p7)= {126.04833141542001,- 432.7284234752589, 0, h};
p8 = newp; Point(p8)= {177.8181818181818, - 412.4706559263521, 0, h};
p9 = newp; Point(p9)= {203.1403912543153, - 357.32451093210585, 0, h};
p10 = newp; Point(p10)= {239.15420023014957,- 156.9976985040276, 0, h};

Line(newl) = {p1,p2};
Spline(newl) = {p2,p3,p4,p5};
Line(newl) = {p5,p6};
Spline(newl) = {p6,p7,p8,p9};
Line(newl) = {p9,p10};
Line(newl) = {p10,p1};
end = start+5;

Line Loop(4) = {start:end};
Surface(4)=  {4};

/*Point(newp)= {279.1070195627158, - 55.70886075949367, 0, h};
Point(newp)= {226.21173762945912,- 2.250863060989643, 0, h};
Point(newp)= {173.31645569620252,- 54.583429228998845, 0, h};
Point(newp)= {226.77445339470654,- 109.16685845799769, 0, h};
*/

r = (279.1070195627158 - 173.31645569620252)/2 - 5;
xc =(279.1070195627158 + 173.3164556962025)/2;
yc = -30 + (- 2.250863060989643- 109.16685845799769)/2;
If(DIM == 2)
  Disk(5) = {xc,yc,0,r};
EndIf

If(DIM == 3)  
  Sphere(5) = {xc,yc,-r,r};
  
Extrude {10,10,-r} {
    Surface{1:4};
  }
EndIf

