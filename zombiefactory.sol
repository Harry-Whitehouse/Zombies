pragma solidity >=0.5.0;

contract ZombieFactory {
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }
    Zombie[] public zombies;
    //mappings are another way of storing organised data in sol
    //it is basically a key-value store for storing and looking up data
    // below we have a mapping called "zombieToOwner" with a uint key and an address value.
    mapping(uint256 => address) public zombieToOwner;
    //this mapping key is an address and the value is a uint
    mapping(address => uint256) ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) private {
        uint256 id = zombies.push(Zombie(_name, _dna)) - 1;
        // msg.sender is a global variable which is available to all functions.
        //it refers to the address of the person or contract that called the current function.
        //in solidity, a function can just sit on the blockchain doing nothing until
        //it is called externally

        //assigning ownership of the zombie to whoever called the function (msg.sender)

        zombieToOwner[id] = msg.sender;

        //increasing the ownerZombieCount for whoever called the function.

        ownerZombieCount[msg.sender]++;

        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        //require makes sure a function will throw an error if a condition isnt true
        //here, we want to make sure that this function can only be called once
        //index 0 =1.
        require(ownerZombieCount[msg.sender] == 0);
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
