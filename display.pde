PShape ss;
PFont font;
PFont font2;

int num = 16;

Hitch[] p = new Hitch[num];

void setup() {
  size(displayWidth, displayHeight);
  smooth();

  for (int i=0;i < p.length;i++) p[i] = new Hitch(p.length, i, p, this);

  loadData(num); 

  // Arrays.sort(p, new BirthDateComparator());
  Arrays.sort(p, new DeathDateComparator());
  // Arrays.sort(p, new IdComparator());

  for (int i=0;i < p.length;i++) {
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
void draw() {
  background(255);

  for (int i=0;i < p.length;i++) {

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


void printMe() {
  for (int i=0;i < p.length;i++) {
    print(p[i].id + "  " + p[i].nodeName + " - parent - " + p[i].nodeParent[0]);

    println("**");
  }
}

