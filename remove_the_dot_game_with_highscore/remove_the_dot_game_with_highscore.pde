PImage bg;                                          // Reserver plads til baggrundsbilled
float cirkel_r = random(20,300);                    // Opretter en tilfældig radius, til en cirkel som skal tegnes
float cirkel_x = random(20,450);                    // Opretter en tilfældig x koordinat til cirklens startpunkt (IKKE centrum)
float cirkel_y = random(20,450);                    // Opretter en tilfældig y koordinat til cirklens startpunkt (IKKE centrum)
float timeLimit = 0.5 + 0.03;                       // 1 min countdown (0,03 ekstra, til opstart)
float exit_x = 320;                                 // X position for afslut knap
float exit_y = 320;                                 // Y position for afslut knap
float exit_w = 150;                                 // Bredde for afslut knap
float exit_h = 45;                                  // Højde for afslut knap
int hit_point = 0;                                  // Antal gange man velykket har ramt cirklerne
int missed_point = 0;                               // Antal mislykkede forsøg på at ramme cirklerne



void setup()
{
  size(799, 470);
  strokeWeight(1.2);
  stroke(80);
  bg = loadImage("gray.png");                       // Importerer baggrunssbilled 
}


void draw()
{
  background(bg);                                   // Sætter billed som baggrund
  fill(70);
  ellipse(cirkel_x, cirkel_y, cirkel_r, cirkel_r);  // Tegner cirkelen vha. de givende variabler
  textSize(30);
  text("Time", 670, 50);
  text("Hits", 678, 184);
  
  
  // Ændre hit point'es position, i forhold til teksten "Hits
  textSize(80);
  if (hit_point < 10)
  {
    text(hit_point, 682, 260);
  }
  else
  {
    text(hit_point, 660, 260);
  }

  
  // Opretter et countdown system
  float time = timeLimit*60*1000 - millis(); 
  float seconds =floor( time/1000 );
  float minutes = seconds/60;
  
  // Centrerer tallet i forhold til teksen "Time"
  textSize(80);
  if (seconds < 10)
  {
    text( floor(seconds), 682, 120);
  }
  else
  {
    text( floor(seconds), 658, 120);
  }
  
  
  // Opretter en "slut skærm", når tiden når nul. Og viser det opnåede resultat på skærmen
  if (seconds <= 0)
  {
    cirkel_x = 800; // FIX: undgå at man kan ramme en cirkel, efter spillet er slut
    background(bg);
    text("Tillykke!", 235, 200);
    textSize(30);
    text("Du fik " + hit_point + " point!", 282, 250);
    rect(exit_x, exit_y, exit_w, exit_h);
    fill(120);
    textSize(30);
    text("Afslut", exit_x + 30, exit_y + 33);
    
    // Slur program hvis man trykker på "Afslut"
    if(mousePressed)
    {
      if(mouseX>exit_x && mouseX <exit_x+exit_w && mouseY>exit_y && mouseY <exit_y+exit_h)
      {
        println("Exit"); 
        exit();
      }
    }
  }
}




/* I nedstående afsnit tjekkes der om der trykkes på cirken, eller om der rammes forbi.
Derudover opretter den en ny tilfældig cirkel, og nustiller baggrunden. */

void mouseReleased()
{
  if ( sqrt( sq(mouseX - cirkel_x) + sq(mouseY - cirkel_y) ) <= cirkel_r / 2 )   // Hvis afstanden mellem cirklens centrum og musens positions på skærmen, er inden for cirklen, så ..
  {
      background(bg);
      cirkel_r = random(20,300);                                                 // Opretter en tilfældig radius, til en cirkel som skal tegnes
      cirkel_x = random(20,450);                                                 // Opretter en tilfældig x koordinat til cirklens startpunkt (IKKE centrum)
      cirkel_y = random(20,450);                                                 // Opretter en tilfældig y koordinat til cirklens startpunkt (IKKE centrum)
      hit_point ++;                                                              // Vellykkede forsøg stiger, hvis man rammer cirkelen
  }
  else
  {
    missed_point ++;                                                             // Mislykkede forsøg stiger, hvis man ikke rammer cirkelen
  }
}
  



