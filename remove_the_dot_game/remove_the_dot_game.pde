PImage bg;
void setup()
{
  size(799, 470);
  strokeWeight(1.2);
  stroke(80);
  fill(70);
  bg = loadImage("gray.png");
}

float random_radius = random(20,300);     // Opretter en tilfældig radius, til en cirkel som skal tegnes
float cirkel_random_x = random(20,450);   // Opretter en tilfældig x koordinat til cirklens startpunkt (IKKE centrum)
float cirkel_random_y = random(20,450);   // Opretter en tilfældig y koordinat til cirklens startpunkt (IKKE centrum)
int hit_point = 0;
int missed_point = 0;

void draw()
{
  background(bg);
  for (int i = 0; i < 10; i = i+1) {
  
  if ( sqrt( sq(mouseX - cirkel_random_x) + sq(mouseY - cirkel_random_y) ) <= random_radius / 2 )  // Hvis afstanden mellem cirklens centrum og musens positions på skærmen, er inden for cirklen, så ..
  {
    if (mousePressed && (mouseButton == LEFT))
    {
      background(bg);
      random_radius = random(20,300);     // Opretter en tilfældig radius, til en cirkel som skal tegnes
      cirkel_random_x = random(20,450);   // Opretter en tilfældig x koordinat til cirklens startpunkt (IKKE centrum)
      cirkel_random_y = random(20,450);   // Opretter en tilfældig y koordinat til cirklens startpunkt (IKKE centrum)
      hit_point ++;
    }
  }
  
  ellipse(cirkel_random_x, cirkel_random_y, random_radius, random_radius);  // Tegner cirkelen vha. de givende variabler
  
  
  
    textSize(30);
    text("Hits", 678, 50);

  
  textSize(80);
  if (hit_point < 10)
  {
    text(hit_point, 680, 120);
  }
  else
  {
    text(hit_point, 660, 120);
  }
  
  }
  println(missed_point);
}


