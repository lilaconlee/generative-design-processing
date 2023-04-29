import processing.embroider.*;
PEmbroiderGraphics E;

int almost4Inches = 916;

// STUFF THAT'S GOOD TO CHANGE
String imgFileName = "test2.bmp"; // change to your file name
float scale = 1; // how much to scale the pattern up by

void setup() {
  noLoop(); 
  size(916, 916); // a little less than the 4x4 hoop size
  E = new PEmbroiderGraphics(this, width, height);
  

  String projectTitle = "bitmap-test";
  String imgWithoutExt = imgFileName.substring(0, imgFileName.lastIndexOf('.'));
  String outputFileName = projectTitle + "_" + imgWithoutExt + "_" + str(int(random(10000)));
  
  // PES
  String outputFilePath = pesSetup(outputFileName);
  // SVG
  // String outputFilePath = svgSetup(outputFileName);

  // load img from above filename
  PImage photo = loadImage(imgFileName); 
  image(photo, 0, 0, almost4Inches,almost4Inches); 

  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();
  E.fill(0, 0, 0); 
  E.noStroke(); 
  E.scale(scale);

  draw(photo);
  
  E.optimize(); // slow, but good and important
  E.visualize();
  E.endDraw(); // write out the file
  save(outputFileName + ".png");
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

void draw(PImage img) {
  //-------------------
  // Dense concentric hatch from bitmap_image_1
  E.hatchMode(PEmbroiderGraphics.CONCENTRIC); 
  E.hatchSpacing(2.0);
  /* About setStitch from: https://github.com/CreativeInquiry/PEmbroider/blob/f0dc0759fbc8b40034c894849f26835ccacfe98d/PEmbroider_Cheat_Sheet.md
  The setStitch() function is super-important! It allows you to set the following:

    the minimum stitch length (in machine units; for our machine, this is 0.1mm)
    the desired stitch length (in machine units)
    the amount of noise (0...1) affecting stitch length. (This can be helpful for dithering the stitches in fills, so that they don't all line up.)

    E.setStitch(minLength, desiredLength, noise);
  */
  E.setStitch(5, 20, 1.0);
  // E.image(img, x, y);
  E.image(img, 0, 0, almost4Inches,almost4Inches);

  /** trying to scale up the pattern, but keep it centered (doesn't work)
  int offset = 30; // attempt to scale up pattern to extend pattern past the bitmap
  int offset = int(((almost4Inches * scale) - almost4Inches)/2);
  E.image(img, 0 - offset, 0 - offset, almost4Inches,almost4Inches);
  E.image(img, 0 - offset, 0 - offset);
  **/
}
