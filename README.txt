###ProposalContract
ProposalContract is a Solidity smart contract that allows users to create, vote on, and manage proposals. It provides a decentralized platform for decision-making within a community or organization, where users can create proposals, cast votes, and track the status of proposals.

##Features
Create Proposals: The contract owner can create proposals by providing a title, description, and the total number of votes required for a proposal to end.
Cast Votes: Users can cast votes on active proposals by choosing from three options: approve (1), reject (2), or pass (0).
##Proposal State: The contract automatically calculates the state of each proposal based on the votes cast. A proposal can be either approved or rejected, and the state can change as more votes are cast.
Proposal Termination: The contract owner can terminate an active proposal, making it inactive and preventing further votes.
##Address Verification: The contract ensures that each address can only vote once and that only the contract owner can create new proposals or terminate them.
##Usage
#Deploying the Contract
Deploy the contract to the Ethereum blockchain using a development environment like Remix, Truffle, or Hardhat.
#Interacting with the Contract
1.Create a Proposal: Only the contract owner can create proposals. Use the create function to create a new proposal by providing a title, description, and the total number of votes required for the proposal to end.

2.Vote on a Proposal: Any user can cast votes on active proposals by calling the vote function and specifying their choice (1 for approve, 2 for reject, 0 for pass). Ensure your address has not voted on the same proposal before.

3.Check Proposal Status: You can check the status of the current proposal (most recent) using the getCurrentProposal function or view the details of a specific proposal by providing its number using the getProposal function.

4.Terminate a Proposal: The contract owner can terminate an active proposal using the terminateProposal function. This action sets the proposal's status to inactive.

5.Change Owner: The contract owner can transfer ownership to a new address using the setOwner function.

##Events
The contract emits events to notify users about important actions, such as the creation of a new proposal or the casting of votes. You can listen to these events to track activities on the contract.
##Development
This contract uses the OpenZeppelin Counters library for managing proposal IDs.
The contract is written in Solidity 0.8.18.