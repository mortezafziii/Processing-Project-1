// Declare variables for motion and color
float rectX, rectY;
float circleX, circleY;
float speedX, speedY;
float rotationAngle;
color rectColor, circleColor, bgColor;

void setup() {
  // Setup canvas size
  size(600, 600);
  
  // Initialize variables for the shapes
  rectX = 50;
  rectY = 100;
  circleX = width / 2;
  circleY = height / 2;
  speedX = 3;
  speedY = 4;
  rotationAngle = 0;
  
  // Initialize colors
  rectColor = color(0, 102, 153); // blue
  circleColor = color(255, 102, 102); // red
  bgColor = color(255); // white background
  
  // Set ellipse mode to center
  ellipseMode(CENTER);
}

void draw() {
  // Continuously change background color over time
  bgColor = color((frameCount % 255), 100, 200);
  background(bgColor);
  
  // Call functions to draw and animate the shapes
  drawMovingRectangle();
  drawRotatingEllipse();
  drawBouncingCircle();
  drawStaticStar(5, 300, 500, 40, 80);  // Draw a star shape
  drawRandomPolygon(400, 400, random(50, 80), int(random(3, 7)));
}

void drawMovingRectangle() {
  // Change color dynamically
  rectColor = color((rectX + frameCount) % 255, 200, 150);
  fill(rectColor);
  noStroke();
  
  // Move the rectangle along the x-axis
  rectX += 2;
  
  // If rectangle moves off the screen, reset its position
  if (rectX > width) {
    rectX = 0;
  }
  
  // Draw the rectangle with dynamic color
  rect(rectX, rectY, 70, 50);
}

void drawRotatingEllipse() {
  // Make ellipse change color over time
  float r = map(sin(frameCount * 0.05), -1, 1, 50, 255);
  float g = map(cos(frameCount * 0.05), -1, 1, 50, 255);
  fill(r, g, 200);
  noStroke();
  
  // Rotate ellipse around its center
  pushMatrix();  // Save the current transformation
  translate(200, 200);  // Move origin to ellipse center
  rotate(radians(rotationAngle));  // Apply rotation
  ellipse(0, 0, 60, 40);  // Draw ellipse
  popMatrix();  // Restore original transformation
  
  // Increment rotation angle for continuous rotation
  rotationAngle += 3;
}

void drawBouncingCircle() {
  // Set dynamic color for the circle
  fill(circleColor);
  noStroke();
  
  // Update circle's position based on its speed
  circleX += speedX;
  circleY += speedY;
  
  // Check if circle hits the canvas edges and reverse direction
  if (circleX > width || circleX < 0) {
    speedX *= -1;
  }
  if (circleY > height || circleY < 0) {
    speedY *= -1;
  }
  
  // Draw the bouncing circle
  ellipse(circleX, circleY, 60, 60);
}

void drawStaticStar(int points, float x, float y, float radius1, float radius2) {
  // Draw a star with a dynamic position
  float angle = TWO_PI / points;
  float halfAngle = angle / 2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a + halfAngle) * radius1;
    sy = y + sin(a + halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void drawRandomPolygon(float x, float y, float radius, int npoints) {
  // Draw a polygon with random sides and changing color
  stroke(0);
  strokeWeight(2);
  fill(random(100, 255), random(100, 255), random(100, 255));
  float angle = TWO_PI / npoints;
  beginShape();
  for (int i = 0; i < npoints; i++) {
    float sx = x + cos(i * angle) * radius;
    float sy = y + sin(i * angle) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

// Mouse interaction to change circle's color on click
void mousePressed() {
  circleColor = color(random(255), random(255), random(255));
}
