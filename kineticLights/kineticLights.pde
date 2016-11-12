import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import controlP5.*;

PeasyCam cam;
ControlP5 controlP5;

int xLights = 0;
int yLights = 0;
int separation = 30;
int radius = 5;

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
  controlP5.addNumberbox("LIGHTS X", 0, 10, 10, 50, 20);
  controlP5.addNumberbox("LIGHTS Y", 0, 10, 50, 50, 20);
  controlP5.setAutoDraw(false);
}

void draw() {
  background(200);
  
  xLights = round(controlP5.getController("LIGHTS X").getValue());
  yLights = round(controlP5.getController("LIGHTS Y").getValue());

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
      translate(i * separation, j * separation, 0);
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