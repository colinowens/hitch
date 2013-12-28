import java.util.*;

class Hitch extends Data implements Comparable{
  
  private PApplet parent; 

  color circleFillColor, circleStrokeColor, circleOverFillColor, circleOverStrokeColor;
  float circleStrokeWeight, circleSize, circleOverStrokeWeight, circleOverSize;

  color rectangleFillColor, rectangleStrokeColor, rectangleOverFillColor, rectangleOverStrokeColor;
  float rectangleStrokeWeight, rectangleSize, rectangleOverStrokeWeight, rectangleOverSize;

  color textLabelColor, textLabelOverColor;
  float textLabelSize, textLabelOverSize, textLabelOffsetX, textLabelOffsetY, textLabelRotate;
  PFont textLabelFont;
  String textLabelAlign = "null";



  Hitch(int sizeIn, int idin, int xin, int yin, Hitch [] Hitchin, PApplet parent) {
    this.parent = parent;
    arraySize = sizeIn;
    id = idin;
    x = xin;
    y = yin;
    others = Hitchin;
  }

  Hitch(int sizeIn, int idin, Hitch [] Hitchin, PApplet parent) {
    this.parent = parent;
    arraySize = sizeIn;
    id = idin;
    x = random(width);
    y = random(height);
    others = Hitchin;
  }
  
  public int compareTo(Object op) throws ClassCastException {
    if (!(op instanceof Hitch))
      throw new ClassCastException("A Hitch object expected.");
    int opId = ((Hitch) op).getID();  
    return this.id - opId;
  }
  
  // Layout Pattern

    void radial(int rad, int inid) {
    float d = 360.0/arraySize;
    float g = d*inid;
    x = cos(radians(g)) * rad + width/2;
    y = sin(radians(g)) * rad + height/2;
  }
  void horizon(float lineWidth, int lineY, int inid) {
    float g = lineWidth/arraySize;
    x = g*id;
    y = lineY;
  }
  void grid(int gridWidth, int gridColumns, int inid) {
    int xx = gridWidth/gridColumns;
    // to do
  }
  void plot(float flX, float flY, int inid) {
    // to do
  }

  // Node Shape

  // Setters 

  void circleFillColor(color inc) {
    circleFillColor = inc;
  }
  void circleOverFillColor(color inc) {
    circleOverFillColor = inc;
  }
  void circleStrokeColor(color inc) {
    circleStrokeColor = inc;
  }
  void circleOverStrokeColor(color inc) {
    circleOverStrokeColor = inc;
  }
  void circleStrokeWeight(float fl) {
    circleStrokeWeight = fl;
  }
  void circleOverStrokeWeight(float fl) {
    circleOverStrokeWeight = fl;
  }
  void circleSize(float fl) {
    circleSize = fl;
  }
  void circleOverSize(float fl) {
    circleOverSize = fl;
  }

  void rectangleFillColor(color inc) {
    rectangleFillColor = inc;
  }
  void rectangleOverFillColor(color inc) {
    rectangleOverFillColor = inc;
  }

  void rectangleStrokeColor(color inc) {
    rectangleStrokeColor = inc;
  }
  void rectangleOverStrokeColor(color inc) {
    rectangleOverStrokeColor = inc;
  }

  void rectangleStrokeWeight(float fl) {
    rectangleStrokeWeight = fl;
  }
  void rectangleOverStrokeWeight(float fl) {
    rectangleOverStrokeWeight = fl;
  }

  void rectangleSize(float fl) {
    rectangleSize = fl;
  }
  void rectangleOverSize(float fl) {
    rectangleOverSize = fl;
  }

  // Display

  void circle() {
    if (circleSize <1) circleSize = 10;
    ellipseMode(CENTER);
    if (over) {
      fill(circleOverFillColor);
      stroke(circleOverStrokeColor);
      strokeWeight(circleOverStrokeWeight);
    }
    else {
      fill(circleFillColor);
      stroke(circleStrokeColor);
      strokeWeight(circleStrokeWeight);
    }
    ellipse(x, y, circleSize, circleSize);
  }
  void rectangle() {
    if (rectangleSize <1) rectangleSize = 10;
    rectMode(CENTER);
    if (over) {
      fill(rectangleOverFillColor);
      stroke(rectangleOverStrokeColor);
      strokeWeight(rectangleOverStrokeWeight);
    }
    else {
      fill(rectangleFillColor);
      stroke(rectangleStrokeColor);
      strokeWeight(rectangleStrokeWeight);
    }
    rect(x, y, rectangleSize, rectangleSize);
  }
  void svg(PShape inShape, float inW, float inH) {
    shapeMode(CENTER);
    shape(inShape, x, y, inW, inH);
  } 

  // Text Labels

  // Setters

  void textLabelColor(color inc) {
    textLabelColor = inc;
  }
  void textLabelOverColor(color inc) {
    textLabelOverColor = inc;
  }
  void textLabelOverSize(float fl) {
    textLabelOverSize = fl;
  }
  void textLabelOffsetX(float fl) {
    textLabelOffsetX = fl;
  }
  void textLabelOffsetY(float fl) {
    textLabelOffsetY = fl;
  }
  void textLabelAlign(String s) {
    textLabelAlign = s;
  }
  void textLabelRotate(float fl) {
    textLabelRotate = fl;
  }

  // Display

  void textLabel(String s, PFont p, float inSize, int inid) {
    textLabelFont = p;
    textLabelSize = inSize;
    textFont(textLabelFont, textLabelSize);

    if (over) {
      fill(textLabelOverColor);
    }
    else {
      fill(textLabelColor);
    }
    checkAlign();
    if (textLabelAlign.equals("RADIAL")) textRadial(s, inid);
    else if (textLabelRotate > 0 || textLabelRotate < 0) textRotate(s);
    else text(s, x + textLabelOffsetX, y + textLabelOffsetY);
  }

  // utilities

  private void checkAlign() {
    if (textLabelAlign.equals("LEFT")) textAlign(LEFT);
    else if (textLabelAlign.equals("RIGHT")) textAlign(RIGHT);
    else if (textLabelAlign.equals("CENTER")) textAlign(CENTER);
    else if (textLabelAlign.equals("RADIAL")) textAlign(LEFT);
    else textAlign(LEFT);
  }
  private void textRadial(String s, int inid) {
    float delta = TWO_PI / arraySize;
    pushMatrix();
    translate(x, y);
    rotate(delta * inid); // change later to n1?
    text(s, textLabelOffsetX, textLabelOffsetY);
    popMatrix();
  }
  private void textRotate(String s) {
    pushMatrix();
    translate(x, y);
    rotate(textLabelRotate);
    text(s, textLabelOffsetX, textLabelOffsetY);
    popMatrix();
  }

  void connect() {

    for (int j = 0;j < nodeParent.length;j++) {
      if (parentX[j] > 0) {
        
      strokeWeight(.05);
        stroke(255,0,0);
        noFill();
        beginShape();
        vertex(x, y);
        bezierVertex(x, y, width/2, height/2, parentX[j], parentY[j]);
        vertex(parentX[j], parentY[j]);
        endShape();
      }
    }
  }
  void grouping() {
  }
}

class Data  {
  float x, y;
  int id, arraySize;
  int[] parentID = new int[1];
  public float[] parentX = new float[1];
  float[] parentY = new float[1];

  int[] childID = new int[1];

  boolean over = false;
  boolean visible = true;

  String nodeName = "null";
  String dateBirth, dateDeath;
  String[] nodeParent = new String[1];
  String[] nodeChild = new String[1];
  String[] dateParentDeath = new String[1];
  String[] dateChildDeath = new String[1];

  Hitch[] others;

  // Getter

  int getID() { 
    return id;
  }
  
  int getParentID(int j) {
   return parentID[j]; 
  }

  // array expander

  void expandParent() {
    nodeParent = expand(nodeParent, nodeParent.length+1);
    parentID = expand(parentID, parentID.length+1);
    parentX = expand(parentX, parentX.length+1);
    parentY = expand(parentY, parentY.length+1);
  }

  // Sorter
/*
  public int compareTo(Object op) throws ClassCastException {
    if (!(op instanceof Hitch))
      throw new ClassCastException("A Hitch object expected.");
    int opId = ((Hitch) op).getID();  
    return this.id - opId;
  }
*/
  // ID and coordinate assignment

  void make(Hitch [] Hitchin) {
    arraySize = Hitchin.length;
    others = Hitchin;
    for (int j = 0;j < nodeParent.length;j++) {
      for (int i = 0;i < arraySize;i++) {
        if (nodeParent[j].equals(others[i].nodeName)) {
          parentID[j] = others[i].id;
          parentX[j] = others[i].x;
          parentY[j] = others[i].y;
        }
      }
    }
  }
  void update() {
    for (int j = 0;j < nodeParent.length;j++) {
      for (int i = 0;i < arraySize;i++) {
        if (nodeParent[j].equals(others[i].nodeName)) {
          parentID[j] = others[i].id;
          parentX[j] = others[i].x;
          parentY[j] = others[i].y;
        }
      }
    }
  }
}

public class BirthDateComparator implements Comparator {
  int compare(Object o, Object p)
  {
    Hitch o1=(Hitch)o;
    Hitch p1=(Hitch)p;
    int o1Birth = Integer.parseInt(o1.dateBirth);
    int p1Birth = Integer.parseInt(p1.dateBirth);
    if (o1Birth>p1Birth)  
      return 1;
    if (o1Birth==p1Birth)
      return 0;
    else
      return -1;
  }
}

public class DeathDateComparator implements Comparator {
  int compare(Object o, Object p)
  {
    Hitch o1=(Hitch)o;
    Hitch p1=(Hitch)p;
    int o1Death = Integer.parseInt(o1.dateDeath);
    int p1Death = Integer.parseInt(p1.dateDeath);
    if (o1Death>p1Death)  
      return 1;
    if (o1Death==p1Death)
      return 0;
    else
      return -1;
  }
}

public class InfluenceComparator implements Comparator {
  int compare(Object o, Object p)
  {
    Hitch o1=(Hitch)o;
    Hitch p1=(Hitch)p;
    if (o1.parentID.length>p1.parentID.length)  
      return 1;
    if (o1.parentID.length==p1.parentID.length)
      return 0;
    else
      return -1;
  }
}

public class IdComparator implements Comparator {
  int compare(Object o, Object p)
  {
    Hitch o1=(Hitch)o;
    Hitch p1=(Hitch)p;
    if (o1.id>p1.id)  
      return 1;
    if (o1.id==p1.id)
      return 0;
    else
      return -1;
  }
}

