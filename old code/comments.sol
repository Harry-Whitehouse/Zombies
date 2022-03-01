pragma solidity >=0.5.0;

contract ZombieFactory {
    //events are a way for a contract to comunicate somehitng
    // has happened; on the blockchain, to the app frontend.
    //the frontend can be 'listening' for this and can take action if needed.

    //this event lets our front end know a new zombie has
    //been created so the front end can display it.
    //we can fire this event in a function - see "Create Zombie"

    event NewZombie(uint256 zombieId, string name, uint256 dna);

    //uint is an unsiged interger,
    // this means it cant be negative
    // because they dont carry a + or - sign
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    //structs are for more complex data types.
    //they can have mulitple properties
    //
    struct Zombie {
        string name;
        uint256 dna;
    }

    //arrays can be fixed or dynamic.
    //"uint[2] fixedArray;" would be a fixed array with two elememts.
    //arrays can be public (sytax below)
    // other contracts can read but not write to public arrays

    Zombie[] public zombies;

    //fucntions. there are two ways to pass and arguemnt in a solidity function

    //> By Value -  which means the compiler creates a new copy of the paramaters value
    //and passes it to the function, this allows the function to modify the value without
    //the value of the initial parameter actually getting changed.

    // > By reference, which means the functuon is called with a reference to the
    // original variable. so, if the function changes the value of the variabe
    // it recieves, the value of the original variable gets changed.

    function _createZombie(string memory _name, uint256 _dna) private {
        uint256 id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    //naming convention for private functions start with an underscore. functions are public by default!

    //here is a private function which returns a random interger.
    //for this we use keccak256 which maps an input to a 256bit number.
    //any slight change will cause a totally differnt hash to be output.
    //keccak is type casted as an 'uint' : "uint(keccak256(abi.encodePacked(_str)"
    //this uint is then stored in another 'uint' called 'rand':"uint rand = uint(keccak256(abi.encodePacked(_str)))"
    //we want the dna to be 16 digits long so we then take the modulus of the hash with
    //reference to the dnaModulus: " return rand % dnaModulus; "

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    //function takes an input and uses this to create a xombie with random dna
    //
    function createRandomZombie(string memory _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
