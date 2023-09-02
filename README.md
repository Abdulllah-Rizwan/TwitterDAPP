# Twitter Dapp

**Twitter Dapp** is a decentralized application built on the Ethereum blockchain. It allows users to post tweets, like and unlike tweets, and view their tweet history. The Dapp is integrated with a user profile contract to ensure that only registered users can tweet and interact with the platform.

## Smart Contracts

### Twitter.sol

The core smart contract that powers the Twitter Dapp. It manages tweets, likes, and user interactions. Key features include:

- **Tweet Creation:** Users can create tweets, with a maximum length of 280 characters.
- **Tweet Liking:** Users can like and unlike tweets from other users.
- **User Registration:** Users must be registered in the integrated user profile contract to interact with the Dapp.

### Profile.sol

The user profile contract that integrates with the Twitter Dapp. It stores user display names and bios. Key features include:

- **Profile Creation:** Users can set their display name and bio.

## Getting Started

To deploy and use the Twitter Dapp, follow these steps:

1. **Deploy Contracts:** Deploy the `Profile.sol` contract and obtain its address.
2. **Initialize Twitter Contract:** Deploy the `Twitter.sol` contract, passing the `Profile.sol` contract address as a parameter.
3. **Interact with the Dapp:** Users can now register profiles, create tweets, and interact with tweets using the Dapp's functions.

## Usage Examples

- `createTweet(string memory _tweet)`: Create a new tweet with the given content.
- `likeTweet(address author, uint256 id)`: Like a tweet.
- `unlikeTweet(address author, uint256 id)`: Unlike a tweet.
- `getTotalLikes(address _author)`: Get the total likes for a user's tweets.
- `getAllTweet(address _owner)`: Get all tweets of a specific user.

## Project Structure

- **Twitter.sol**: Contains the core Twitter Dapp smart contract.
- **Profile.sol**: Contains the user profile smart contract.

## License

This project is licensed under the MIT License

## Author

- Abdullah Rizwan

## Acknowledgments

- [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts): Used for Ownable and error handling.
