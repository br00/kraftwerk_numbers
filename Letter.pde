class Letter {
  
  float xoff, yoff;
  float cx, cy;
  float diameter;
  int num;
  
  Letter(float noise, float xoff, float yoff) {
    this.xoff = xoff;
    this.yoff = yoff;
    num = (int)map(noise,-1, 1, 0, 9);
  }
  
  void render(float cx, float cy, float diameter) {
    this.cx = cx;
    this.cy = cy;
    this.diameter = diameter;
    stroke(245);
    noFill();
    textFont(mFont);
    int size = (int)map(diameter, -50, 100, 0, 40);
    textSize(size);
    text(num, cx-diameter/2, cy-diameter/2);
  }
  
  boolean isOverlapping(Letter closeLetter) {
    boolean overlapping = false;
    for(int k=0; k<rows; k++){
        for(int w=0; w<cols; w++){
          Letter other = letters[w][k];
          if (this != other && this != closeLetter) {
            float d1 = dist(this.cx, this.cy, other.cx, other.cy);
            if (d1 < this.diameter + other.diameter) {
              overlapping = true;  
            }
          }
        }
      }
    return overlapping;
  }
}
