// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

    /* ERRORS */
    error Tweeter__TweetError(string txt);
    error Tweeter__NotAnOwner();
    error Tweeter__TweetDoesNotExist();

    /* INTERFACE */
    interface IProfile {
        struct UserProfile {
            string displayName;
            string bio;
        }

         function getProfile(address _user) external view returns(UserProfile memory);
    }


contract Twitter is Ownable {

    /* TYPE DECLARATIONS */
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamps;
        uint256 likes;
    }
    
    /* STATE VARIABLES */
    uint16 private maxTweetLength = 280;
    IProfile profileContract;
    mapping (address => Tweet[]) public tweets;

    /* EVENTS */
    event TweetCreated(uint256 id,address author,string content,uint256 timestamps);
    event TweetLiked(address liker,address author,uint256 tweetId,uint256 Likecount);
    event TweetUnliked(address Disliker,address author,uint256 tweetId,uint256 Dislikecount);

    /* MODIFERS */
    modifier onlyRegistered() {
        IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);
        require(bytes(userProfileTemp.displayName).length > 0,"User doesnot exist");
        _;
    }

    /* FUNCTIONS */
    constructor(address _profileContract) {
        profileContract = IProfile(_profileContract);
    }

    /* EXTERNAL & EXTERNAL VIEW FUNCTIONS*/
    function getTotalLikes(address _author) external view returns(uint256) {
        uint256 totalLikes;
        uint256 lengthOfTweets = tweets[_author].length;
        for(uint i = 0; i< lengthOfTweets;i++){
            totalLikes+=tweets[_author][i].likes;
        }
        return totalLikes;
    }

    function likeTweet(address author,uint256 id) onlyRegistered external {
        if(tweets[author].length<id ) revert Tweeter__TweetDoesNotExist();
        tweets[author][id].likes++;
        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(address author,uint256 id) onlyRegistered external {
         if(tweets[author].length<id) revert Tweeter__TweetDoesNotExist();
         if(tweets[author][id].likes<=0) revert Tweeter__TweetError("Can't assign negative likes");
        tweets[author][id].likes--;
        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

    /* PUBLIC & PUBLIC VIEW FUNCTIONS */
    function createTweet(string memory _tweet) public onlyRegistered {
        if(bytes(_tweet).length>maxTweetLength) revert Tweeter__TweetError("Tweet Length Exceeds its limit");
        Tweet memory newTweet = Tweet({
            id:tweets[msg.sender].length,
            author:msg.sender,
            content:_tweet,
            timestamps:block.timestamp,
            likes:0
        });
        tweets[msg.sender].push(newTweet);
        emit TweetCreated(newTweet.id,newTweet.author,newTweet.content,newTweet.timestamps);
    }

    function getTweet(uint256 _i) public view returns(Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function changeTweetLength(uint16 newLength) public onlyOwner {
        maxTweetLength = newLength;
    }

    function getAllTweet(address _owner) public view returns(Tweet[] memory){
        return tweets[_owner];
    }

    //address => 0x455Cb93B566268662C154a77967328d893f38985

}