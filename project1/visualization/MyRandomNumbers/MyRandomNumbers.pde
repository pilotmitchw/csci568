/*
 #myrandomnumber Tutorial
 blprnt@blprnt.com
 April, 2010
 */

//This is the Google spreadsheet manager and the id of the spreadsheet that we want to populate, along with our Google username & password
SimpleSpreadsheetManager sm;
String sUrl = "t6mq_WLV5c5uj6mUNSryBIA";
String googleUser = GUSER;
String googlePass = GPASS;
  
void setup() {
    //This code happens once, right when our sketch is launched
    size(800,800);
    background(0);
    smooth();

    int[] numbers = getNumbers();
    
    barGraph(numbers,400.0);
  

}

void draw() {
  //This code happens once every frame.
}

void barGraph( int[] nums, float y ) {
 //Make list of number counts
 int[] counts = new int[100];
 for(int i = 1; i < 100; ++i)
 {
  counts[i] = 0; 
 }
 
 //Tally
 for(int i = 0; i < nums.length; i++)
 {
  counts[nums[i]]++; 
 }
  
  for(int i = 0; i < counts.length; ++i)
  {
   rect(i*8, y, 8, -counts[i] * 10);
 }
}

