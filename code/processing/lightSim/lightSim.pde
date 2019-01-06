int edgeCount = 5;

color bgColor = #212121;
color personColor = #AAAAAA;
float personSize = 0.2;

float lightSize = 0.66666;
float sensorSize = 1.5;

float fadeDamping = 0.98;
float fadeMomentum = 0.05;

class Sensor {
  PVector position;
  float lightRadius;
  float sensorRadius;
  float lightValue; // current brightness
  float sensorDefault; // calibrated value
  int readingCount = 1000; // samples
  float lightAdaption = 0;

  Sensor(PVector position, float lightRadius, float sensorRadius) {
    this.position = position;
    this.lightRadius = lightRadius;
    this.sensorRadius = sensorRadius;
    lightValue = 0.2;
  }

  void shine() {
    noStroke();
    fill(#FFFFFF, 255 * lightValue);
    ellipse(position.x, position.y, lightRadius * 2, lightRadius * 2);
  }

  void calibrate() {
    sensorDefault = read();
  }

  void adjust() {
    float reading = read();
    lightAdaption += (reading - sensorDefault) * fadeMomentum;
    lightAdaption *= fadeDamping;
    lightValue -= lightAdaption;
    lightValue = constrain(lightValue, 0, 1);
  }

  float read() {
    float reading = 0;
    for (int i = 0; i < readingCount; i++) {
      float l = random(sensorRadius);
      float a = random(TWO_PI);
      int x = round(position.x + cos(a) * l);
      int y = round(position.y + sin(a) * l);
      int value = pixels[y*width+x];
      reading += brightness(value) / 255.0;
    }
    return reading / readingCount;
  }

  void show() {
    noFill();
    stroke(#FFFFFF, 50);
    ellipse(position.x, position.y, lightRadius * 2, lightRadius * 2);
    arcCircle(position.x, position.y,sensorRadius * 2, 32);
    
    textAlign(CENTER, CENTER);
    noStroke();
    fill(#FFFFFF);
    text(lightValue, position.x, position.y);
  }
}

void setup() {
  size(1200, 800);
  blendMode(SCREEN);
  //fullScreen(P2D, 2);
  init();
}

ArrayList<Sensor> sensors;

void init() {
  float lightRadius = max(width, height) / (float) (edgeCount-1) * 0.5 * lightSize;
  float sensorRadius = lightRadius * sensorSize;
  sensors = new ArrayList();
  for (int i = 0; i < edgeCount; i++) {
    for (int j = 0; j < edgeCount; j++) {
      float x = map(i, -2, edgeCount+1, 0, width);
      float y = map(j, -2, edgeCount+1, 0, height);
      sensors.add(new Sensor(new PVector(x, y), lightRadius, sensorRadius));
    }
  }

  background(bgColor);

  for (Sensor sensor : sensors) {
    sensor.shine();
  }

  loadPixels();

  for (Sensor sensor : sensors) {
    sensor.calibrate();
  }
}

void draw() {
  background(bgColor);

  noStroke();
  fill(personColor);
  ellipse(mouseX, mouseY, height * personSize, height * personSize);


  for (Sensor sensor : sensors) {
    sensor.shine();
  }

  loadPixels();

  for (Sensor sensor : sensors) {
    sensor.adjust();
  }

  for (Sensor sensor : sensors) {
   sensor.show();
  }
}

void arcCircle(float x, float y, float radius, int steps) {
  float stepSize = TWO_PI / steps;
  for (int i = 0; i < steps; i++) {
    arc(x, y, radius, radius, i * stepSize, i * stepSize + stepSize * 0.5);
  }
}
