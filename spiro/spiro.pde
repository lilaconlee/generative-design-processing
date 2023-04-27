import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  noLoop(); 
  // 4x4 inch hoop
  size(916, 916); 
  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "spiro";
  int num = int(random(100000));
  String fileName = projectTitle + "_" + num;
  println("hello");
  println(num);
  
  // PES
  String outputFilePath = pesSetup(fileName);
  // SVG
  // String outputFilePath = svgSetup(fileName);
  
  E.setPath(outputFilePath); 

  draw();
  
  E.optimize(); // slow, but good and important
  E.visualize();
  E.endDraw(); // write out the file
  save(fileName + "_23" + ".png");
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
  E.beginDraw(); 
  E.clear();
  E.noFill(); 
  E.stroke(0, 0, 0); 
  
  E.strokeWeight(10); 
  E.strokeSpacing(2.0);
  E.setStitch(5, 66, 0);
  E.PERPENDICULAR_STROKE_CAP_DENSITY_MULTIPLIER = 0.4;
  E.strokeMode(PEmbroiderGraphics.ANGLED); 

  E.beginShape(); 
  float cx = width/2; 
  float cy = height/2;
  float r = int(random(100,150)); // radius
  float l = random(1,2); //middle part
  float k = random(10,30);
  
  for (int i=0; i<=360; i++) {
    /* basic good spiral
    float t = map(i, 0, 360, 0, TWO_PI);
    float x = cx + r*sin(t) + (r*1.33)*cos(12*t); 
    float y = cy + r*cos(t) + (r*1.33)*sin(12*t); 
    E.vertex (x, y); */
    
    float t = map(i, 0, 360, 0, TWO_PI);

    float x = cx + r*cos(t) + (r*l)*cos(k*t); 
    float y = cy + r*sin(t) + (r*l)*sin(k*t); 
    E.vertex (x, y); 
    
    E.vertex (x, y);
  }
  E.endShape();
}
