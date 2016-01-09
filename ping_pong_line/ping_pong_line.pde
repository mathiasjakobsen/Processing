void setup()
{
  size(200, 200);
  strokeWeight(2.3);
  frameRate(200);
}


int x = 0;
int y = 100;
int vej = 0;

void draw()
{
  
 if (vej == 0)
 {
   point(x,y);
   x++;
 }
 
 if (vej == 1)
 {
   point(x,y);
   x--;
 }
 
 
 if (x > 200)
 {
   vej = 1;
   stroke(250, 0, 0);
 }
 
 if (x < 0)
 {
   vej = 0;
   stroke(0);
 }
 
}
