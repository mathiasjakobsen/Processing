void setup () {
  size(280, 480);
  background(140);

}

void draw () {
 fill(255);
  textSize(14);
 float s = ((200/60)*second());
 float m = ((200/60)*minute());
 float h = ((200/24)*hour ());
 float dato = ((200/30)*day());
 float maned = ((200/12)*month());
 float ar = year();
 
 
 rect(40, 40, 60, 200);
 line(40, 40+s, 100, 40+s);
 
 rect(110, 40, 60, 200);
 line(110, 40+m, 170, 40+m);
 
 rect(180, 40, 60, 200);
 line(180, 40+h, 240, 40+h);
 
 fill(204, 102, 0);
text("Sekunder", 42, 260);
text("Minutter", 114, 260);
text("Timer", 192, 260);
fill(255);

  rect(40, 300, 200, 20);
  line(40+dato, 300, 40+dato, 320);
  
  fill(204, 102, 0);
  text(day(), 40+dato+4, 315);

  text(second(), 62, 40+s-4);
  text(minute(), 132, 40+m-4);




fill(255);


rect(40, 340, 200, 20);
  line(40+maned, 340, 40+maned, 360);
 fill(204, 102, 0);
  text(month(), 40+dato+4, 355);


textSize(80);
text(year(), 40, 450);

}

