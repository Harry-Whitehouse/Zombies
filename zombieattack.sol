pragma solidity >=0.5.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    uint256 randNonce = 0;
    uint256 attackVictoryProbability = 70;

    function randMod(uint256 _modulus) internal returns (uint256) {
        randNonce++;
        return
            uint256(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % //takes values and packs them and uses keccak to convert to a random hash.
            _modulus; // hash is converted to an uint and via modulus, will generate a random number between 1&100.
        //
    } // this isnt really a secure way to generat random numbers, but it doesnt matter too much for this game.

    function attack(uint256 _zombieId, uint256 _targetId) external {}
}
