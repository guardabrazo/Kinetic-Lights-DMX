import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import controlP5.*;

PeasyCam cam;
ControlP5 controlP5;

int xLights = 5;
int yLights = 5;
int numLights = xLights * yLights;

int separation = 30;
int radius = 5;

float[] zPos;
float[] zOff;

float speed;
float amplitude;

void setup() {
  size(800, 800, P3D); 
  smooth();
  background(200);
  lights();
  noStroke();
  fill(150);

  //CAMERA SETTINGS
  cam = new PeasyCam(this, width*0.5, height*0.5, 0, 500);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
  cam.setSuppressRollRotationMode();  // Permit pitch/yaw only.
  cam.rotateX(-PI * 0.35);

  //GUI SETTINGS
  controlP5 = new ControlP5(this);
  //controlP5.addNumberbox("LIGHTS X", 0, 10, 10, 50, 20);
  //controlP5.addNumberbox("LIGHTS Y", 0, 10, 50, 50, 20);
  controlP5.addSlider("SPEED", 0, 5, 2.5, 10, 10, 100, 20);
  controlP5.addSlider("AMPLITUDE", 0, 50, 25, 10, 40, 100, 20);
  controlP5.setAutoDraw(false);
  
  //INITIALIZE zOffs
  zOff = new float[numLights];
  for(int i = 0; i < (xLights * yLights); i ++){
    zOff[i] = random(1000);
  }
}

void draw() {
  background(200);
  
  //xLights = round(controlP5.getController("LIGHTS X").getValue());
  //yLights = round(controlP5.getController("LIGHTS Y").getValue());
  speed = controlP5.getController("SPEED").getValue();
  amplitude = controlP5.getController("AMPLITUDE").getValue();
  
  //Array for the Z position of the fixtures
  zPos = new float[numLights];
  for(int i = 0; i < zPos.length; i++){
    zPos[i] = map(sin(zOff[i]), -1, 1, 0, amplitude);
    zOff[i] += (0.01 * speed);
  }
  

  //PREVENT GUI CHANGES TO MOVE CAMERA
  if (controlP5.getWindow().isMouseOver()) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
  
  //CENTER THE VIEW
  pushMatrix();
  translate(width*0.5 - (separation * xLights)*0.5 + radius*2, height*0.5 - (separation * yLights)*0.5 + radius*2, 0);

  //CREATE THE GRID OF FIXTURES
  for (int i = 0; i < xLights; i ++) {
    for (int j = 0; j < yLights; j ++) {
      pushMatrix();
      translate(i * separation, j * separation, zPos[i+(xLights * j)]);
      sphere(radius);
      popMatrix();
    }
  }
  
  popMatrix();

  drawGUI();
}


void drawGUI() {
  cam.beginHUD();
  controlP5.draw();
  cam.endHUD();
}