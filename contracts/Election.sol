pragma solidity;

contract Election {
    struct Candidate {
        uint id;
        string name;
        string party;
        uint voteCount;
    }
    
    mapping(address => bool) public hasVoted;
    mapping(uint => Candidate) public candidateRegistry;
    uint public candidateCount;
    
    event VotedEvent (
        uint indexed candidateId
    );

    constructor () public {
        addCandidate("Narendra D Modi", "Bharatiya Janata Party");
        addCandidate("Rahul Gandhi", "Indian National Congress");
        addCandidate("Akhilesh Yadav", "Samajvadi Party");
        addCandidate("Mamta Banarjee", "All India Trinamool Congress");
        addCandidate("Mayavati", "Bahujan Samaj Party");
        addCandidate("NOTA", "None of the above");
    }

    function addCandidate (string memory name, string memory party) private {
        candidateCount++;
        candidateRegistry[candidateCount] = Candidate(candidateCount, name, party, 0);
    }

    function vote (uint candidateId) public {
        require(!hasVoted[msg.sender]);
        require(candidateId > 0 && candidateId <= candidateCount);

        hasVoted[msg.sender] = true;
        candidateRegistry[candidateId].voteCount++;
        emit VotedEvent(candidateId);
    }
}
