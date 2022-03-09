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
        //fucntion allows the owner(contract deployer) to change the address in furture if required
        kittyContract = KittyInterface(_address);
    }

    modifier ownerOf(uint256 _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]); //creating an "ownerOf" modifier to use later to check if the body is true before executing the called fucntion
        _;
    }

    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    }

    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= now); //makes sure enough time has passed before feeding again.
    }

    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) internal ownerOf(_zombieId) {
        //allows removal of "require(msg.sender == zombieToOwner[_zombieId]);" and makes the code neater
        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie)); //require _isReady to be
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        if (
            keccak256(abi.encodePacked(_species)) ==
            keccak256(abi.encodePacked("kitty"))
        ) {
            newDna = newDna - (newDna % 100) + 99;
        }
        _createZombie("NoName", newDna);
        _triggerCooldown(myZombie);
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        //storing "genes" the 10th variable of "getKitty" in "kittyDna"
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
