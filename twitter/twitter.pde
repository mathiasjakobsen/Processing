
//  auth informationer 
static String OAuthConsumerKey = "wVy5gkYNHEQ2ECRPfbmw";
static String OAuthConsumerSecret = "Y0AtagO5VssgKLQkgQIGPGQokUpheKeBHOehAMwxQ0";

// Access Token informationer
static String AccessToken = "961944775-axlaUdl6yRBbmeqUpfD34YCfyxWb7eyBIJ8Bey0u";
static String AccessTokenSecret = "bV37ro1mMx1LEgf8TBjHhFXnF20th4L4ZYUBX0OPhk";

// Twitter4J variabler
String myTimeline;
java.util.List statuses = null;
User[] friends;
Twitter twitter = new TwitterFactory().getInstance();
RequestToken requestToken;
String[] theSearchTweets = new String[11];


void setup()
{
  String a = "Test den 28. November";
  size(250,250);
  background(0);
  connectTwitter();
  getTimeline();
}
  

void draw()
{
  background(0);
}


// Opretter forbindelse
void connectTwitter() 
{
  twitter.setOAuthConsumer(OAuthConsumerKey, OAuthConsumerSecret);
  AccessToken accessToken = loadAccessToken();
  twitter.setOAuthAccessToken(accessToken);
}


// Send tweet
void sendTweet(String t) 
{
  try {
    Status status = twitter.updateStatus(t);
    println("Successfully updated the status to [" + status.getText() + "].");
    text("Hej", 50, 50);
  } catch(TwitterException e) { 
    println("Send tweet: " + e + " Status code: " + e.getStatusCode());
  }

}


// Loading up the access token
private static AccessToken loadAccessToken(){
  return new AccessToken(AccessToken, AccessTokenSecret);
}


// Hent tweets
void getTimeline() {

  try {
    statuses = twitter.getUserTimeline(); 
  } catch(TwitterException e) { 
    println("Get timeline: " + e + " Status code: " + e.getStatusCode());
  }

  for(int i=0; i<statuses.size(); i++) {
    Status status = (Status)statuses.get(i);
    println(status.getUser().getName() + ": " + status.getText());
  }

}




