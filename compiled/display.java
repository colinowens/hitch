import processing.core.*; 
import processing.xml.*; 

import java.util.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class display extends PApplet {

PShape ss;
PFont font;
PFont font2;

int num = 48;

Hitch[] p = new Hitch[num];

public void setup() {
  size(displayWidth, displayHeight);
  smooth();

  for (int i=0;i <  p.length;i++) p[i] = new Hitch(p.length, i, p, this);

  loadData(num); 

  // Arrays.sort(p, new BirthDateComparator());
  Arrays.sort(p, new DeathDateComparator());
  // Arrays.sort(p, new IdComparator());

  for (int i=0;i <  p.length;i++) {
   //   p[i].horizon(width, 200, 20);
    p[i].radial(300, i);
    p[i].circleSize(4);
    p[i].textLabelAlign("RADIAL");
    p[i].textLabelRotate(PI/2);
  }
  ss = loadShape("test.svg");
  font = loadFont("serif.vlw");
  font2 = loadFont("AGaramondPro-Bold-48.vlw");

  // p[25].over = true;
  // p[25].textLabelOverColor = color(0, 180, 0);
  printMe();
}
public void draw() {
  background(255);

  for (int i=0;i <  p.length;i++) {

    p[i].textLabelOffsetX(50);
    p[i].textLabelOffsetY(2); 

    if (p[i].dateDeath.equals("3000")) {

      p[i].textLabelColor(color(255, 0, 0));
      p[i].textLabel(p[i].dateBirth + "\t\t\t" + p[i].nodeName, font2, 20, i);
    } 
    else
      p[i].textLabelOffsetX(10);
    p[i].textLabelColor(color(0, 90));
    p[i].textLabel(p[i].dateBirth + "\t\t\t" + p[i].nodeName, font2, 20, i);
    p[i].circle();
    p[i].update();
    p[i].connect();
  }
}


public void printMe() {
  for (int i=0;i <  p.length;i++) {
    print(p[i].id + "  " + p[i].nodeName);
    for (int j=0;j <  p[i].parentID.length;j++) {

      print(" - " + p[i].getParentID(j) + " " + p[i].nodeParent[j]);
    }
    println("**");
  }
}



class Hitch extends Data implements Comparable{
  
  private PApplet parent; 

  int circleFillColor, circleStrokeColor, circleOverFillColor, circleOverStrokeColor;
  float circleStrokeWeight, circleSize, circleOverStrokeWeight, circleOverSize;

  int rectangleFillColor, rectangleStrokeColor, rectangleOverFillColor, rectangleOverStrokeColor;
  float rectangleStrokeWeight, rectangleSize, rectangleOverStrokeWeight, rectangleOverSize;

  int textLabelColor, textLabelOverColor;
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

    public void radial(int rad, int inid) {
    float d = 360.0f/arraySize;
    float g = d*inid;
    x = cos(radians(g)) * rad + width/2;
    y = sin(radians(g)) * rad + height/2;
  }
  public void horizon(float lineWidth, int lineY, int inid) {
    float g = lineWidth/arraySize;
    x = g*id;
    y = lineY;
  }
  public void grid(int gridWidth, int gridColumns, int inid) {
    int xx = gridWidth/gridColumns;
    // to do
  }
  public void plot(float flX, float flY, int inid) {
    // to do
  }

  // Node Shape

  // Setters 

  public void circleFillColor(int inc) {
    circleFillColor = inc;
  }
  public void circleOverFillColor(int inc) {
    circleOverFillColor = inc;
  }
  public void circleStrokeColor(int inc) {
    circleStrokeColor = inc;
  }
  public void circleOverStrokeColor(int inc) {
    circleOverStrokeColor = inc;
  }
  public void circleStrokeWeight(float fl) {
    circleStrokeWeight = fl;
  }
  public void circleOverStrokeWeight(float fl) {
    circleOverStrokeWeight = fl;
  }
  public void circleSize(float fl) {
    circleSize = fl;
  }
  public void circleOverSize(float fl) {
    circleOverSize = fl;
  }

  public void rectangleFillColor(int inc) {
    rectangleFillColor = inc;
  }
  public void rectangleOverFillColor(int inc) {
    rectangleOverFillColor = inc;
  }

  public void rectangleStrokeColor(int inc) {
    rectangleStrokeColor = inc;
  }
  public void rectangleOverStrokeColor(int inc) {
    rectangleOverStrokeColor = inc;
  }

  public void rectangleStrokeWeight(float fl) {
    rectangleStrokeWeight = fl;
  }
  public void rectangleOverStrokeWeight(float fl) {
    rectangleOverStrokeWeight = fl;
  }

  public void rectangleSize(float fl) {
    rectangleSize = fl;
  }
  public void rectangleOverSize(float fl) {
    rectangleOverSize = fl;
  }

  // Display

  public void circle() {
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
  public void rectangle() {
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
  public void svg(PShape inShape, float inW, float inH) {
    shapeMode(CENTER);
    shape(inShape, x, y, inW, inH);
  } 

  // Text Labels

  // Setters

  public void textLabelColor(int inc) {
    textLabelColor = inc;
  }
  public void textLabelOverColor(int inc) {
    textLabelOverColor = inc;
  }
  public void textLabelOverSize(float fl) {
    textLabelOverSize = fl;
  }
  public void textLabelOffsetX(float fl) {
    textLabelOffsetX = fl;
  }
  public void textLabelOffsetY(float fl) {
    textLabelOffsetY = fl;
  }
  public void textLabelAlign(String s) {
    textLabelAlign = s;
  }
  public void textLabelRotate(float fl) {
    textLabelRotate = fl;
  }

  // Display

  public void textLabel(String s, PFont p, float inSize, int inid) {
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
    else if (textLabelRotate >  0 || textLabelRotate <  0) textRotate(s);
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

  public void connect() {

    for (int j = 0;j <  nodeParent.length;j++) {
      if (parentX[j] >  0) {
        
      strokeWeight(.5f);
      if(id == 70) strokeWeight(5);
      fill(266,0,0);ellipse(x,y,10,10);
        stroke(0);
       // line(x, y, parentX[j], parentY[j]);
        noFill();
        beginShape();
        vertex(x, y);
        bezierVertex(x, y, width/2, height/2, parentX[j], parentY[j]);
        vertex(parentX[j], parentY[j]);
        endShape();
      }
    }
  }
  public void grouping() {
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

  public int getID() { 
    return id;
  }
  
  public int getParentID(int j) {
   return parentID[j]; 
  }

  // array expander

  public void expandParent() {
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

  public void make(Hitch [] Hitchin) {
    arraySize = Hitchin.length;
    others = Hitchin;
    for (int j = 0;j <  nodeParent.length;j++) {
      for (int i = 0;i <  arraySize;i++) {
        if (nodeParent[j].equals(others[i].nodeName)) {
          parentID[j] = others[i].id;
          parentX[j] = others[i].x;
          parentY[j] = others[i].y;
        }
      }
    }
  }
  public void update() {
    for (int j = 0;j <  nodeParent.length;j++) {
      for (int i = 0;i <  arraySize;i++) {
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
  public int compare(Object o, Object p)
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
  public int compare(Object o, Object p)
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
  public int compare(Object o, Object p)
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
  public int compare(Object o, Object p)
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

String[] rows;
String lastName;
int count;

public void loadData(int d) {
  rows = loadStrings("composers.txt");
  //  temp = new String[rows.length];
  for (int i=0; i <  d;i++) {
    String[] pieces = split(rows[i], '\t');
    String[] parent = split(pieces[0], ';');
    String[] node = split(pieces[1], ';');
    String[] nodeDates = split(node[1], '-');
    if (node[0].equals(lastName)) {
      p[count].expandParent();
      p[count].nodeParent[p[count].nodeParent.length-1] = parent[0];
      lastName = node[0];
    }
    else { 
      p[count].nodeParent[0] = parent[0];
      String[] birth = match(node[1], "\\d+");

      String[] x2 = split(node[1], "-");
      String[] death = match(x2[1], "\\d+");
     // println(death);

      p[count].nodeName = node[0];
      lastName = node[0];
      p[count].dateBirth = birth[0]; 
      if (death != null)p[count].dateDeath = death[0]; // some people aren't dead yet so they'll return a null
      else p[count].dateDeath = "3000"; // so let's assign them a place amongst the living!
      count++;
    }
    
  }
  reSort();
}

public void reSort() {
  int g = p.length;
  for (int i = g-1; i >= 0; i--) {
    if (p[i].nodeName == "null") {
      p = (Hitch[]) shorten(p);
    }
  }
  for (int i=0;i <  p.length;i++) p[i].make(p);
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "display" });
  }
}
