void setup()
{
  size(1280, 130);
 frameRate(50); 
}

float a = 0.0;
float inc = 25;
float i = 0;

void draw()
{
  background(100);
  ellipse(i, 50+sin(a)*40.0,7,7);
  a = a + inc;
  i++;
  
  if(i >= 1000)
  {
    background(100);
    i = 0;
  }
}


/* 

float f;
float xx;

void setup ()
{
  size(500,500);
  translate(0,150); 
}

void draw()
{
  strokeWeight(2);
  xx++;
  f = sq(0.03*xx)+15*sin(6*xx);
  point(xx,f);
}

*/
