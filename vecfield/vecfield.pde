import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  noLoop(); 
  size (1000, 1000);
  E = new PEmbroiderGraphics(this, width, height);

  String projectTitle = "vecfield";
  String fileName = projectTitle + str(int(random(10000)));

  String outputFilePath = sketchPath(fileName + ".pes");
  E.setPath(outputFilePath); 


  draw();

  //-----------------------
  //E.optimize(); // slow, but good and important
  E.visualize();
  // E.endDraw(); // write out the file
  save(fileName + ".png");
}

void draw() {
  E.beginDraw(); 
  E.clear();
  E.strokeWeight(5); 
  E.fill(0, 0, 0); 
  E.noStroke();

  int rowCount = 2;
  int colCount = rowCount;
  int size = 300;
  int firstCoordinate = 200;
  String mode = "square";
  
  // this is weird way to do this, idk what i'd rather do
  PerlinReimplemented pr = new PerlinReimplemented();
  PerlinPlayground pp = new PerlinPlayground();

  E.HATCH_MODE = PEmbroiderGraphics.VECFIELD;
  E.HATCH_VECFIELD = pp;
  E.HATCH_SPACING = 8;
  E.HATCH_SCALE = 0.5;

  // E.HATCH_SPACING = int(random(10,20));
  // E.HATCH_SCALE = int(random(1,10));

  // circle grid
  if (mode == "circle") {
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < colCount; j++) {
        
        int xPad = firstCoordinate * (i + 1);
        int x = i * size/2 + xPad;
        
        int yPad = firstCoordinate * (j + 1);
        int y = j * size/2 + yPad;
        
        E.circle(x, y, size);
      }
    }
  } else {
    E.rect(0, 0, width, height);
  }
}

// Playing around with different vector fields
//-----------------------
// The VECFIELD hatch mode allows you to create a 
// user-defined vector field, with a function that 
// returns a 2D vector indicating the local orientation
// of stitches at any given point (x,y). 
//--------------------------------------------

// re-implementing perlin in attempts to understand what's up
// https://github.com/CreativeInquiry/PEmbroider/blob/f0dc0759fbc8b40034c894849f26835ccacfe98d/src/processing/embroider/PEmbroiderGraphics.java#L4847
class PerlinReimplemented implements PEmbroiderGraphics.VectorField {
  public PVector get(float x, float y) {
    float perlinScale = 0.1f;
    float deltaX = 20; // step size of the walk in vector field
    float a = noise(x*perlinScale ,y*perlinScale,1f) * 2 * PI - PI;
    float r = noise(x*perlinScale ,y*perlinScale,2f) * deltaX;
    float dx = cos(a) * r;
    float dy = sin(a) * r;
    return new PVector(dx,dy);
  }
}

// changing variables around until i'm happy 
class PerlinPlayground implements PEmbroiderGraphics.VectorField {
  public PVector get(float x, float y) {
    float perlinScale = 10;
    // float deltaX = int(random(10,20));
    float deltaX = 200;
    float a = noise(x*perlinScale ,y*perlinScale,1) * PI/4;
    float r = noise(x*perlinScale ,y*perlinScale,0) * deltaX;
    float dx = cos(a) * r;
    float dy = sin(a) * r;
    return new PVector(dx,dy);
  }
}
