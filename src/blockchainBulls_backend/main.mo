import Time "mo:base/Time";

actor EnglishAuction {
  type Bid = { bidder: Text; amount: Nat };

  var highestBid: ?Bid = null;
  var auctionEndTime: Time.T = Time.now() + Time.fromSeconds(900); 
  var auctionEnded: Bool = false;

  public func bid(bidder: Text, amount: Nat) : async () {
    if (auctionEnded == false and Time.now() < auctionEndTime) {
      let newBid = { bidder = bidder; amount = amount };
      
      if (highestBid == null or amount > highestBid.amount) {
        highestBid := newBid;
        print bidder # " placed a bid of " # Nat.toText(amount) # " tokens.";
      } else {
        print "Sorry, your bid must be higher than the current highest bid.";
      }
    } else {
      print "The auction has ended.";
    }
  };

  public func endAuction() : async ?Text {
    if (auctionEnded == false and Time.now() >= auctionEndTime) {
      auctionEnded := true;
      
      if (highestBid != null) {
        print "Auction ended. Winner: " # highestBid.bidder # " with a bid of " # Nat.toText(highestBid.amount) # " tokens.";
        return highestBid.bidder;
      } else {
        print "Auction ended. No bids were placed.";
      }
    } else {
      print "The auction has not ended yet.";
    };
    
    return null;
  }
};

shared() {
  let auction = EnglishAuction();
  

  actor "participant1" {
    await Time.sleep(Time.fromSeconds(300));
    auction.bid("participant1", 100);
  };
  
 
  actor "participant2" {
    await Time.sleep(Time.fromSeconds(600)); 
    auction.bid("participant2", 150);
  };
  

  await Time.sleep(Time.fromSeconds(900));
  let winner = auction.endAuction();
};