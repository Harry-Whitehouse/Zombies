pragma solidity >=0.5.0;

// importing the zombie factory file

import "./ZombieFactory.sol";

//gives zombieFeeding access to the ZombieFactory file

//interacting with cryptoKitties smart contract using an interface.

//an interface is similar to defining a contract, but we onyl declare
//the functions we want to interact with. but we dont define function
//bodies, we juts end the decleration with a ; instead
contract KittyInterface {
//cryptoKitty surce code which returns all kitty data.
function getKitty(uint256 \_id)
external
view
returns (
//in solidity, a functuon can return several values:

            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );

}

contract ZombieFeeding is ZombieFactory {
//storage variables = variables stored permenantly on the blockchain.
//memory variables = temporary, they are erased between external function calls.

    //cryptoKitties address allows us to read from the smart contract
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

    //we have a "KittyInterface" named "kittyContract" and we are initializing it
    //with the ck address.
    KittyInterface kittyContract = KittyInterface(ckAddress);


                                //added an argument tofind out if the zombie was part cat, and allow us to identify it if so - with an if statement.
                            <!-- function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
                            require(msg.sender == zombieToOwner[_zombieId]);
                            Zombie storage myZombie = zombies[_zombieId];
                            _targetDna = _targetDna % dnaModulus;
                            uint newDna = (myZombie.dna + _targetDna) / 2;
                        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
                        newDna = newDna - newDna % 100 + 99;
                        } -->

    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna) public {
        //require verification that "msg.sender == zombie owner"
        //see: "zombieToOwner[id] = msg.sender;" from _createZombie
        //function where we assign ownership of the zombie using its [id].

        require(msg.sender == zombieToOwner[_zombieId]);

        //if msg.sender == zombie owner, function checks the zombie dna

        Zombie storage myZombie = zombies[_zombieId];

        //^ declaring a local zombie which is a storage pointer
        //this variable is equal to _zombieId in the zombies array:
        //    "Zombie[] public zombies;"

        //making sure target dna isnt longer than 16 digits
        _targetDna = _targetDna % dnaModulus;

        //we can access properties of zombie with dot notation.
        //the zombie struct has name and dna. zombie.dna accesses the dna property
        //here we create newDna with a formula that takes the average of the
        //myZombie.dna and _targetDna.
        uint256 newDna = (myZombie.dna + _targetDna) / 2;

        //then we call "_createZombie" with the name and dna params:
        //"_createZombie(_name, randDna);" howevere, this is a private
        //function inside ZombieFactory.

        // we can use an internal function for this, its similar to a private function,
        //but internal functions are accessible to contracts that inherit from *this* contract
        //_createZombie function was changed from private to internal.
        _createZombie("NoName", newDna);
    }

unction feedOnKitty (uint_zombieId, uint_kittyId) public {
uint kittyDna;
//9 commas becasue genes is the 10th property and wwe dont need to access the others.
(,,,,,,,,,kittyDna) = kittyContract.getKitty(\_kittyId); //calling "kittyContract.getKitty" with \_kittyId
feedAndMultiply(\_zombieId kittyDna);

                                <!-- function feedOnKitty(uint _zombieId, uint _kittyId) public {
                                    uint kittyDna;
                                    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
                                    feedAndMultiply(_zombieId, kittyDna, "kitty");
                        // with added species argument
                                } -->

}

pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract KittyInterface {
function getKitty(uint256 \_id) external view returns (
bool isGestating,
bool isReady,
uint256 cooldownIndex,
uint256 nextActionAt,
uint256 siringWithId,
uint256 birthTime,
uint256 matronId,
uint256 sireId,
uint256 generation,
uint256 genes
);
}

contract ZombieFeeding is ZombieFactory {

address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
KittyInterface kittyContract = KittyInterface(ckAddress);

    _createZombie("NoName", newDna);

}

}
