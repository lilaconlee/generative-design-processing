import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  noLoop(); 
  int almost4Inches = 916;
  size (916, 916); // 4x4 hoop
  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "sampler";
  String fileName = projectTitle + "_" + str(int(random(10000)));
  
  // PES
  String outputFilePath = pesSetup(fileName);
  // SVG
  // String outputFilePath = svgSetup(fileName);
  
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
  save(fileName + ".png");
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

// End of boilerplate ---------------------------
// https://codepen.io/lilaconlee/pen/qBJVWEK?editors=0010
int[][] cellData = {{434,52,78},{296,729,129},{365,219,110},{84,547,129},{551,145,124},{92,71,106},{125,796,162},{746,853,93},{806,104,133},{748,274,119},{447,353,95},{774,583,134},{101,228,121},{352,498,107},{266,355,119},{593,391,138},{654,50,75},{128,396,117},{274,90,124},{728,724,85},{452,611,99},{848,391,101},{510,772,131}};

int[] hatchModes = {
    PEmbroiderGraphics.PERLIN,
    PEmbroiderGraphics.CROSS,
    PEmbroiderGraphics.PARALLEL,
    PEmbroiderGraphics.CONCENTRIC,
    PEmbroiderGraphics.SPIRAL,
  };

public int randomArrayItem(int[] array) {
  int index = (int)random(array.length);
  int item = array[index];
  // println(item, index);
  return item;
}

int count = 23;

void draw() {
  // the goods stuff goes here

  // voronoi from codepen
  for (int i = 0; i < cellData.length; i++) {
    int colorMode = int(random(2));
    int angle = int(random(0,360));
    E.hatchAngle(radians(angle));

    E.hatchMode(randomArrayItem(hatchModes));
    E.hatchSpacing(random(5,30));
    E.circle(cellData[i][0], cellData[i][1], cellData[i][2]);

    if (colorMode == 0) {
      E.fill(0,0,0);
    } else if (colorMode == 1) {
      E.fill(0,0,255);
    } else {
      E.fill(255,0,0);
    }
  }
  
  // all pembroider
  /**
  E.beginCull();
  for (int i = 0; i < count; i++) {
    int colorMode = int(random(2));
    int angle = int(random(0,360));
    E.hatchAngle(radians(angle));

    E.hatchMode(randomArrayItem(hatchModes));
    E.hatchSpacing(random(5,15));
    E.circle(random(width), random(height), random(100, 300));

    if (colorMode == 0) {
      E.fill(0,0,0);
    } else if (colorMode == 1) {
      E.fill(0,0,255);
    } else {
      E.fill(255,0,0);
    }
  }
  E.endCull();
  **/
}
