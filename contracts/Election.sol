// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Election {
    address public admin;
    uint256 candidateCount;
    uint256 voterCount;
    bool start;
    bool end;

    constructor() {
        // Initializing default values
        admin = msg.sender;
        candidateCount = 0;
        voterCount = 0;
        start = false;
        end = false;
    }

    function getAdmin() public view returns (address) {
        // Returns account address used to deploy contract (i.e. admin)
        return admin;
    }

    modifier onlyAdmin() {
        // Modifier for only admin access
        require(msg.sender == admin, "Only admin can access this function");
        _;
    }
    
    // Modeling a candidate
    struct Candidate {
        uint256 candidateId;
        string header;
        string slogan;
        uint256 voteCount;
    }
    mapping(uint256 => Candidate) public candidateDetails;

    // Adding new candidates
    function addCandidate(string memory _header, string memory _slogan)
        public
        onlyAdmin
    {
        candidateDetails[candidateCount] = Candidate({
            candidateId: candidateCount,
            header: _header,
            slogan: _slogan,
            voteCount: 0
        });
        candidateCount += 1;
    }

    // Modeling an Election Details
    struct ElectionDetails {
        string adminName;
        string adminEmail;
        string adminTitle;
        string electionTitle;
        string organizationTitle;
    }
    ElectionDetails electionDetails;

    function setElectionDetails(
        string memory _adminName,
        string memory _adminEmail,
        string memory _adminTitle,
        string memory _electionTitle,
        string memory _organizationTitle
    )
        public
        onlyAdmin
    {
        electionDetails = ElectionDetails(
            _adminName,
            _adminEmail,
            _adminTitle,
            _electionTitle,
            _organizationTitle
        );
        start = true;
        end = false;
    }

    // Get Election details
    function getElectionDetails()
        public
        view
        returns (
            string memory adminName, 
            string memory adminEmail, 
            string memory adminTitle, 
            string memory electionTitle, 
            string memory organizationTitle
        ) 
    {
        return (
            electionDetails.adminName, 
            electionDetails.adminEmail, 
            electionDetails.adminTitle, 
            electionDetails.electionTitle, 
            electionDetails.organizationTitle
        );
    }

    // Get candidates count
    function getTotalCandidate() public view returns (uint256) {
        // Returns total number of candidates
        return candidateCount;
    }

    // Get voters count
    function getTotalVoter() public view returns (uint256) {
        // Returns total number of voters
        return voterCount;
    }

    // Modeling a voter
    struct Voter {
        address voterAddress;
        string name;
        string phone;
        bool isVerified;
        bool hasVoted;
        bool isRegistered;
    }
    address[] public voters; // Array of address to store addresses of voters
    mapping(address => Voter) public voterDetails;

    // Request to be added as voter
    function registerAsVoter(string memory _name, string memory _phone) public {
        require(!voterDetails[msg.sender].isRegistered, "Voter is already registered");
        voterDetails[msg.sender] = Voter({
            voterAddress: msg.sender,
            name: _name,
            phone: _phone,
            hasVoted: false,
            isVerified: false,
            isRegistered: true
        });
        voters.push(msg.sender);
        voterCount += 1;
    }

    // Verify voter
    function verifyVoter(bool _verifiedStatus, address voterAddress)
        public
        onlyAdmin
    {
        require(voterDetails[voterAddress].isRegistered, "Voter is not registered");
        voterDetails[voterAddress].isVerified = _verifiedStatus;
    }

    // Vote
    function vote(uint256 candidateId) public {
        require(voterDetails[msg.sender].hasVoted == false, "Voter has already voted");
        require(voterDetails[msg.sender].isVerified == true, "Voter is not verified");
        require(start == true, "Election has not started yet");
        require(end == false, "Election has ended");
        candidateDetails[candidateId].voteCount += 1;
        voterDetails[msg.sender].hasVoted = true;
    }

    // End election
    function endElection() public onlyAdmin {
        end = true;
        start = false;
    }

    // Get election start and end values
    function getStart() public view returns (bool) {
        return start;
    }

    function getEnd() public view returns (bool) {
        return end;
    }
}