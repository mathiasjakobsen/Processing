import              controlP5.*;       // Libary brugt til at lave textfields

PrintWriter         output;
PImage              qrImg, shadowImg;  // Opretter to billede variabler
ControlP5           cp5;               // Opretter objekt fra biblioteket "controlP5"
Layout content      = new Layout ();   // Opretter objekt fra class: "content"

// Globale skriftyper
// -------------------------------------------
PFont font          = createFont("arial", 20);
PFont font2         = createFont("arial", 15);

String[] databaseContent;                // Array med alt databse indhold
String imgURL, searchQuery, parameters;  // QR billede webadresse - søgeordet fra søgefunktionen - Parametre til at generere QR kode URL

String database     = "donotdelete/database"; // Navn på databse filen (.txt fil)
String values[]     = { "Enhed", "Model", "S/N", "Ejer", "Bruger", "Andet" }; // Indhold i hver enhed, i databasen
String values2[]    = new String[values.length]; // Tilhørende værdier til inhold i hver enhed, i databasen

String currentData  = "&&&&&&"; // Variabel med den aktive enheds inhold (&&&&&& er en placeholder)
int scrollPosition  = 0; // Definere hvad der skal vises, når man scroller

// Globale farve variabler
// ------------------------------
color white         = color(255);
color gray          = color(241);
color lightgray     = color(164);
color darkgray      = color(83);
color reset         = color(237);

// Globale layout variabler - Variabler er dynamiske, så hvis de ændres, så tilpasser ALT andet sig
// ------------------------------------------------------------------------------------------------
int sidebarWidth    = 240;    // Venstre-menuens bredde
int contentWidth    = 410;    // Højre views vredde
int listEntryHeight = 70;     // Højde på hver rubrik i ventre menu 
int menuHeight      = 40;     // Søgefelts-menu højde

void setup() 
{   
  shadowImg       = loadImage("shadow.png");           // Importer skygge billede til menuen
  cp5             = new ControlP5(this);               // Opretter objekt fra classen CP5, fra controlP5 biblioteket
  databaseContent = loadStrings(database+".txt");      // Importerer databasen
  
  size(contentWidth+sidebarWidth, displayHeight-100);
  noStroke();
  background(gray);
  textFont(font); 
  
  content.createTextfields();  // Kører funktion, som opretter textfields
  content.view();              // Kører funktion, som opretter hele layoutet
}


void draw() 
{
  if(currentData.equals("&&&&&&") == true) // Hvis ingen enhed er valgt, vises en placeholder
  {
    content.placeholder();
  }  
  searchQuery = ((cp5.get(Textfield.class,"search").getText()).toLowerCase()).replace(" ", "+"); // Opdaterer søgekriterier
  content.sidebarContent(); // Reloader menuen, med evt. nye søgekritereier

}


// Udvidet text() funktion, med mulighed for at bruge farve og størrele som parametre
void printText (String text, int size, color fontColor, float xPos, float yPos)
{
  fill(fontColor);
  textSize(size);
  text(text, xPos, yPos);
  fill(white);
}



void mouseReleased()
{
  if (mouseX>(sidebarWidth-menuHeight) && mouseX<sidebarWidth && mouseY>0 && mouseY <menuHeight) // "+" knap
  {
    background(reset);
    currentData = "Temp";
    content.edit("newEntry");  // Viser layout, til at oprette en ny enhed
  }
  if(!cp5.get(Bang.class,"Nulstil").isVisible()) // Tjekker at knappen "Nulstil" IKKE er synlig
  {  
    if (mouseX>(contentWidth+sidebarWidth)-195 && mouseX<(contentWidth+sidebarWidth)-120 && mouseY>0 && mouseY <menuHeight) // Print knap
    {
      print(); // kører print funktion
    }
    if (mouseX>(contentWidth+sidebarWidth)-120 && mouseX<(contentWidth+sidebarWidth)-50 && mouseY>0 && mouseY <menuHeight) // Rediger knap
    {
      content.edit("updateEntry"); // viser tekstfelter, med den valgte værdier som preset værdier
    }
    if (mouseX>(contentWidth+sidebarWidth)-50 && mouseX<(contentWidth+sidebarWidth) && mouseY>0 && mouseY <menuHeight) // Delete knap
    {
      delete(); // kører slet funktionen
    }
  }
  
  int tmp = 0; // tmp håndtere om man trykker på et søgeresultat, eller fra en standard sorteret liste
  
  for (int i=0; i < (databaseContent.length-scrollPosition); i++) // Opretter trykbare felter, svarende til databasens indhold
  {
    if (((databaseContent[i+scrollPosition]).toLowerCase()).indexOf(searchQuery) != -1) // Tjekker om søgefeltet matcher en enhed i databasen
    {
      if (mouseX>0 && mouseX<sidebarWidth && mouseY>menuHeight+((i-tmp)*listEntryHeight) && mouseY<menuHeight+((i-tmp)*listEntryHeight)+listEntryHeight) // Tjekker hvad for en enhed man har trykket på
      {
        content.edit("hide"); // Skjuler CP5 textfields
        currentData = databaseContent[i+scrollPosition]; // Opdaterer nuværende aktive enhed
        manipulateString("encode"); // Omskriver ulæseigt indhold fra databasen til læseligt tekst
        content.view(); // Opdaterer layout
      }
    }
    else
    {
      tmp++;
    }
  }
}


/* Databasen er labet således, at for hver enhed der oprettes, laves der en String med ALLE informationer.
Mellemrum deles med "+" og de forskellige parametre deles med et "&" tegn. Denne funktion encoder og decoder
disse Strings med data */
// ---------------------------------------------------------------------------------------------------------
void manipulateString(String action)
{
  String[] list = split(currentData, "&"); // Oprette Array og deler værdier ved "&" tegn
  
  for(int i=0; i<values.length; i++) // Udfører funktion x antal gange, svarende til antal værdier
  {
    if (action.equals("decode") == true)
    {
      values2[i] = list[i].replace("+", " "); // Erstatter "+" med mellemrum
    }
    if (action.equals("encode") == true)
    {
      values2[i] = list[i]; // Bibeholder String, hvor "+" står for mellemrum
    }
  }
}


class Layout // Class som indeholder alt layout
{
  void view() // "Genvejs funktion" som kører display() og sidebar() funktionerne
  {
    background(reset);
    this.display(); // "this." er en måde hvorpå man henviser til classen man er i 
    this.sidebar(); // i stedet for at skrive "Layout."
  }
  
  void display()
  {
    fill(white);
    noStroke();
    rect(sidebarWidth, 0, contentWidth, menuHeight);
    fill(darkgray);
    stroke(lightgray);
    
    line(sidebarWidth, menuHeight-1, contentWidth+sidebarWidth, menuHeight-1);
    line((contentWidth+sidebarWidth)-50, 0, (contentWidth+sidebarWidth)-50, menuHeight-1);
    line((contentWidth+sidebarWidth)-120, 0, (contentWidth+sidebarWidth)-120, menuHeight-1);
    line((contentWidth+sidebarWidth)-195, 0, (contentWidth+sidebarWidth)-195, menuHeight-1);
    
    printText("Slet", 15, darkgray, (contentWidth+sidebarWidth)-40, 24);
    printText("Rediger", 15, darkgray, (contentWidth+sidebarWidth)-110, 24);
    printText("Print QR", 15, darkgray, (contentWidth+sidebarWidth)-185, 24);
    
    image(shadowImg, sidebarWidth, menuHeight, sidebarWidth+contentWidth, 25);
    
    manipulateString("decode");              // Decoder inhold til læseligt tekst
    int margin       = contentWidth/6;       // Laver en margin så indholdet ikke rammerne katerne på vinduet
    int qrSize       = contentWidth-margin;  // QR kodens størrelse, som afhænger af vinduets bredde
    float increase   = ((displayHeight-100-(qrSize+margin+180))/(values.length))+15; // Placerer automatisk teksten fordelt ligeligt vertikalt
    float usedHeight = qrSize+180;           // Teksten placeres automatisk under QR billedet
    
    // Viser den nuværende enheds oplysninger, og fordeler dem automatisk på siden
    // -------------------------------------------------------------------------------------
    fill(darkgray);
    textSize(60);
    text(values2[0], sidebarWidth+(margin/2), qrSize+50+menuHeight, qrSize, 70);
    textSize(30);
    text(values2[1], sidebarWidth+(margin/2), qrSize+115+menuHeight, qrSize, 40);
    textSize(20);
    
    for(int i=2; i<values.length; i++)
    {
      fill(darkgray);
      text(values2[i], sidebarWidth+(margin/2)+80, menuHeight+usedHeight+((i-2)*increase));
      
      fill(lightgray);
      text(values[i], sidebarWidth+(margin/2), menuHeight+usedHeight+((i-2)*increase));
    }
    // -------------------------------------------------------------------------------------
    
    
    
    // Encoder den nuværende enhed, og opretter en QR kode med enhedens oplysninger, via. 
    // Kaywa QR Code generator. Derfor SKAL programmet have forbindelse til internettet.
    // -------------------------------------------------------------------------------------
    manipulateString("encode");
    imgURL = "http://qrfree.kaywa.com/?l=1&s=8&d=";
    for(int i=0; i<values.length; i++)
    {
      imgURL = imgURL+values[i]+"%3A%0A"+values2[i]+"%0A%0A";
    }
    qrImg = loadImage(imgURL, "png");
    image(qrImg, sidebarWidth+(margin/2), (margin/2)+menuHeight, qrSize, qrSize);
    // -------------------------------------------------------------------------------------
    
  }

  void sidebar() // Opretter layout med baggrund og linjer, til sidebar menuen.
  {
    fill(white);
    noStroke();
    rect(0, 0, sidebarWidth, displayHeight); // Sidebar
    fill(darkgray);
    stroke(lightgray);
    line(sidebarWidth, 0, sidebarWidth, displayHeight);
    line(0, (menuHeight-1), sidebarWidth, (menuHeight-1));
    line(sidebarWidth-(menuHeight-1), 0, sidebarWidth-(menuHeight-1), (menuHeight-1));
    noStroke();
    printText("+", 26, darkgray, sidebarWidth-(menuHeight*0.7), (menuHeight*0.8));
    printText("Søg:", 15, lightgray, 30, 24);
  }
  
  // Placeholder siden, som vises hvis der ikke er valgt en enhed. Teksten placeres automatisk i midten af skærmen.
  void placeholder()
  {
    background(reset);
    printText("CatalogIT", 33, lightgray, (sidebarWidth+(contentWidth/2)-73), (((displayHeight-100)/2)-70));
    printText("Opret/vælg enhed", 16, lightgray, (sidebarWidth+(contentWidth/2)-69), (((displayHeight-100)/2)-30));
    printText("Print QR kode ud", 16, lightgray, (sidebarWidth+(contentWidth/2)-65), (((displayHeight-100)/2))-5);
    printText("Vedhæft QR til enhed", 16, lightgray, (sidebarWidth+(contentWidth/2)-82), (((displayHeight-100)/2)+20));
    printText("Done!", 16, lightgray, (sidebarWidth+(contentWidth/2)-25), (((displayHeight-100)/2)+45));
  }
  
  void sidebarContent() // Henter indhold til sidebar menuen
  {
    int tmp = 0;      // tmp bruges til at tjekke, om der er fundet søgeresultat
    this.sidebar();   // kører funktionen, som opretter baggrund, linjer og knapper
    for (int i=0; i < (databaseContent.length-scrollPosition); i++)
    {
      String[] tempList = split(databaseContent[i+scrollPosition], "&");
      if (((databaseContent[i+scrollPosition]).toLowerCase()).indexOf(searchQuery) != -1)
      {
        tempList[0] = tempList[0].replace("+", " "); // Decoder databasen, så teksten bliver læselig
        tempList[4] = tempList[4].replace("+", " ");
        
        noStroke();
        // Denn if/else sætning, laver simpelt nok den boks musen er over, grå, så man kan se hvad man er ved at trykke på.
        if (mouseX>0 && mouseX<sidebarWidth && mouseY>(menuHeight+((i-tmp)*listEntryHeight)) && mouseY <(menuHeight+((i-tmp)*listEntryHeight)+listEntryHeight))
        {
          fill(gray);
          rect(0, (menuHeight+((i-tmp)*listEntryHeight)), sidebarWidth, listEntryHeight-1);
        }
        else
        {
          fill(white);
          rect(0, (menuHeight+((i-tmp)*listEntryHeight)), sidebarWidth, listEntryHeight-1);
        }
        
        // Disse to for loops, bruges til at lave teksten mindre, hvis noget rager ud over sidebaren.
        // --------------------------------------
        int tmpTextSize = 18, tmpTextSize2 = 24;
        for(int a=tempList[4].length(); a>21; a--) 
        {
          tmpTextSize--;
        }
        for(int a=tempList[0].length(); a>15; a--)
        {
          tmpTextSize2--;
        }
        
        // Printer navn på enhed, samt enheds bruger i sidebaren.
        // ------------------------------------------------------
        printText(tempList[0], tmpTextSize2, darkgray, 30, menuHeight+(listEntryHeight/2)+(i*listEntryHeight)-(tmp*listEntryHeight));
        printText(tempList[4], tmpTextSize, darkgray, 30, menuHeight+((listEntryHeight/2)+20)+(((i-tmp)*listEntryHeight)));
        stroke(darkgray);
        line(0, (((menuHeight+listEntryHeight)-1)+((i-tmp)*listEntryHeight)), sidebarWidth, ((menuHeight+listEntryHeight)-1)+((i-tmp)*listEntryHeight));
      }
      else
      {
        tmp++;
      }

    }
    if(scrollPosition > 0) // Hvis der scrolles, tilføjes en skygge, så man kan se at man har scrollet
    {
      image(shadowImg, 0, menuHeight, sidebarWidth, 30);
    }
    if(databaseContent.length <= 0) // Hvis der ikke er noget i datasen, så vises denne tekst i stedet
    {
      printText("Tilføj ny enhed, ved at trykke på +", 14, lightgray, 13, menuHeight+25);
    }
  }

  /* edit() består af tre if sætninger, som bruges når tekstfelterne til redigering og oprettelse skal
  vises eller skjules. Desuden styrer den også om "Gem", "Opdater" og "Nulstil" kanpperne vises*/
  // ------------------------------------------------------------------------------------------------- 
  void edit(String action)
  {
    background(reset);
    if(action.equals("newEntry")) // Ved oprettelse af ny enhed
    {
      for (int i=0; i<values.length; i++)
      {    
        cp5.get(Textfield.class, values[i]).setValue(""); // Sætter tekstboksen værdi til ingenting
        cp5.get(Textfield.class, values[i]).show(); // Viser tekstfelterne
      }
      cp5.get(Bang.class, "Nulstil").show(); // Viser knapperne
      cp5.get(Bang.class, "Gem").show(); // ----------------
    }
  
    if(action.equals("updateEntry")) // Ved opdatering af ekisterende enhed
    {
      for (int i=0; i<values.length; i++)
      {     
        cp5.get(Textfield.class, values[i]).setValue(values2[i].replace("+", " ")); // Erstatter + med mellemrum, for læselig tekst
        cp5.get(Textfield.class, values[i]).show(); // Viser tekstfelter
      }
      cp5.get(Bang.class, "Nulstil").show(); // Viser knapperne
      cp5.get(Bang.class, "Opdater").show(); // --------------
    }
  
    if(action.equals("hide")) // Skjuler alle felter fra controlP5
    {
      for (int i=0; i<values.length; i++)
      {    
        cp5.get(Textfield.class, values[i]).hide();
      }
      cp5.get(Bang.class, "Nulstil").hide();
      cp5.get(Bang.class, "Gem").hide();
      cp5.get(Bang.class, "Opdater").hide();
    }  
  }
  
  /* createTextfields() bruges til at oprette alle tekstfelter fra controlP5 libary'et, samt knapperne.
  Til at oprette felterne, bruges de samme funktioner gentagne gange, til at indstille størrelse farver osv.
  ------------------------------------------------------------------------------------------------------- */
  void createTextfields()
  {
    cp5.addTextfield("search") // Navn
    .setPosition(65,0)         // Position
    .setAutoClear(true)        // Auto nulstil
    .setSize((sidebarWidth-menuHeight-65),menuHeight-1)
    .setFont(font2)            // Indstiller skriftype
    .setColor(lightgray)       // Farve på skrifttype
    .setColorForeground(white) // Farve på kanterne
    .setColorBackground(white) // Baggrundsfarve
    .setColorActive(gray)      // Farve på kanten, når tekstfeltet er aktivt
    .setCaptionLabel("");      // Nustiller en label, som vises ved knappen
    
    for (int i=0; i<values.length; i++)
    {    
      cp5.addTextfield(values[i])
      .setPosition((sidebarWidth+20), ((i*60)+20))
      .setSize(contentWidth-40, 40)
      .setFont(font)
      .setColor(darkgray)
      .setColorForeground(gray)
      .setColorBackground(white)
      .setColorActive(darkgray)
      .setColorCaptionLabel(darkgray);
    }
      cp5.get(Textfield.class, values[0]).setFocus(true);
      cp5.addBang("Nulstil")
      .setPosition((sidebarWidth+20),((values.length*60)+20))
      .setSize(contentWidth/3, 40)
      .getCaptionLabel()
      .align(ControlP5.CENTER, ControlP5.CENTER);
      
      cp5.addBang("Gem")
      .setPosition(((sidebarWidth+20)+((contentWidth/3)+20)),((values.length*60)+20))
      .setSize(contentWidth/3, 40)
      .getCaptionLabel()
      .align(ControlP5.CENTER, ControlP5.CENTER);
      
      cp5.addBang("Opdater")
      .setPosition(((sidebarWidth+20)+((contentWidth/3)+20)),((values.length*60)+20))
      .setSize(contentWidth/3, 40)
      .getCaptionLabel()
      .align(ControlP5.CENTER, ControlP5.CENTER);   
      textFont(font);
      content.edit("hide");
  }  
}

void Nulstil() // Funktion bruges til at nustille alle teksfelter
{
  for (int i=0; i<values.length; i++) // For loop kører igennem alle felterne.
  {
    cp5.get(Textfield.class, values[i]).clear(); // Nulstiller tekstfelterne
  }
}

void Gem() // Funktionen bruges, når man skal gemme en ny enhed
{
  if(!(cp5.get(Textfield.class,values[0]).getText()).equals(""))
  {
    background(reset);
    content.edit("hide"); // Skjuler oprettelses vinduet
    for (int i=0; i<values.length; i++)
    {
      values2[i] = (cp5.get(Textfield.class,values[i]).getText()).replace(" ", "+"); // Encoder teksten, så mellemrum bliver til +
    }
    
    currentData = ""; 
    for (int i=0; i<values.length; i++)
    {
      currentData = currentData+values2[i]+"&"; // Opdaterer currentData med de nye oplysninger
    }
    
    databaseContent = append(databaseContent, currentData); // append() bruges til at tilføje en String til et Array
    saveStrings(database+".txt", databaseContent); // Den nye enhed gemmes til database filen
    Nulstil(); // Nulstiller alle tekstfelterne
    content.display(); // Viser preview vinduet med den nye enhed
  }
  println("Gemt!");
}



void Opdater() // Bruges når en eksiterende enhed skal opdateres med nye oplysninger
{
  int tmpCount = 0;
  for (int i=0; i < (databaseContent.length); i++) // Dette for loop bruges til at finde et Array værdi for den aktive enhed.
  {
    if ((databaseContent[i]).indexOf(currentData) != -1) // indexOf bruges til at lede efter en String i databseContent Array'et
    {
      tmpCount = i;
    }
  }
  
  for (int i=0; i<values.length; i++)
  {
    values2[i] = (cp5.get(Textfield.class,values[i]).getText()).replace(" ", "+"); // Opdaterer values2[] med den aktive enhed
  }
  String tempData = "";  // tempData samler de opdaterede oplysninger i en String
  for (int i=0; i<values.length; i++)
  {
    tempData = tempData+values2[i]+"&";
  }
  
  databaseContent[tmpCount] = tempData; // databseContent opdateres med den redigerede enhed
  saveStrings(database+".txt", databaseContent); // ændringer gemmes til databsefilen
  Nulstil();
  fill(darkgray);
  text("Succesfully updated..", sidebarWidth+20, 510);    
}



void delete() // Bruges til, at slette en hed
{
  int tmpCount = 0;
  int tmpCountFirst = 0;
  for (int i=0; i < (databaseContent.length); i++) // Dette for loop bruges til at finde et Array nummer for den aktive enhed.
  {
    if ((databaseContent[i]).indexOf(currentData) != -1) // indexOf bruges til at lede efter en String i databseContent Array'et
    {
      tmpCountFirst = i;
      println(tmpCountFirst);
    }
    tmpCount++;
  }
  
  String[] dst = subset(databaseContent, tmpCountFirst+1); // Deler databaseContent op i to nye arrays, hvor den enhed som skal slettes
  String[] dst2 = subset(databaseContent, 0, tmpCountFirst); // er udeladt, i begge arrays.
  String[] finalDst = concat(dst2, dst); // De to Arrays samles igen, og den enhed som skal slettes, er ikke længere en del af Arrayet
  
  saveStrings(database+".txt", finalDst); // Ændringer gemmes til databsefilen
  databaseContent = loadStrings(database+".txt"); // Databsen genindlæses med de nye ændringer.
  currentData = "&&&&&&"; // currentData nustilles med en placeholder String
  background(reset);
  content.view(); // genindlæset hovedlayout
}

void print() // Bruges til, at sende QR kode til print websitet
{  
  parameters = values[0]+"="+values2[0]+"&";
  for(int i=1; i<values.length; i++)
  {
    parameters = parameters+values[i]+"="+values2[i]+"&"; // Sammensætter alle oplysinger i en String
  }
  // QR koden kan ikke indeholde æ,ø og å, som de erstattes her med nogle synonymer
  parameters = parameters.replace("æ", "ae");
  parameters = parameters.replace("ø", "oe");
  parameters = parameters.replace("å", "a");
  
  // Print website åbnes, med oplysningerne som parametre
  link("http://mathiasjakobsen.dk/eksamen/index.php?"+parameters);
}


void keyPressed() // Tjekker om der er trykket på en tast
{ 
  // "CODED" er nogle indbygget genveje, til at refererer til de mest alm. knapper på tastatureret
  if (key == CODED) 
  {
    if (keyCode == UP) // Hvis man trykker på "pil op", scroller man op
    {
      if(scrollPosition>0)
      {
        scrollPosition--;
      }
    }
    if (keyCode == DOWN) // Hvis man trykker på pil ned, scroller man ned
    {
      float scrollHeight = floor((displayHeight-menuHeight-100)/listEntryHeight); // Maks. antal enheder, som kan ses i sidebaren
      if(((databaseContent.length)-scrollPosition) > scrollHeight) // Sørger for, at man ikke scroller "uden for vinduet"
      {
        scrollPosition++;
        noStroke();
        if(((databaseContent.length)-scrollPosition) > (scrollHeight-1)) // Sørger for at der ikke er "spor" efter draw()
        {
          fill(white);
          rect(0, (menuHeight+(scrollHeight*listEntryHeight)), sidebarWidth, listEntryHeight);
        }
      }
    } 
  }
}





