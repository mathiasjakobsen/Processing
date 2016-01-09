void setup() {
  size(400, 520);
}

void draw() {
  
  strokeWeight(1);
  line(200, 135, 200, 400);
  
  strokeWeight(1);
  line(200, 150, 100, 200);
  
  strokeWeight(1);
  line(200, 150, 300, 200);
  
  strokeWeight(1);
  line(200, 400, 100, 500);
  
  strokeWeight(1);
  line(200, 400, 300, 500);
  
  strokeWeight(1);
  color c1 = color(232, 229, 207);
  fill(c1);
  ellipse(200, 90, 100, 100);
  
  strokeWeight(1);
  color c3 = color(206, 236, 245);
  fill(c3);
  ellipse(220, 80, 12, 12);
  
  strokeWeight(1);
  color c4 = color(206, 236, 245);
  fill(c4);
  ellipse(180, 80, 12, 12);
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      
      color c2 = color(102, 102, 0);
      fill(c2);
      strokeWeight(4);
      line(200, 400, 200, 430);
  
      strokeWeight(1);
      ellipse(196, 407, 10, 10);
      strokeWeight(1);
      ellipse(204, 407, 10, 10);
    
    } 
    } 
  } 
