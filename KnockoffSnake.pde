boolean paused;
boolean startgame;

player p;
coin c;
object[] o = new object[255];
int level;

void setup() {
  fullScreen();
  frameRate(30);
  startgame = false;
  paused = false;
  p = new player();
  c = new coin();
  for(int i = 0; i < o.length; i++) {
    o[i] = new object();
  }
  level = 1;
  stroke(0);
}

void draw() {
  background(255);
  if(startgame == false) {
    fill(0);
    text("Press 'F' to start", width/2, height/2);
    if(keyPressed) {
      if(key == 'F' || key == 'f') {
        startgame = true;
        p.playerSpeed = 5;
        for(int i = 0; i < o.length; i++) {
          o[i].objectxspeed = random(-5, 5);
          o[i].objectyspeed = random(-5, 5);
        }
      }
    }
  }
  textAlign(CENTER);
  textSize(50);
  fill(0);
  textSize(50);
  textSize(40);
  text(level, 80, 40);
  text("Knockoff Snake", width-325, 40);
  text("Remastered", width-325, 80);
  c.show();
  c.collect();
  p.show();
  p.move();
  for(int i = 0; i < level; i++) {
    o[i].show();
    o[i].move();
  }
  for(int i = 0; i < level; i++) {
    if(dist(o[i].objectxpos, o[i].objectypos, p.playerxpos, p.playerypos) <= 75) {
      textSize(50);
      textAlign(CENTER);
      fill(0);
      text("Game over", width/2, height/2);
      text("Press 'R' to restart", width/2, height/2 + 55);
      p.playerSpeed = 0;
      o[i].objectxspeed = 0;
      o[i].objectyspeed = 0;
    }
  }
  if(level > 255) {
    textAlign(CENTER);
    textSize(100);
    fill(0);
    text("You win!", width/2, height/2);
  }
  p.pause();
  p.restart();
  p.offscreen();
}

class coin {
  float coinxpos = random(0, width);
  float coinypos = random(0, height);
  
  void show() {
    fill(255, 215, 0);
    ellipse(coinxpos, coinypos, 50, 50);
  }
  
  void collect() {
    if(dist(coinxpos, coinypos, p.playerxpos, p.playerypos) <= 70) {
      level++;
      coinxpos = random(0, width);
      coinypos = random(0, height);
    }
  }
}

class object {
  float objectxpos = random(0, width);
  float objectypos = random(0, height);
  float objectxspeed = 0;
  float objectyspeed = 0;
  float savedobjectxspeed;
  float savedobjectyspeed;

  void show() {
    fill(200, 0, 0);
    ellipse(objectxpos, objectypos, 50, 50);
  }
  
  void move() {
    objectxpos += objectxspeed;
    objectypos += objectyspeed;
    if(objectxpos >= width) {
      objectxspeed = random(-5, 0);
      objectyspeed = random(-5, 5);
    }
    if(objectxpos <= 0) {
      objectxspeed = random(0, 5);
      objectyspeed = random(-5, 5);
    }
    if(objectypos >= height) {
      objectxspeed = random(-5, 5);
      objectyspeed = random(-5, 0);
    }
    if(objectypos <= 0) {
      objectxspeed = random(-5, 5);
      objectyspeed = random(0, 5);
    }
  }
}

class player {
  float playerxpos = random(0, width);
  float playerypos = random(0, height);
  float playerSpeed = 0;
  
  void show() {
    fill(0, 200, 0);
    ellipse(playerxpos, playerypos, 100, 100);
  }
  
  void move() {
    if(keyPressed) {
      if(key == 'w') {
        playerypos -= playerSpeed;
      }
      if(key == 's') {
        playerypos += playerSpeed;
      }
      if(key == 'a') {
        playerxpos -= playerSpeed;
      }
      if(key == 'd') {
        playerxpos += playerSpeed;
      }
    }
  }
  
  void pause() {
    if(keyPressed) {
      if((key == 'P' || key == 'p') && paused == false) {
        paused = true;
        for(int i = 0; i < o.length; i++) {
          o[i].savedobjectxspeed = o[i].objectxspeed;
          o[i].savedobjectyspeed = o[i].objectyspeed;
          o[i].objectxspeed = 0;
          o[i].objectyspeed = 0;
          key = ' ';
        }
      }
      
      if((key == 'P' || key == 'p') && paused == true) {
        paused = false;
        for(int i = 0; i < o.length; i++) {
          o[i].objectxspeed = o[i].savedobjectxspeed;
          o[i].objectyspeed = o[i].savedobjectyspeed;
          key = ' ';
        }
      }
    }
  }
  
  void restart() {
    if(keyPressed) {
      if(key == 'R' || key == 'r') {
        setup();
      }
    }
  }
  
  void offscreen() {
    if(playerxpos < -50) {
      playerxpos = width + 50;
    }
    
    if(playerxpos > width + 50) {
      playerxpos = -50;
    }
    
    if(playerypos < -50) {
      playerypos = height + 50;
    }
    
    if(playerypos > height + 50) {
      playerypos = -50;
    }
  }
}