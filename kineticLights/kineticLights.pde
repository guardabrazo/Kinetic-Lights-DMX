void setup() {
  size(500, 500, P3D); 
  background(200);
  lights();
  noStroke();
  fill(50);
  
  pushMatrix();
  translate(width*0.5, height*0.5, 0);
  sphere(10);
  popMatrix();
}

void draw() {
}