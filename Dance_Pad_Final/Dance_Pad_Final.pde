PFont Helvetica;
String[] digits;
String[] html;
String url = "http://asterisk.itp-redial.com/~arc507/sinatra/gamecontroller/all";
int digitsPositionCounter=0;
color c;

int cr = 30; //color transparancy of red 
int cb = 30; //color transparancy of blue
int cg = 30; //color transparancy of green
int cy = 30; //color transparancy of yellow

void setup() {
  size(1000, 900);
  smooth();
  noStroke();
  frameRate(2);
  getNewDigits();
  Helvetica = loadFont("Helvetica-Light-48.vlw");
}

void draw() {
  background(255);
  textFont(Helvetica);
 
  //Logo
  textSize(20);
  fill(20);
  text("Dial Dance Revolution", width-220, height-40);
  stroke(1);
  line(width-260, height-30, width, height-30);
  line(width-240, height-20, width, height-20);
  noStroke();
  
  //telephone number to call
  textSize(23);
  fill(20);
  text("Call 917-534-646 extension -13", width-width+30, height-height+50);
  text("to add your own steps", width-width+30, height-height+80);
  text("for some footloose fun!", width-width+30, height-height+110);

  //to be called every time 'digits' runs out
  if (digits.length <= digitsPositionCounter) {
    getNewDigits();
  }

  //check if number is more than one digit
  int parsedNumber = Integer.parseInt(digits[digitsPositionCounter]);   

  if (parsedNumber >= 10) {
    myDelay(5000);
    textSize(50);
    c = color(0);
    fill(c);
    text("Now Dance!", 50, 50);
  } 
  else { //number is definitely a single digit
    c= color(255);
    switch (parsedNumber) {
    case 2:
      cy = 255;
      cr = 50;
      cb = 50;
      cg = 50;
      break;
    case 4:
      cr = 255;
      cb = 50;
      cg = 50;
      cy = 50;
      break;
    case 6:
      cb = 255;
      cr = 50;
      cg = 50;
      cy = 50;
      break; 
    case 8:
      cg = 255;
      cy = 50;
      cr = 50;
      cb = 50;
      break;
    default:
      break;
    }
  }

  fill(255, 0, 0, cr);
  rect(width/5, (height/5)*2, width/5, height/5, 7);

  fill(44, 180, 54, cg);
  rect(width/5*2, (height/5)*3, width/5, height/5, 7);

  fill(0, 0, 255, cb);
  rect(width/5*3, (height/5)*2, width/5, height/5, 7);

  fill(250, 255, 0, cy);
  rect((width/5)*2, height/5, width/5, height/5, 7);
  noStroke();

  digitsPositionCounter++;
}

//Updates the digits upon request. Returns nothing
void getNewDigits() {
  html = loadStrings(url);
  println(html);
  digits = split(html[0], ","); //we only have one line of HTML. TODO:CHANGE
  println(digits);
}

void myDelay(int ms)
{
  try
  {    
    Thread.sleep(ms);
  }
  catch(Exception e) {
  }
}

