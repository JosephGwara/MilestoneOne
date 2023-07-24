import Text "mo:base/Text";
actor {
  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

public query func swear(name: Text) :async Text{
  return "Ma se," # name # "!";
};

};

