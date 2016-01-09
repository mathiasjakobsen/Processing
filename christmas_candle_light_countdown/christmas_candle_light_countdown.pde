/* 

CHRISTMAS CANDLE LIGHT

Jeg har lavet programmet med følgende funktioner:

- Flammen har 3 positioner, som det tilfældivis skifter mellem.
- Hvis man ikke er i December, så kommer den frem med en nedtælling til December måned.
- Når man er i December, så brænder lyset ned dag efter dag.
- Når man når den 24 December, så få man en "Glædelig Jul" besked og flammen går ud.
- Nedtællingen virker for HELE året.

OBS! - Prøv eventuelt at ÆNDRE DATOEN i de to tidsvariabler, så du kan se funktionerne live. - OBS!

*/


void setup()
{
  size(400, 400);            // Window størrelse
  strokeWeight(1.2);         // Kanters tykkelse
  stroke(200, 0, 40);        // Kanters farve
  frameRate(4);              // Antal billeder i sekundet
  background (0);            // Standerd baggrunds farve
}

int dd = day();              // Opretter en variabel dd, som indeholder dags dato <-- ####### ÆNDRE DENNE VARIABEL FOR TEST
int maned_nu = month();      // Opretter en variabel maned_nu, som indeholder den måned vi er i <-- ######### ÆNDRE DENNE VARIABEL FOR TEST
int dage_tilbage;            // Reserverer plads til en variabel som skal indeholde, hvor mange dage der er til jul.
int hojde;                   // Reserverer plads til en variabel som skal indeholde lyset højde

void draw()
{
  dagCount();                // Kører funktionen dagCount
  float flak = random(0,3);  // Opretter en variabel, med navnet flak, som indeholder et tilfældigt nummer mellem 0 og 3.
  tegnFlamme(flak);          // Kører funktionen tegnFlamme og sender variablen "flak" med
  beregnHojde();             // Kører funktion "beregn højde".
}



void beregnHojde ()
{
  if (dage_tilbage <= 24 && dage_tilbage != 0)       // Hvis der er mindre en 24 dage tilbage og det ikke er den 24. december
  {
    hojde = (225 / 24) * (24-dage_tilbage);          // Ændre højden på lyset + ændre placering af flammen
    textSize(70);
    text(dage_tilbage, 20, 200);                     // DETTE AFSNIT: Skriver hvor mange dage der er tilbage til jul
    textSize(14);
    text("DAGE TIL", 32, 225);
    textSize(38);
    text("JUL", 34, 260);
  }
  if (dage_tilbage > 24)                             // Hvis der er mere end 24 dage til jul
  {
    textSize(70);                                    // HDETTE AFSNIT: Skriver hvor mange dage der er til December starter.
    text(dage_tilbage-24, 155, 305);
    textSize(18);
    text("DAGE TIL", 160, 330);
    textSize(16);
    text("DECEMBER", 158, 350);
  }
  
  if (dage_tilbage <= 0)                             // Hvis der er 0 dage til den er jul = juleaften   
  {
    text("GLÆDELIG", 1, 100);                        // Skriver glædelig jul
    text("JUL :)", 90, 180);
    hojde = 225;                                     // Sætter højden på lyset til at være fast
    stroke(0);
    fill(0);
    rect(150, 270, 100, 75);                         // "Sletter" flammen ved at overskrive den med en rektangel
    stroke(30);
    strokeWeight(5);
    line(200, 325, 200, 350);                        // Laver en væge til lyset
    strokeWeight(1);
    textSize(80);
  }
}

void tegnLys ()                                      // Funktion som tegner lys- og lysestage.
{ 
  background (0);                                    // Resetter baggrund
  fill(200, 0, 40);                                  // Sætter fyldefarven til rød
  rect(155, 125 + hojde, 90, 280, 7, 7, 7, 7);       // Opretter selve lyset, med runde kanter
  fill(80, 80, 80);                                  // Sætter fyldfarven til grå
  rect(100, 370, 200, 280, 7, 7, 7, 7);              // Opretter en lysestage
}


void tegnFlamme (float z)                                                    // Funktion som tegner/animerer falmmen (Flak variabelen hentes)
{
  if (z <= 1)                                                                // Hvis flak variabelen er mindre eller lig med 1:
  {
    tegnLys();                                                               // Kører funktionen som tegner lyset
    fill(252, 159, 36);                                                      // Sætter fyldfarven til orange
    quad(200, 120+hojde, 180, 100+hojde, 200, 60+hojde, 220, 100+hojde);     // Opretter selve flammen + ændre positionen i forhold til datoen
  }
  
  if ( z > 1 && z < 2)                                                       // Hvis flak variablen er større end 1 og mindre end 2
  {
    tegnLys();                                                               // Kører funktionen som tegner lyset
    fill(252, 159, 36);                                                      // Sætter fyldfarven til orange
    quad(200, 120+hojde, 180, 100+hojde, 210, 50+hojde, 220, 100+hojde);     // Opretter en anderledes flamme + ændre positionen i forhold til datoen
  }
  
  if (z > 2)                                                                 // Hvis flak variablen er større end 1 og mindre end 2
  {
    tegnLys();                                                               // Kører funktionen som tegner lyset
    fill(252, 159, 36);                                                      // Sætter fyldfarven til orange
    quad(200, 120+hojde, 180, 100+hojde, 190, 50+hojde, 220, 100+hojde);     // Opretter en anderledes flamme + ændre positionen i forhold til datoen
  }
}


void dagCount ()
{
  int jan = 31;    // Opretter månedsvaribler med det antal dage som der er i måneden
  int feb = 28;
  int mar = 31;
  int apr = 30;
  int maj = 31;
  int jun = 30;
  int jul = 31;
  int aug = 31;
  int sep = 30;
  int okt = 31;
  int nov = 30;
  int dec = 24;
  
  if (maned_nu == 1)                                                                              // Janua
  {
    dage_tilbage = (jan- dd) + feb + mar + apr+ maj + jun + jul + aug + sep + okt + nov + dec;    // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 2)                                                                              // Februar
  {
    dage_tilbage = (feb - dd) + mar + apr+ maj + jun + jul + aug + sep + okt + nov + dec;         // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 3)                                                                              // Marts
  {
    dage_tilbage = (mar - dd) + apr + maj + jun + jul + aug + sep + okt + nov + dec;              // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 4)                                                                              // April
  {
    dage_tilbage = (apr - dd) + maj + jun + jul + aug + sep + okt + nov + dec;                    // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 5)                                                                              // Maj
  {
    dage_tilbage = (maj - dd) + jun + jul + aug + sep + okt + nov + dec;                          // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 6)                                                                              // Juni
  {
    dage_tilbage = (jun - dd) + jul + aug + sep + okt + nov + dec;                                // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 7)                                                                              // Juli
  {
    dage_tilbage = (jul - dd) + aug + sep + okt + nov + dec;                                      // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 8)                                                                              // August
  {
    dage_tilbage =  (aug - dd) + sep + okt + nov + dec;                                           // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 9)                                                                              // September
  {
    dage_tilbage =  (sep - dd) + okt + nov + dec;                                                 // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 10)                                                                             // Oktober
  {
    dage_tilbage =  (okt - dd) + nov + dec;                                                       // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 11)                                                                             // November
  {
    dage_tilbage =  (nov - dd) + dec;                                                             // Regner ud hvor mange dage der er tilbage til jul
  }
  
  if (maned_nu == 12)                                                                             // December
  {
    dage_tilbage = dec - dd;                                                                      // Regner ud hvor mange dage der er tilbage til jul
  }
}
  
