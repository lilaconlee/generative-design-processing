import processing.embroider.*;
PEmbroiderGraphics E;

int almost4Inches = 916;

// STUFF THAT'S GOOD TO CHANGE
String imgFileName = "reaction-diffusion.bmp"; // change to your bmp file name
String photoFileName = "reaction-diffusion.bmp"; // change to your color photo file name
float scale = 1; // how much to scale the pattern up by
float strokeWeight = 30;
float strokeSpacing = 3;

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

  // load img & photo from above filename
  PImage photo = loadImage(photoFileName);
  PImage bmp = loadImage(imgFileName);
  image(photo, 0, 0, almost4Inches,almost4Inches); 

  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();
  E.fill(0, 0, 0); 
  E.noStroke(); 
  E.scale(scale);

  draw(bmp);
  
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
  // EXTREMELY MESSY CODE BELOW todo: get good
  //-------------------
  // Dense concentric hatch from bitmap_image_1
  E.stroke(0, 0, 0); // not sure exactly what the params are here
  // E.strokeWeight(30); 
  // E.strokeSpacing(4);
  E.hatchMode(PEmbroiderGraphics.CONCENTRIC); 
  E.hatchSpacing(3);
  // E.setStitch(5, 20, 1.0);
  /* About setStitch from: https://github.com/CreativeInquiry/PEmbroider/blob/f0dc0759fbc8b40034c894849f26835ccacfe98d/PEmbroider_Cheat_Sheet.md
  The setStitch() function is super-important! It allows you to set the following:

    the minimum stitch length (in machine units; for our machine, this is 0.1mm)
    the desired stitch length (in machine units)
    the amount of noise (0...1) affecting stitch length. (This can be helpful for dithering the stitches in fills, so that they don't all line up.)

    E.setStitch(minLength, desiredLength, noise);
  */

  //-------------------
  // Based on bitmap_image_1
  // Draw fat parallel stroke only; no fill. 
  /*
  E.stroke(0, 0, 0); 
  E.noFill(); 
  E.strokeWeight(strokeWeight); 
  E.setStitch(5, 30, 1.0);
  E.strokeMode(PEmbroiderGraphics.TANGENT);
  E.strokeSpacing(4);
  */

    //-------------------
  // Draw fat perpendicular stroke only, no fill. 
  /*
  E.noFill(); 
  E.stroke(0, 0, 0); 
  // E.setStitch(5, 60, 1.0);
  E.strokeWeight(35); 
  E.strokeSpacing(4.5);
  E.strokeMode(PEmbroiderGraphics.PERPENDICULAR);
  */



  // E.image(img, x, y);
  E.image(img, 0, 0, almost4Inches,almost4Inches);

  // trying to scale up the pattern, but keep it centered (doesn't work)
  // int offset = 20; // attempt to scale up pattern to extend pattern past the bitmap
  // int offset = int(((almost4Inches * scale) - almost4Inches)/2);
  // E.image(img, 0 - offset, 0 - offset, almost4Inches,almost4Inches);
}
