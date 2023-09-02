// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Profile {

    struct UserProfile {
        string displayName;
        string bio;
    }

    mapping (address => UserProfile) public profiles;

    function setProfile(string memory _displayName,string memory _bio) public {
        profiles[msg.sender] = UserProfile(_displayName,_bio);
    }

    function getProfile(address _user) public view returns(UserProfile memory) {
        return profiles[_user];
    }

 // address => 0x1795925bf7579506614c18Db81a60f7042d4d4b6
}