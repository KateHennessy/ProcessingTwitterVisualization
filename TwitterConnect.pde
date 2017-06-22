import java.util.*;
LinkedList<Status> allStatuses = new LinkedList<Status>();

ConfigurationBuilder twitterConnect() {
  ReadConfig config = new ReadConfig("/files/config.txt");
  ConfigurationBuilder configurationBuilder;
  final String _consumerKey = config.getConsumerKey();
  final String _consumerSecret = config.getConsumerSecret();
  final String _accessToken = config.getAccessToken();
  final String _accessTokenSecret = config.getAccessTokenSecret();
  
  configurationBuilder = new ConfigurationBuilder();
  configurationBuilder.setOAuthConsumerKey(_consumerKey)
    .setOAuthConsumerSecret(_consumerSecret)
    .setOAuthAccessToken(_accessToken)
    .setOAuthAccessTokenSecret(_accessTokenSecret);
    
    return configurationBuilder;
}

TwitterStream openTwitterStream() {
  ConfigurationBuilder configurationBuilder = twitterConnect();

  TwitterStream twitterStream = new TwitterStreamFactory(configurationBuilder.build()).getInstance();
  System.out.println("opened twitter stream");
  return twitterStream;
}

void listenTwitterStream(TwitterStream twitterStream) {
  //TwitterStream twitterStream = openTwitterStream();
  twitterStream.addListener(geoListener);
  System.out.println("listening");
}


void addGeoFilter(TwitterStream twitterStream){
   twitterStream.filter(new FilterQuery().locations(boundingBox));
}


StatusListener geoListener = new StatusListener()
{
  public void onStatus(Status status)
  {
    if (status.getGeoLocation() != null)      //ensuring that there is geolocation tags on the status
    {
      allStatuses.push(status);
    } else {
    }
  }
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
    println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
  }
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
    println("Got track limitation notice:" + numberOfLimitedStatuses);
  }
  public void onScrubGeo(long userId, long upToStatusId) {
    println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }
  public void onStallWarning(StallWarning warning) {
    println("Got stall warning:" + warning);
  }
  public void onException(Exception ex) {
   ex.printStackTrace();
  }
};