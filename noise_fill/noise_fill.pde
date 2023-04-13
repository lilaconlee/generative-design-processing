import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  noLoop(); 
  size (800, 800);
  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "boilerplate";
  String fileName = String.format(projectTitle, str(int(random(10000))));
  
  // PES
  String outputFilePath = pesSetup(fileName);
  // SVG
  // String outputFilePath = svgSetup(fileName);
  
  E.setPath(outputFilePath); 


  draw();
  
  E.optimize(); // slow, but good and important
  E.visualize();
  E.endDraw(); // write out the file
  //save(fileName + ".png");
}

// configures for svg, returns svg output file path
public String svgSetup(String filename) {

  // PLOTTER-SPECIFIC COMMANDS: 
  // Set this to false so that there aren't superfluous waypoints on straight lines:
  E.toggleResample(false);
  // Set this to false so that there aren't connecting lines between shapes. 
  // Note that you'll still be able to pre-visualize the connecting lines 
  // (the plotter path) if you set E.visualize(true, true, true);
  E.toggleConnectingLines(false);
  // This affects the visual quality of inset/offset curves for CONCENTRIC fills:
  E.CONCENTRIC_ANTIALIGN = 0.0;
  return sketchPath(filename + ".svg");
}

// returns pes output file path
public String pesSetup(String filename) {
    return sketchPath(filename + ".pes");
}

void draw() {
  int size = 500;
  int x = width/2;
  int y = height/2;
  
  
  E.beginDraw(); 
  E.clear();
  E.strokeWeight(20); 
  E.strokeSpacing(4);
  E.fill(0, 0, 0);
   
  VectorField vf = new VectorField();
  //E.HATCH_MODE = PEmbroiderGraphics.VECFIELD;
  E.HATCH_MODE = PEmbroiderGraphics.PERLIN;

  //E.HATCH_VECFIELD = vf;
   E.HATCH_SPACING = 5; // higher number -> fewer, farther apart
   E.HATCH_SCALE = .1; // higher number -> shorter, sharper
   // E.HATCH_ANGLE = 20;
  //E.HATCH_SPACING = int(random(10,20));
  //E.HATCH_SCALE = int(random(1,10));

  E.strokeWeight(20); 
  E.strokeSpacing(1);
  E.fill(0, 0, 0);
  E.circle(x, y, size);
}

class VectorField implements PEmbroiderGraphics.VectorField {
  public PVector get(float x, float y) {
    // x*=0.5;
    // return new PVector(1, sin(y) + cos(x));
    return new PVector(1,1);

  }
}
