//44434065 Runde Jia
float[] plX = new float[5];
float[] plY = new float[5];
int[] plDia = new int[5]; 
float[]speed = new float[5];
color[] col = new color[5];
int[] dir = new int[5];
float[] angle = new float[5];
int[] orbitX = new int[5];
int[] orbitY = new int[5];
int[] orbDia = new int[5];
int flame;                    // number of flame
int hit;                    // number of hit
int planetCount;
int sunX;
int sunY;
int x;                                //substitution of sunX
float flameX;
float flameY;
boolean flameSwitch;                        //use to control flame fire or not
boolean hitCheck;                       // use to check collision

void setup(){
  planetCount = 5;                         // initial value of planet
  hit = 0;                                 // initial value of hit
  sunX = width/2;
  sunY = 30;                               // initial value of sun
  x = width/2;
  flame = 5;                               //initial value of flame
  flameY = 50;                             //Y coordinate of flame
  size(400,400);
  background(4, 235, 247);                 // space
  flameSwitch = false;                    // initial value of flameSwitch to control flame
  for (int i = 0; i < 5; i++){
    angle[i] = random(2*PI);              //random angles
    speed[i] = random(0.05,0.1);          //random speeds
    col[i] = color(random(255),random(255),random(255));  //random colors 
    orbDia[i] = 20* (i+1);
    dir[i] = int(random(-2,0));
    if (dir[i] == 0)
    dir[i] = 1;                          // give random direction s
    plDia[i] = 20;
    orbitX[i] = width/2;                 // give related random values to 5 planets and 5 orbits
    orbitY[i] = height/2;
  }                           
}

void keyPressed(){
  if (keyCode == LEFT)
  x = x - 1;                          //sun motion
  else if (keyCode == RIGHT)
  x = x + 1;                          //sun motion
  if (keyCode == DOWN){
  if (flameY ==50 && flame > 0){      // flame fire control
  flameSwitch = true;
  flame();                            // Check condition of flame -1 or not
  flameX = sunX;                      //Flame fire from sun
   }
 }                     
}          

void flame(){ 
  if (flameSwitch == true && flame>0 && planetCount > 0)
    flame = flame - 1;       // Check condition of flame -1 or not
}

void draw(){
  Background();
  sunFlame();
  gameover();
}

void Background(){                      //Task A
  sunX = constrain(x,25,width-25); //limit Sun in the window
  background(49, 154, 252);  //sky
  noStroke();
  fill(202,252,2);
  ellipse(sunX,sunY,25,25); //sun
  fill(244,247,158,50);
  ellipse(sunX,sunY,50,50);   //glow
  fill(18, 71, 33);
  ellipse(width/2,height,width,100);  //earth
  for (int i = 0; i < 5; i++){
   plX[i] = orbitX[i] + sin(angle[i]) * orbDia[i];    //Planet X
   plY[i] = orbitY[i] + cos(angle[i]) * orbDia[i];    //Planet Y
   angle[i] = angle[i] + speed[i]*dir[i];
   stroke(19, 249, 246);
   noFill();
   ellipse(orbitX[i],orbitY[i],orbDia[i]*2,orbDia[i]*2);   //Orbits
   fill(col[i]);
   noStroke();
   collision();
   ellipse(plX[i],plY[i],plDia[i],plDia[i]);           // planets
 }
}


void sunFlame(){                          //Task B
  fill(0);
  textSize(15);
  text("Flames = "+flame,15,30);         // flames counting text
  text("Hit = "+hit,15,50);              //hit counting text
  if (flameSwitch == true && flame >= 0){
  flameY = flameY + 5;                   // flame motion
    }                            
  if (flameY > 400 && flame > 0){
  flameSwitch =! flameSwitch;
  flameY = 50;                          // flame refill
  hitCheck = false;
  }       
  noFill();
 if (flameSwitch == true)
 fill(255);                                 // fire flame
 noStroke();
 ellipse(flameX,flameY,5,10);                // flame value
}

void collision(){                          //Task C
  float distance;
  for (int i =0; i < 5; i++){
   distance = dist(flameX,flameY,plX[i],plY[i]);      // distance between planet and flame
   if (distance <= (5+plDia[i]/2) && distance > 5 && hitCheck == false){
   hit = hit + 1;
   hitCheck = true;                            // hit +1 if collide
   } 
   if (distance <= (5+plDia[i]/2) && distance > 5 ){
   fill(255,0,0);
   ellipse(plX[i],plY[i],plDia[i],plDia[i]);      // red when collision
   plDia[i] = 0;
   planetCount = planetCount - 1;                 //Disappear the planet
   }                                              // Check collision
   }
}

void gameover(){          //Task D
   if (flame == 0){
   if (flameY >= 400){            // control the flame fall down untill edge in last flame
   background(0);
   textSize(20);
   fill(255);
   text("Game Over",150,40);
   text("Remaining flames: "+flame,100,80);
   text("Remaining planets: "+planetCount,100,120);
   text("Number of hits: "+hit,100,160);
   } 
   }                                        // if flame is 0, game over
  if (planetCount == 0){
  background(0);
   textSize(20);
   fill(255);
   text("Game Over",150,40);
   text("Remaining flames: "+flame,100,80);
   text("Remaining planets: "+planetCount,100,120);
   text("Number of hits: "+hit,100,160);        //if planet is 0, game over
}
}