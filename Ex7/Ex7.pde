import peasy.*;

PeasyCam cam;
PShader toon;
PShape ps;
float spreadVal = 0.005;

void setup() {
  size(640, 360, P3D);
    cam = new PeasyCam(this, 360);
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");

   
   ps = loadShape("untitled.obj");
  ps.scale(50);
  ps.setFill(color(255, 0, 0));
  ps.setStroke(color(0, 0, 255));
}

void draw() {
    background(0); 
  shader(toon);
   
  

  stroke(255, 0, 0);
  noFill();
  for (int i=0; i<ps.getChildCount(); i++) {
    PShape child = ps.getChild(i);
    for (int j=0; j<child.getVertexCount(); j++) {
      PVector pos = child.getVertex(j);
      PVector spread = new PVector(random(-spreadVal, spreadVal), random(-spreadVal, spreadVal), random(-spreadVal, spreadVal));
      pos.add(spread);
      child.setVertex(j, pos);
    }
  }
    float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  directionalLight(300, 300, 300, -dirX, -dirY, -1);
  translate(width/2, height/2);

  shape(ps);

  

  // This kind of effects are entirely implemented in the
  // fragment shader, they only need a quad covering the  
  // entire view area so every pixel is pushed through the 
  // shader. 





}
