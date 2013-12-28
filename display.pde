PShape ss;
PFont font;
PFont font2;

int num = 150;

Hitch[] p = new Hitch[num];

void setup() {
  size(displayWidth, displayHeight, "processing.core.PGraphicsRetina2D");
  smooth();

  for (int i=0;i < p.length;i++) p[i] = new Hitch(p.length, i, p, this);

  loadData(num); 

  for (int i=0;i < p.length;i++) {
   //   p[i].horizon(width, 200, 20);
    p[i].radial(300, i);
    p[i].circleFillColor(color(0,60,0));
    p[i].circleSize(3);
    p[i].circleStrokeWeight(0);
    p[i].textLabelAlign("RADIAL");
  }
  ss = loadShape("test.svg");
  font = loadFont("serif.vlw");
  font2 = loadFont("AGaramondPro-Bold-48.vlw");
  printMe();
}
void draw() {
  background(255);
  for (int i=0;i < p.length;i++) {
    p[i].textLabelOffsetX(20);
    p[i].textLabelOffsetY(0); 
    if (p[i].dateDeath.equals("3000")) {
      p[i].textLabelColor(color(255, 0, 0));
      p[i].textLabel(p[i].dateBirth + "\t\t\t" + p[i].nodeName, font2, 10, i);
    } 
    else
      p[i].textLabelOffsetX(10);
    p[i].textLabelColor(color(0, 90));
    p[i].textLabel(p[i].dateBirth + "\t\t\t" + p[i].nodeName, font2, 10, i);
    p[i].circle();
    //p[i].svg(ss, 10, 10);
    p[i].update();
    p[i].connect();
  }
}


void printMe() {
  for (int i=0;i < p.length;i++) {
    print(p[i].id + "  " + p[i].nodeName + " - parent - " + p[i].nodeParent[0]);
  }
}

void keyPressed() {
  if (key == '1') Arrays.sort(p, new BirthDateComparator());
  if (key == '2') Arrays.sort(p, new DeathDateComparator());
  if (key == '3') Arrays.sort(p, new IdComparator()); 
    for (int i=0;i < p.length;i++) { p[i].update();    p[i].radial(300, i);}
}

