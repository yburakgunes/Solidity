// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/utils/Counters.sol";

contract ProposalContract {
    using Counters for Counters.Counter;
    Counters.Counter private _counter;

    address public owner;

    struct Proposal {
        string title;        
        string description;  
        uint256 approve;     
        uint256 reject;      
        uint256 pass;        
        uint256 total_vote_to_end;  
        bool current_state;  
        bool is_active;      
    }

    mapping(uint256 => Proposal) proposal_history; 

    address[]  private voted_addresses;

    constructor() {
        owner = msg.sender;
        voted_addresses.push(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier active() {
        require(proposal_history[_counter.current()].is_active == true, "The proposal is not active");
        _;
    }

    modifier newVoter(address _address) {
        require(!isVoted(_address), "Address has not voted yet");
        _;
    }

    function setOwner(address new_owner) external onlyOwner {
        
    }

    function create(string calldata title, string calldata _description, uint256 _total_vote_to_end) external onlyOwner{
        _counter.increment();
        proposal_history[_counter.current()] = Proposal(title ,_description, 0, 0, 0, _total_vote_to_end, false, true);
    }

    function vote(uint8 choice) external active newVoter(msg.sender) {
        Proposal storage proposal = proposal_history[_counter.current()];
        uint256 total_vote = proposal.approve + proposal.reject + proposal.pass;

        voted_addresses.push(msg.sender);

        require(choice == 1 || choice == 2 || choice == 0, "Invalid choice");

        if (choice == 1) {
            proposal.approve += 1;
        } else if (choice == 2) {
            proposal.reject += 1;
        } else if (choice == 0) {
            proposal.pass += 1;
        }

        proposal.current_state = calculateCurrentState();


        if (proposal.total_vote_to_end == total_vote) {
            proposal.is_active = false;
        }
    }   


    function calculateCurrentState() private view returns(bool) {
        Proposal storage proposal = proposal_history[_counter.current()];
        
        uint256 approve = proposal.approve;
        uint256 reject = proposal.reject;
        uint256 totalVotes = approve + reject;

        
        if (totalVotes >= proposal.total_vote_to_end) {
            if (approve > reject) {
                return true; 
            } else {
                return false; 
            }
        } else {
            return proposal.current_state; 
        }
    }


    function terminateProposal() external onlyOwner active {
        proposal_history[_counter.current()].is_active = false;
    }

    function isVoted(address _address) public view returns (bool) {
        for (uint i = 0; i < voted_addresses.length; i++) {
            if (voted_addresses[i] == _address) {
                return true;
            }
        }
        return false;
    }

    function getCurrentProposal() external view returns(Proposal memory) {
        return proposal_history[_counter.current()];
    }

    function getProposal(uint256 number) external view returns(Proposal memory) {
        return proposal_history[number];
    }

     
}
