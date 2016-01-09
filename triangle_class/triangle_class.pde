
/* ########################################################################
########### Trekanter som virker vha. classes og funktioner ###############
#########################################################################*/



Trekant tre1 = new Trekant(color(random(1,240), random(1,240), random(1,240)), 50, 50);
Trekant tre2 = new Trekant(color(random(1,240), random(1,240), random(1,240)), 100, 100);
Trekant tre3 = new Trekant(color(random(1,240), random(1,240), random(1,240)), 150, 150);
Trekant tre4 = new Trekant(color(random(1,240), random(1,240), random(1,240)), 200, 200);
Trekant tre5 = new Trekant(color(random(1,240), random(1,240), random(1,240)), 250, 250);
Trekant tre6 = new Trekant(color(random(1,240), random(1,240), random(1,240)), 300, 300);

void setup()
{
  size(400, 400);            // Window størrelse
  background (0);            // Standerd baggrunds farve
  frameRate(5);              // Sætter skærmopdateringen til 5
}

void draw()
{
  background(0);  // Sætter baggrunden til sort
  
  // Herunder bliver de funktioner som ligger inde ind Trekant class'en sat igang.
  
  tre1.changePos();      // Kører funktionen som ændre positionen for trkanten
  tre1.display();        // Kører funktionen som viser trekanten og som sletter baggrunden
  tre1.changeColor();    // Kører funktionen som ændre farve på trekanten
  
  tre2.changePos();
  tre2.display();
  tre2.changeColor();
  
  tre3.changePos();
  tre3.display();
  tre3.changeColor();
  
  tre4.changePos();
  tre4.display();
  tre4.changeColor();
  
  tre5.changePos();
  tre5.display();
  tre5.changeColor();
  
  tre6.changePos();
  tre6.display();
  tre6.changeColor();
}




class Trekant                                                // Class'en "Trekant"
{
  color farve;                                               // Sætter variablen "farve" til den farve som blev sendt da trekanterne blev oprettet
  float yPos;                                                // Sætter variablen "yPos" til den vertikale position som blev sendt da trekanterne blev oprettet
  float xPos;                                                // Sætter variablen "xPos" til den horizontale position som blev sendt da trekanterne blev oprettet
  
  Trekant(color tempfarve, float tempyPos, float tempxPos)   // Constructor, som håndterer de givet variabler
  {
    farve = tempfarve;
    yPos = tempyPos;
    xPos = tempxPos; 
  }
  
  
  void changePos()                                           // Funktionen som ændre position
  {
    yPos = yPos + random(-10,10);                            // Ændre den vertikale position på et tilfældigt basis                       
    xPos = xPos + random(-10,10);                            // Ændre den horisontale position på et tilfældigt basis
  }
  
  void display()                                             // Funktionen som tegner og viser trekanten
  {
    stroke(farve);
    fill(farve);
    triangle(xPos-20, yPos, xPos, yPos-20, xPos+20, yPos);   // Tegner trekanten
  }
  
  void changeColor()                                         // Funktionen som ændre farve
  {
   farve = color(random(1,240), random(1,240), random(1,240));  // Ændre til en tilfældig farve
  }
  
}  



