import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  noLoop(); 
  size (1000, 1000);
  E = new PEmbroiderGraphics(this, width, height);

  String outputFilePath = sketchPath("vecfield.pes");
  E.setPath(outputFilePath); 

  draw();

  //-----------------------
  //E.optimize(); // slow, but good and important
  E.visualize();
  //E.endDraw(); // write out the file
  //save("PEmbroider_shape_hatching_2.png");
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
  
  for (int i = 0; i < rowCount; i++) {
    for (int j = 0; j < colCount; j++) {
      MyVecField mvf = new MyVecField();
      E.HATCH_MODE = PEmbroiderGraphics.VECFIELD;
      E.HATCH_VECFIELD = mvf;
      // E.HATCH_SPACING = 4;
      E.HATCH_SPACING = int(random(10,20));
      E.HATCH_SCALE = int(random(1,10));
      
      int xPad = firstCoordinate * (i + 1);
      int x = i * size/2 + xPad;
      
      int yPad = firstCoordinate * (j + 1);
      int y = j * size/2 + yPad;
      
      E.circle(x, y, size);
    }
  }
}

  //-----------------------
  // The VECFIELD hatch mode allows you to create a 
  // user-defined vector field, with a function that 
  // returns a 2D vector indicating the local orientation
  // of stitches at any given point (x,y). 
  // See the MyVecField class below.
//--------------------------------------------
class MyVecField implements PEmbroiderGraphics.VectorField {
  public PVector get(float x, float y) {
    x*=0.5;
    return new PVector(1, 0.5*sin(x));
  }
}
