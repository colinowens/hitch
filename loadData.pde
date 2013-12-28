String[] rows;
String lastName;
int count;

void loadData(int d) {
  rows = loadStrings("composers.txt");
  //  temp = new String[rows.length];
  for (int i=0; i < d;i++) {
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

void reSort() {
  int g = p.length;
  for (int i = g-1; i >= 0; i--) {
    if (p[i].nodeName == "null") {
      p = (Hitch[]) shorten(p);
    }
  }
  for (int i=0;i < p.length;i++) p[i].make(p);
}

