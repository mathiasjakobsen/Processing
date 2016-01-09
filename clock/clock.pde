void setup() {
  size(450, 450);
  background(49, 128, 147);
}
void draw () {
  
//Clock center, radius and diameter
  int xcenter = width / 2;
  int ycenter = width / 2;
  int rclock = min(width,height) / 4;
  float dclock = rclock * 2;
  float rseconds = rclock * 0.8;
  float rminutes = rclock * 0.7;
  float rhours = rclock * 0.4;
  
//Clock edge and background
  stroke(50, 58, 59);
  strokeWeight(4);
  ellipse(xcenter, ycenter, dclock, dclock);
  fill(215, 227, 226);
  
//Mapping 
  float s = map(second(),0,60,0,TWO_PI) - HALF_PI;
  float m = map(minute()+norm(second(),0,60),0,60,0,TWO_PI) - HALF_PI;
  float h = map(hour()+norm(minute(),0,60),0,24,0,TWO_PI) - HALF_PI;
  
//Clock arms 
  stroke(50, 58, 59);
  strokeWeight(2);
  line(xcenter, ycenter, xcenter + cos(s) * rseconds, ycenter + sin(s) * rseconds);
  line(xcenter, ycenter, xcenter + cos(m) * rminutes, ycenter + sin(m) * rminutes);
  line(xcenter, ycenter, xcenter + cos(h) * rhours, ycenter + sin(h) * rhours);
  
//minute indicators
  stroke(50, 58, 59);
  beginShape(POINTS);
  for (int a = 0; a < 360; a += 360/60 ) {
    float xpoint = xcenter + cos(radians(a)) * rclock * 0.9;
    float ypoint = ycenter + sin(radians(a)) * rclock * 0.9;
    vertex(xpoint, ypoint);
  }
  endShape();

}
/* Radianer - PROCESSING REGNER I RADIANER.
1 radian er den vinkel, der er når radius er lig buelængden i denne vinkel.
Vi ved at omkredsen af en cirkel er PI*r*2, i så fald må det maximale antal r på en hel cirkelomkreds være
PI*r*2/r, altså PI *2.
Der går altså 2PI, og ikke 360 grader på en cirkel... derfor går der også en halv pi på en kvart cirkel.


Vi bruger x og y som vores nulpunkt, og arbejder altså ud derfra med sinus+y som y-koordinat og cosinus+x som x-koordinat.
Vi ganger vores sinus og cosinus værdi med visernes længde for at give det rigtige koordinat.

DET ER VIGTIGT at bruge int til a i minuite indicators.. for vi vil kun have lige værdier!! ikke alle mulige tal!
*/
