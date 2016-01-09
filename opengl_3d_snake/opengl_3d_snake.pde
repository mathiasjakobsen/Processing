float f;
float xx;
float yy;
float g;

void setup()
{
  size(950, 650, OPENGL);
  frameRate(50); 
}

void draw()
{
  translate(f,xx+200,yy-200);
  xx++;
  yy++;
  f = sq(0.1*xx)+20*sin(6*xx);
  ellipse(20, 20,7,7);
}

