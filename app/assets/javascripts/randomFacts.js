$(document).ready(function() {
  var r_text = new Array ();
  r_text[0] = "The Grand Canyon can hold around 900 trillion footballs";
  r_text[1] = "The Great Wall of China is approximately 6,430 Km long (3,995 miles)";
  r_text[2] = "The Taj Mahal in India is made entirely out of marble";
  r_text[3] = "Buckingham Palace has over 600 rooms";
  r_text[4] = "The Eifel Tower has 2,500,000 rivets";
  r_text[5] = "There are over 600 windows on the Empire State Building";
  r_text[6] = "There are 132 rooms in the US White House";
  r_text[7] = "In 1872 Yellowstone in the US was the world's first national park";
  r_text[8] = "New York's Central Park was opened in 1876";
  r_text[9] = "After 14 years of effort, workers finished sculpting Mount Rushmore in the Black Hills of Nebraska in 1941. The entire monument cost $989,992.32 to build. Taking inflation into account, that same bill would total out to more than $15 million today.";
  r_text[10] = "New York's Central Park was opened in 1876";
  r_text[11] = "New York's Central Park was opened in 1876";
  r_text[12] = "Chuck Norris built the house he was born in";
  r_text[12] = "Chuck Norris is not interested";
  randno = r_text[Math.floor( Math.random() * r_text.length )];
  $('.quote').text( randno );
});
