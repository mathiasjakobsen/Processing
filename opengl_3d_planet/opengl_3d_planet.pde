void setup() {
  size(200,200,OPENGL);
  noStroke();
  fill(250);
}

void draw() {
  background(50, 50, 50);
  translate(width/2,height/2);
  rotateX(PI*mouseY/height);
  rotateY(PI*mouseX/width);
  rectMode(CENTER);
  lights();
  sphere(30);
}
