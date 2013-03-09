// for a tri-colour LED. A green and red LED can be used
int red_pin =  13;
int green_pin =  12;
int blue_pin =  11;

int current_colours[3] = {255, 255 , 255};
int red[3] = {255, 255, 0};
int green[3] = {0, 255, 255};
int yellow[3] = {125, 255, 0};

void setup()
{                
  pinMode(red_pin, OUTPUT);
  pinMode(green_pin, OUTPUT);
  pinMode(blue_pin, OUTPUT);
  
  update_light(current_colours);
  fade_to(yellow);

  Serial.begin(9600);
}

void update_light(int colours[3])
{
  for(int i=0; i < 3; i++)
  {  
    current_colours[i] = colours[i]; 
  }
  analogWrite(green_pin, colours[0]);
  analogWrite(blue_pin, colours[1]);
  analogWrite(red_pin, colours[2]);
}

void set_light(int colour_key)
{
  switch (colour_key) {
    case 114: //red
      fade_to(red);
      break;
    case 121:  //yellow
      fade_to(yellow);
      break;
    case 103:  //green
      fade_to(green);
      break;
  }
}

void fade_to(int colours[])
{
  Serial.println(current_colours[0]);
  Serial.println(current_colours[1]);
  Serial.println(current_colours[2]);
  
  Serial.println(colours[0]);
  Serial.println(colours[1]);
  Serial.println(colours[2]);
  
  while (current_colours[0] != colours[0] || current_colours[1] != colours[1] || current_colours[2] != colours[2])
  {
    for(int i=0, del=10; i < 3; i++, del--)
    {
      if (current_colours[i] > colours[i])
      {
        current_colours[i]--;
      }
      else if (current_colours[i] < colours[i])
      {
        current_colours[i]++;
      }
      update_light(current_colours);
      delay(del);     
    } 
  }
}

void loop()                     
{
  int colour_key;

  if (Serial.available()) {
    colour_key = Serial.read();
    set_light(colour_key);
  }

  delay(1000);  
  
}

