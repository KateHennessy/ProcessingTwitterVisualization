
double[][] boundingBox = {{-180, -90}, {180, 90}};
HashMap<String, Integer> countryCols;
int hour;
void setup() {
  size(1280, 720);
  smooth();
 // fullScreen();
  loadStartupDisplay();
  
 TwitterStream twitterStream = openTwitterStream();

 listenTwitterStream(twitterStream);
 
addGeoFilter(twitterStream);

  smooth();
  noStroke();
  fill(135, 12, 81);
  countryCols = new HashMap<String, Integer>();
  countryCols.put("United Kingdom", color(250, 250, 250, 50));
  countryCols.put("United States", color(250, 70, 70, 50));
  countryCols.put("España", color(50, 250, 50, 0.5));
  countryCols.put("Ireland", color(50, 255, 200, 50));
  countryCols.put("Brazil", color(255, 100, 100, 50));
 frameRate(120);  
 hour = hour() -1;
}

void draw() {
  if (allStatuses.size() > 0) {
    try{
    Status currStatus = allStatuses.pop();
      GeoLocation loc = currStatus.getGeoLocation();
    if (loc != null) {
      float lat = (float)loc.getLatitude();
      float lon = (float)loc.getLongitude();
      float yloc = map(lat, 90, -60, 0, height);
      float xloc = map(lon, -180, 180, 0, width);
      Place currPlace = currStatus.getPlace();
      if(currPlace != null){
      color myFill;
     
        if(countryCols.containsKey(currStatus.getPlace().getCountry())){
        myFill = countryCols.get(currStatus.getPlace().getCountry());
        }else{ 
         countryCols.put(currStatus.getPlace().getCountry(), color((int)(Math.random()*155) + 100, (int)(Math.random()*155) + 100, (int)(Math.random()*155) + 100, 50)); 
          myFill = countryCols.get(currStatus.getPlace().getCountry());
        }
        
        fill(myFill);
      }
      ellipseMode(CENTER);
      ellipse(xloc, yloc, 1, 1);

    }
    }catch(NullPointerException e){
      System.out.println("Error with LinkedList item ");
      e.printStackTrace();
    }
  
  }
  if(hour != hour()){ //comment this out if you don't want to save a screenshot every hour
   printScreenShot("/screenshots/");
    hour = hour();
  }
  
}


void keyPressed(){
  if(key=='p' || key=='P'){ //comment this out if you don't want to save screenshot by pressing 'p'
    printScreenShot("/screenshots/");
  }
  
}

void printScreenShot(String scPath){
  String scName = scPath + millis();
  System.out.println("Saving screenshot.. named: " + scName);
  saveFrame(scName);
  }