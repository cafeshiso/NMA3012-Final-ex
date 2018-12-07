//borrowed from https://forum.processing.org/two/discussion/9562/simple-choose-your-own-adventure
// ------------------------------------------------------------------

// states control the program
final int startScreen = 0; // possible states 
final int play = 1;
final int playerIsDead = 2;
final int playerWon = 3;
final int about=5;

int state = startScreen; // current state 

boolean buttonClicked = false;

// ----------------------------------------------

String globalSectionNumber;

// ----------------------------------------------


DialogLine[] dialogLines =
  {
  new DialogLine("A1", "Welcome weary dreamer, are you lost?", "Yes#A2", "No#A3"), 
  new DialogLine("A2", "Let me help you find your way. There's going to be a couple of different paths you can take however, keep in mind that there will be consequences for picking bad choices. Don't be a couch potato, contribute to society will ya?", "Wake Up#A4", "Keep Sleeping#A5" ), 
  new DialogLine("A3", "Don't lie, I think you are.", "OK#A2" ), 
  new DialogLine("A4", "You roll out of bed. Theres sunlight faintly peering through your window. You flip over the phone that you dropped on the floor during your sleep. What time is it?", "9:00AM#B1", "4:00PM#C2" ), 
  new DialogLine("A5", "Are you sure you want to keep sleeping? There's lots to do and experience.", "Sleep More#A6", "Wake Up#A4" ), 
  new DialogLine("A6", "You decided to sleep more. Eventually the excess amount of sleep puts you in sleep paralysis. You wake up but your body is half conscious and you're lucid dreaming of demons and your biggest fears. You suffer a fatal heart attack and seizure in your paralyzed state, because an otherwordly force has smited you for being lazy.", "Game Over. Start over again?#A1"), 
  //
  new DialogLine("B1", "You didn't miss any alarms at all this morning, Good job! Finally, you have one thing of your life on track! You head out of bed and realize that today is a work day. You shuffle into your work clothes frantically and realize you'll be late if you don't leave in 5 minutes. Do you...", "Fix your hair and leave#B2", "Eat something quick then leave#B3", "Leave right now#B4"), 
  new DialogLine("B2", "You fixed your hair and left your house. However, this doesn't leave you time to eat. Rushing to the subway, you miss it by 5 minutes. Maybe you shouldn't have done your hair and left earlier, and now you're hungry. Good job champ!", "Wait for the next train#B4", "Buy food#B5", "Call for an Uber#B6"), 
  new DialogLine("B3", "After grabbing something light to eat, you head out. However, this leaves your looks terribly disheveled, with no possible way to cover it up. Rushing to the subway, you miss it by 5 minutes. Maybe you shouldn't have eaten and left earlier, and now you're unpresentable. Good job champ!", "Wait for the next train#B4", "Call for an Uber#B6"), 
  new DialogLine("B4", "The train arrives earlier than expected! A few minutes after the last one. You board and sit down. It's an hour travel time to work and because it's morning, you know the subway will be packed the stop after yours. At the next stop, a pregnant woman enters.", "Give up seat for her like a lawful good citizen#D1", "Sit, because you know its a long journey. Somebody else might offer up their seat#D2"), 
  new DialogLine ("B5", "You enter the cafe near your subway station. Why would you get breakfast when you're heading to work in cafe? Anyways, you get your usual, a cappucino and a bagel. Your phone rings in your pocket.", "Pick up#D3", "Ignore#D4"), 
  new DialogLine("B6", "You called for an Uber. It arrives promptly, and you get in. Your driver welcomes you and says nothing else.", "Start conversation#BU1", "Keep Silent#BU2" ), 
  //
  new DialogLine("BU1", "'So, you've been driving alot? The weather today is pretty nice.' but he doesn't reply back. You keep silent for the rest of the journey.", "1 Star#BU4", "5 Stars#BU3"), 
  new DialogLine("BU2", "The ride continues in silence as whatever playlist the driver has on is playing. Eventually, you reach your destination,", "1 Star#BU3", "5 Stars#BU3"), 
  new DialogLine("BU3", "Satisfied with your rating, you continue on the rest of your day. You think about whether things would change if you rated him differently, but somethings aren't meant to be in your control. You think about it more, and shove it to the side.", "Head to work#E1", "Forget work, who needs to go when there's the world to explore#D5"), 
  new DialogLine("BU4", "He notices your rating for him on your phone, and sneers at you. 'Really? You think its THAT easy?' You get the gut feeling that he's dangerous and might brandish a knife... ","Make a run for it #BU5"," Apologize #BU6"),
 
  new DialogLine("BU5", "You sprint out of the Uber straight into an area to hide. The driver, confused, drives off to his next client. It seems like you avoided danger? Sometimes, it's bad to jump the gun on assumptions... or jump the knife.","Head to work#E2", "Forget work, who needs to go when there's the world to explore#D5"), 
  new DialogLine("BU6", "'Sorry, my finger slipped.' You frantically say, 'Sorry for the rating, I'll tip you instead!' and your thumb goes for the $1.00 tip, but you mess up. Your thumb types one extra zero.... 'You have tipped $10.00'.","Head to work#E2", "Forget work, who needs to go when there's the world to explore#D5"), 
  //C
  new DialogLine("C2","You glance over at your phone. It says 4:00PM. It seems that you've missed your work shift. You get a phone call...","Pick up#D3b", "Ignore#D4"),
  //D
  new DialogLine("D1", "You get up and signal to her that your seat is offered. She shakes her head in sign that it's okay, and that you can sit back down. However somebody rushes to the empty spot where you last left.","Continue#E1"),
  new DialogLine("D2", "You sit in your seat and pretend to sleep. When you crack your eyes slightly open, you notice that she isn't really pregnant, but is carrying a beer belly. You go through the rest of the ride to work.","Continue#E1"),
  //E
  new DialogLine("D3", "'HEY WHERE ARE YOU? WE NEED YOU HERE ASAP, GET YOUR BUTT OVER HERE", "You leave ASAP#B6","Hang up and Ignore#D4"),
  new DialogLine("D3b", "'HEY WHERE ARE YOU? WE NEED YOU HERE ASAP, GET YOUR BUTT OVER HERE", "Take a hike, its 4:00PM#D4","Hang up and Ignore#D4"),
  new DialogLine("D4", "Congratulations, you receive a prompt email notifying your forced resignment of your job","Start Again?#A1"),
  new DialogLine("E1", "Welcome to work! You head to clock in, drop your belongings and sling some lattes. Good job! You diligently work through the day until a certain customer arrives. She carries herself highly, and rudely orders and peers over the bar counter. 'You better make this GOOD! This is an expensive drink and. LESS. ICE'", "Fight her#D4", "Suck it up and make it#Eb2","Spit in her drink#E3" ), 
    new DialogLine("E2", "Welcome to work! You head to clock in, drop your belongings and sling some lattes. Good job! You diligently work through the day completely fine with no hiccups!","Continue#W1"),
     new DialogLine("Eb2", "You diligently work through the day completely fine with no hiccups!","Continue#W1"),
      new DialogLine("E3", "You subtly drop saliva in her drink and mix it. You question the integrity of your actions, but other than that... You diligently work through the day completely fine with no hiccups!","Continue#W1"),
  new DialogLine("W1", "You've made it! The best possible ending!", "Start Again?#A1"), 
  //
  };
// The dialog lines indexed by their id, for easy lookup
HashMap<String, DialogLine> dialogTree = new HashMap<String, DialogLine>();
// The line currently displayed
DialogLine currentLine;
// The dialog so far
ArrayList<String> dialog = new ArrayList<String>();
// 
PImage t1, t2, t3,bed,sink,phone,subway,bfood,insub,work,end,win,uber;
void setup ()
{
  size(1280, 720);
  smooth();
  for (DialogLine dl : dialogLines)
  {
    dialogTree.put(dl.id, dl);
  }

  // start point is 7 - see <a href="http://www.atariarchives.org/adventure/chapter2.php" target="_blank" rel="nofollow">http://www.atariarchives.org/adventure/chapter2.php</a>
  currentLine = dialogTree.get("A1");
  globalSectionNumber = "A1";
  dialog.add(currentLine.line);
  state=startScreen;

  t1= loadImage("title1.JPG");
  t2= loadImage("title2.JPG");
  t3= loadImage("title3.JPG");
  bed=loadImage("bed.jpg");
  sink=loadImage("sink.JPG");
  phone=loadImage("phone.jpg");
  subway=loadImage("subway.jpg");
  bfood=loadImage("bfood.jpg");
  insub=loadImage("insub.jpg");
  work=loadImage("work.jpg");
  end=loadImage("end.jpg");
  win=loadImage("win.jpg");
 uber=loadImage("uber.jpg");
}

void draw () {
  background(25);

  // now states: 
  switch(state) {
  case startScreen:
    showStartScreen();
    break; 
  case play:
    play();
    //Conditions();
    break;
    //case about;

  default:
    //error
    println ("unknown state line 64");
    exit();
    break;
  } // switch
}


// func 

// --------------------------------------------------------------------------

void showStartScreen() {
  t1.resize(0, 250);
  image(t1, width/3-50, 200);
  filter(BLUR, 5);

  t2.resize(0, 250);
  image(t2, width/3+170, 150);
  t2.filter(GRAY);   

  t3.resize(0, 200);
  image(t3, width/3+80, 350);
  t3.filter(POSTERIZE, 5);

  fill(65);
  textAlign(CENTER);
  textSize(75);
  text ("butterflyeffect", (width/2)-10, 380);
  fill(255);
  textAlign(CENTER);
  textSize(75);
  text ("butterflyeffect", width/2, 370);
  int y_value = 130;






  y_value+=520;
  textSize(20);
  text ("Press any key to Start ", width/2, y_value);
  if (buttonClicked) {

    fill(255);
    textSize(12);
    text("Artist Info", 75, 50);
    fill(255);
    text ("Jason Hao Huang is an artist who grew up in New York City. He enjoys working in the coffee industry and playing games in his free time. \n"
      +"Inspired by nostalgic retro adventure games, this piece tries to emulate the same feeling of a text based role-playing game. While simplistic, he hopes the text driven interactive story will appeal to those who play through it.  \n"
      +"'The concept represents my worries in life; thinking about what would happen if I had made a certain decision in certain situations. This is why a role-playing format was essential to this thought process. "
      +"\n"
      +"Having different choices and being able to replay them for different endings, is my take on coping with the what-if's in life.\n"
      +"The stories played through are lightly based off real life experiences, with some based off real events, and some fiction.\n"
      +"Please, do enjoy this mini-experience.'", 20, 70, width/4, height);
    ;
  }
  // buttonClicked is not true
  else {
    fill(50);
    noStroke();
    rect(50, 30, 50, 30);
    fill(255);
    textSize(12);
    text("About Artist", 75, 50);
  }
}

void play() {  

  // that's the main part. It's from PhiLho. 
  fill(50);
  rect(290, 20, 700, 200);
  fill(242);
  textSize(20);
  text(currentLine.line, 320, 30, width/2, 360);
  // textWidth
  // Display the choice of answers
  fill(50);
  rect(240, 520, 800, 175);
  fill(255);
  textSize(15);
  int y =  550;
  int toChoose = 1;
  for (String ch : currentLine.choices)
  {
    // DialogLine choice = dialogTree.get(ch);
    String [] myArray = split(ch, "#");  
    text(toChoose++ + ": " + myArray[0], width/2, y);
    y += 22;
  }
  //for (DialogLine dl : dialogLines)
  //{
  //  if (dl.id=="A1") {
  //    t1.resize(0, 250);
  //    image(t1, width/2, 200);
  //  }
  //  if (dl.id=="A4") {
  //    t2.resize(0, 250);
  //    image(t2, width/2-200, 200);
  //  }
  //  // dialogTree.put(dl.id, dl);
  //}
  
  switch(globalSectionNumber){
  
    case "A1":
      bed.resize(0, 250);
      image(bed, width/2-180, 250);
      break;
      
    case "B2":
      sink.resize(0, 250);
      image(sink, width/2-180, 250);
      break;
     
       
    case "A4":
      phone.resize(0, 250);
      image(phone, width/2-180, 250);
      break;
     case "B1":
      phone.resize(0, 250);
      image(phone, width/2-180, 250);
      break;
    case "C2":
      phone.resize(0, 250);
      image(phone, width/2-180, 250);
      break;
    
  
      case "B3":
      bfood.resize(0, 250);
      image(bfood, width/2-180, 250);
      break;  
      case "B4":
     subway.resize(0, 250);
      image(subway, width/2-180, 250);
      break;     
        
       case "D1":
     insub.resize(0, 250);
      image(insub, width/2-180, 250);
      break;        
      case "D2":
     insub.resize(0, 250);
      image(insub, width/2-180, 250);
      break;     
    case "E1":
     work.resize(0, 250);
      image(work, width/2-180, 250);
      break;      
      case "E2":
     work.resize(0, 250);
      image(work, width/2-180, 250);
      break;     
      case "Eb2":
     work.resize(0, 250);
      image(work, width/2-180, 250);
      break;      
      case "E3":
     work.resize(0, 250);
      image(work, width/2-180, 250);
      break; 
      
      case "D4":
     end.resize(0, 250);
      image(end, width/2-180, 250);
      break;
      case "W1":
        win.resize(0, 250);
      image(win, width/2-180, 250);
      break; 
   case "BU1":
        uber.resize(0, 250);
      image(uber, width/2-180, 250);
      break; 
   case "BU2":
        uber.resize(0, 250);
      image(uber, width/2-180, 250);
      break; 
   case "BU3":
        uber.resize(0, 250);
      image(uber, width/2-180, 250);
      break; 
   case "BU4":
        uber.resize(0, 250);
      image(uber, width/2-180, 250);
      break; 
   case "BU5":
        uber.resize(0, 250);
      image(uber, width/2-180, 250);
      break; 
   case "BU6":
        uber.resize(0, 250);
      image(uber, width/2-180, 250);
      break; 
   
    
    
    
    default:
      break;
  }

  // for testing: 
  text (globalSectionNumber, width-30, height-30);

  /* 
   // Display the history of the curent game
   // (this could be an extra state of the program)
   fill(#0055AA);
   textSize(12);
   y = 200;
   for (String line : dialog)
   {
   // println (line);
   text (line, 20,y );
   y += 20;
   }
   println ("----------------------");
   */
}

// inputs ---------------------------------------------------------

void keyPressed() {


  // now states: 
  switch(state) {
  case startScreen:
    // start the game 
    state=play;
    break; 
  case play:
    // 
    int choiceNb = currentLine.choices.length;
    int choice = key - '1';
    if (choice < 0 || choice >= choiceNb)
      return; // Ignore

    String choiceMade = currentLine.choices[choice];
    String [] myArray = split(choiceMade, "#");  

    String choiceId = myArray[1]; // qqq

    globalSectionNumber = choiceId;

    DialogLine chosenAnswer = dialogTree.get(choiceId);
    if (chosenAnswer != null)
    {
      currentLine = dialogTree.get(choiceId);
      dialog.add(currentLine.line);
    }

    break;
  default:
    //error
    println ("unknown state line 148");
    exit();
    break;
  } // switch
}

void mousePressed() {
  if (mouseX > 50 && mouseX < 100 &&
    mouseY > 30 && mouseY < 50) {

    buttonClicked = true;
  }
}


/*
void mousePressed() {
 // now states: 
 switch(state) {
 case startScreen:
 state=play;
 break; 
 case play:
 // do nothing
 break;
 default:
 //error
 println ("unknown state line 148");
 exit();
 break;
 } // switch
 } 
 */

// =================================

/**
 * A dialog line: an id, the line itself, and a list of choices,
 * ie. of possible answers to this line.
 */
class DialogLine
{
  String id;
  String line;
  String[] choices;

  DialogLine(String i, String l, String... c )
  {
    id = i;
    line = l;
    choices = c;
  }

  String toString()
  {
    return id + " - " + line + " (" + choices.length + ")";
  }
} // class 
//
