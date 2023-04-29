import processing.embroider.*;
PEmbroiderGraphics E;

// should be 4x4 hoop for Brother SE600
int inch = 254;
int almost4Inches = (inch * 4) - 100;

int hoopW = almost4Inches;
int hoopH = almost4Inches;

int width = hoopW;
int height = hoopH;

void setup() {
  noLoop(); 
  // ONLY USE NUMBERS NOT VARIABLES FOR SIZE DINGUS
  // this should be almost4Inches
  size(916, 916);
  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "twentythree";
  // String fileName = String.format(projectTitle, str(int(random(10000))));
  String fileName = projectTitle + str(int(random(10000)));
  
  // PES
  // String outputFilePath = pesSetup(fileName);
  // SVG
  String outputFilePath = svgSetup(fileName);
  
  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();
  E.strokeWeight(1); 
  E.fill(0, 0, 0); 
  E.noStroke(); 

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
  // the goods stuff goes here
  int size = width/10;
  int hatchMode = PEmbroiderGraphics.PERLIN;
  int firstCoordinate = 25;
  
  // track position of unit
  int column = 0;
  int row = 0;

  int count = 23; // 23 is the magic number <-- copilot gets it
  for (int i = 0; i < count; i++) {
    E.HATCH_MODE = hatchMode;
    E.HATCH_SPACING = int(random(10,20));
    E.HATCH_SCALE = int(random(1,10));
  }
}
