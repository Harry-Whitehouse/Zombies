pragma solidity >=0.5.0;

import "./zombiefactory.sol";

contract KittyInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
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
    //commented out code could cause issues if ckaddress was affected.

    // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d; //address on ethereum

    // KittyInterface kittyContract = KittyInterface(ckAddress); //kitty contract points to interface above

    // //we can now call from the kittyInterface contract.

    KittyInterface kittyContract; //declare the variable

    function setKittyContractAddress(address _address) external ownerOnly {
        //fucntion allows us to change the address in furture if required
        kittyContract = KittyInterface(_address);
    }

    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2; //from zombie struct in Zombie factory
        if (
            keccak256(abi.encodePacked(_species)) ==
            keccak256(abi.encodePacked("kitty")) //checks that zombie ate kitty
        ) {
            newDna = newDna - (newDna % 100) + 99; //change last 2 digits to 99 based on if statement
        }
        _createZombie("NoName", newDna);
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        //storing "genes" the 10th variable of "getKitty" in "kittyDna"
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
