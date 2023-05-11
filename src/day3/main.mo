import Type "Types";
import Buffer "mo:base/Buffer";
import Result "mo:base/Result";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";


actor class StudentWall() {
  type Message = Type.Message;
  type Content = Type.Content;
  type Survey = Type.Survey;
  type Answer = Type.Answer;
  
  //continuously increasing counter
  var messageIdCounter: Nat = 0;

  //Store messages.
  var wall = HashMap.HashMap<Nat, Message>(0,Nat.equal, Message.equal);


  // Add a new message to the wall
  public shared ({ caller }) func writeMessage(c : Content) : async Nat {
      // Increment message ID
      messageIdCounter += 1;

      // Create new message
      let message: Type.Message = {
        content = c;
        vote = 0;
        creator : Principal = msg.caller;
      };

      // Add message to wall
      wall.put(messageIdCounter, message);
      return messageIdCounter;
  };
  

  // Get a specific message by ID
  public shared query func getMessage(messageId : Nat) : async Result.Result<Message, Text> {
    if (messageId <= 0 or messageId > messageIdCounter) {
      return #err("Invalid message ID");
    };
    let messageOpt = wall.get(messageId);
    if (messageOpt == null) {
      return #err("Message not found");
    };
    return #ok(messageOpt);
  };

  // Update the content for a specific message by ID
  public shared ({ caller }) func updateMessage(messageId : Nat, c : Content) : async Result.Result<(), Text> {
    return #err("not implemented");
  };

  // Delete a specific message by ID
  public shared ({ caller }) func deleteMessage(messageId : Nat) : async Result.Result<(), Text> {
    return #err("not implemented");
  };

  // Voting
  public func upVote(messageId : Nat) : async Result.Result<(), Text> {
    return #err("not implemented");
  };

  public func downVote(messageId : Nat) : async Result.Result<(), Text> {
    return #err("not implemented");
  };

  // Get all messages
  public func getAllMessages() : async [Message] {
    return [];
  };

  // Get all messages ordered by votes
  public func getAllMessagesRanked() : async [Message] {
    return [];
  };
};
