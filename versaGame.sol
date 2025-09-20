// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract GameContract {
    uint256 public gameFee;
    mapping(address => bool) public hasPaidToPlay;
    address public owner;

    // Event to emit when a player pays to play
    event PlayerRegistered(address indexed player, uint256 feePaid);

    constructor(uint256 _gameFee) {
        owner = msg.sender;
        gameFee = _gameFee;
    }

    /**
     * @dev Allows a player to pay the fee and register for the game.
     * @notice Emits `PlayerRegistered` on success.
     */
    function playGame() public payable {
        require(msg.value == gameFee, "Incorrect fee paid");
        hasPaidToPlay[msg.sender] = true;
        emit PlayerRegistered(msg.sender, msg.value);
    }

    /**
     * @dev Withdraws contract balance to the owner.
     * @notice Only callable by the owner.
     */
    function withdraw() public {
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }

    /**
     * @dev Updates the game fee (owner-only).
     */
    function setGameFee(uint256 _newFee) public {
        require(msg.sender == owner, "Not owner");
        gameFee = _newFee;
    }
}