int cols, rows;
int scl;
int w = 1200;
int h = 900;
float[][] landscape;
float increment = 0.1;
Letter[][] letters;

PFont mFont;

int totalFrames = 780;
int counter = 0;
boolean recording = true;

OpenSimplexNoise noise;

void setup() {
  size(600, 600, P3D);
  scl = 20;
  cols = w/scl;
  rows = h/scl;
  landscape = new float[cols][rows];
  letters = new Letter[cols][rows];
  
  mFont = createFont("FORCED_SQUARE.ttf", 48);
  noise = new OpenSimplexNoise();
}

void draw() {
  float percent = 0;
  if (recording) {
    percent = float (counter) / totalFrames;
  } else {
    percent = float (counter % totalFrames) / totalFrames;
  }
  render(percent);

  if (recording) {
    saveFrame("output/gif-"+nf(counter, 3)+".png");
    if (counter == totalFrames-1) {
      exit();
    }
  }
  counter++;
}

void render(float percent) {
  float angle = map(percent, 0, 1, 0, TWO_PI);
  float uoff = map(sin(angle), -1, 1, 0, 2);
  float voff = map(sin(angle), -1, 1, 0, 2);
  
  float yoff = 0;
  for(int y=0; y<rows; y++){
    float xoff = 0;
    for(int x=0; x<cols; x++){
      float n = (float) noise.eval(xoff, yoff, uoff, voff);
      landscape[x][y] = map(n, -1, 1, -50, 100);
      letters[x][y] = new Letter(n, xoff, yoff);
      xoff += increment; 
    }
    yoff += increment;
  }
  
  background(20);
  translate(width/2, height/2);
  translate(-w/2, -h/2);
  
  for(int y=0; y<rows-1; y++){
    for(int x=0; x<cols-1; x++){
      Letter l1 = letters[x][y];
      Letter l2 = letters[x+1][y];
      if (l1.isOverlapping(l2)) {
        landscape[x][y] -= increment;
      }
      if (l2.isOverlapping(l1)) {
        landscape[x+1][y] -= increment;
      }
      l1.render(x*scl, y*scl, landscape[x][y]);
      l2.render((x+1)*scl, (y)*scl, landscape[x+1][y]);
    }
  }
}
