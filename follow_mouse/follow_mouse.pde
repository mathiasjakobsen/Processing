void setup() 
{
  size (600,400);
  background(140);
  frameRate(900);
}
  int a = 1;
  int b = 1;
  
void draw() 
{
  
  if(mouseX>a)
  {
   
    a += random(-1,5);
  }
  else if(mouseX<a)
  {
    a += random(-5,1);
  }
  if(mouseY>a)
  {
    b += random(-1,5);
  }
  else if(mouseY<a)
  {
    b += random(-5,1);
  }
  
  background(140);

  
  a += random(-3,5);
  b += random(-3,5);
  
  ellipse(a,b,30,30);
  
}
