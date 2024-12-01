# Elections-smart-contract
Before you begin, ensure you have the following installed on your machine:

- [Node.js](https://nodejs.org/) (version 12.x or higher)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- [Truffle](https://www.trufflesuite.com/truffle) (for development and testing)
- [Ganache](https://www.trufflesuite.com/ganache) (local Ethereum blockchain)
- [MetaMask](https://metamask.io/) (browser extension for interacting with the blockchain)

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/fedei10/Elections-smart-contract
    cd election-smart-contract
    ```

2. Install the dependencies:
    ```sh
    npm install
    ```

## Deployment

1. Start Ganache (make sure it's running on `http://127.0.0.1:7545`).

2. Compile the smart contract:
    ```sh
    truffle compile
    ```

3. Deploy the smart contract to the local blockchain:
    ```sh
    truffle migrate --local 
    ```

4. (Optional) To deploy to a public testnet (e.g., Ropsten), update the `truffle-config.js` file with your testnet details and run:
    ```sh
    truffle migrate --network ropsten
    ```

## Usage

1. Open the project in your code editor.

2. Interact with the smart contract using the Truffle console:
    ```sh
    truffle console
    ```

3. In the console, you can perform various operations such as adding candidates, voting, and retrieving election results:
    ```js
    const election = await Election.deployed();
    await election.addCandidate('Candidate 1');
    await election.vote(1, { from: '0xYourAccountAddress' });
    const candidates = await election.getCandidates();
    console.log(candidates);
    ```

4. Use MetaMask to interact with the contract through a frontend DApp (Decentralized Application).

## Testing

1. To run the tests for the smart contract:
    ```sh
    truffle test
    ```

2. The tests are located in the `test` directory and cover various scenarios such as adding candidates, voting, and preventing duplicate votes.

## Contributing

We welcome contributions to enhance the functionality and usability of this project. To contribute, follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
