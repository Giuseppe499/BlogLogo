/*
BetaNab's blog logo
Copyright (C) 2021  Giuseppe Scarlato

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

PGraphics logo;

//Palette https://coolors.co/000000-14213d-fca311-e5e5e5-ffffff
color black   = #000000;
color blue    = #14213d;
color yellow  = #fca311;
color gray    = #e5e5e5;
color white   = #ffffff;

int logoSize = 512;

// Gear variables
float d;  // gear inner diameter
int nTeeth; // number of teeths
float ratioTooth; // teeth low segment divided by big segment
float widthTooth; // big segment size

void settings(){
  size(logoSize, logoSize);
}

void setup(){
  // Init gear variables
  d = width * 0.75; // gear inner diameter
  nTeeth = 7; // number of teeths
  ratioTooth = 0.75; // teeth low segment divided by big segment
  widthTooth = PI * d / ( nTeeth * ( 1 + ratioTooth) ); // big segment size
  noLoop();
}

//Gear Theet
PShape tooth(){
    PShape tooth = createShape();
    tooth.beginShape();
    tooth.fill(blue);
    tooth.noStroke();
    tooth.vertex(-widthTooth * 0.5, 0);
    tooth.vertex(widthTooth * 0.5, 0);
    tooth.vertex(widthTooth * ratioTooth * 0.5, width * 0.5 - d * 0.5);
    tooth.vertex(-widthTooth * ratioTooth * 0.5, width * 0.5 - d * 0.5);
    tooth.endShape(CLOSE);
    return tooth;
}

void draw(){
  // Logo
  logo = createGraphics(width, height);
  logo.beginDraw();
  {
    logo.background(255, 0);
    logo.translate(width/2, height/2);
    logo.noStroke();
    
    // Gear teeths
    PShape tooth = tooth();
    for(int i = 0; i < nTeeth; i = i+1){
      logo.shape(tooth, 0, sqrt(d * d - widthTooth * widthTooth) * 0.5 );
      logo.rotate( TAU / nTeeth );
    }
    
    //Gear Center
    logo.fill(yellow);
    logo.circle(0, 0, d);
    
    //Text
    PFont font = createFont("TheNextFont.ttf", d);
    logo.textFont(font);
    
    logo.textAlign(CENTER);
    logo.textSize(d);
    logo.fill(blue);
    logo.text("B", d*0.02, d * 0.36);
  }
  logo.endDraw();
  
  // Save logo
  logo.save("logo.png");
  
  // Draw logo on screen
  image(logo, 0, 0);
}
