// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Strings.sol";

contract PedraPapelTesoura {
    using Strings for *;
    enum Choice {ROCK, PAPER, SCISSORS}
    uint8 result;
    Choice cpuChoice;
    Choice playerChoice;

    function getRandomFromHash() internal view returns (Choice ch) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp))) % 3;
        if (randomNumber + 1 == 1) {return Choice.ROCK;}
        if (randomNumber + 1 == 2) {return Choice.PAPER;}
        else if (randomNumber + 1 == 3) {return Choice.SCISSORS;}
    }

    function convertPlayerChoice(uint8 choice) internal pure returns (Choice ch) {
        if (choice + 1 == 1) {return Choice.ROCK;}
        if (choice + 1 == 2) {return Choice.PAPER;}
        else if (choice + 1 == 3) {return Choice.SCISSORS;}
    }

    function convertChoiceToString(Choice choice) internal pure returns (string memory str) {
        if (choice == Choice.ROCK) {return " Rock";}
        if (choice == Choice.PAPER) {return " Paper";}
        else if (choice == Choice.SCISSORS) {return " Scissors";}
    }

    function playerWin(Choice player, Choice cpu) internal pure returns (uint8) {
        if  (player == Choice.SCISSORS && cpu == Choice.PAPER || 
            (player == Choice.PAPER && cpu == Choice.ROCK) || 
            (player == Choice.ROCK && cpu == Choice.SCISSORS)) { return 1; }
        if  (player == cpu) { return 3; }
        else {
            return 2;
        }
    }

    function concatStrings(string memory a, string memory b, string memory c) internal pure returns (string memory) {
        return string(abi.encodePacked(a, b, " VS ", c));
    }

    function showWinner() public view returns (string memory str) {
        string memory player = "Player wins by";
        string memory cpu = "Cpu wins by";
        string memory pchoice = convertChoiceToString(playerChoice);
        string memory cpuchoice = convertChoiceToString(cpuChoice);
        
        if (result == 1) { return concatStrings(player, pchoice, cpuchoice); }
        if (result == 2) { return concatStrings(cpu, pchoice, cpuchoice); }
        if (result == 3) { return "We have a draw, play again!";}
    }

    function play(uint8 choice) public {
        require(choice >= 1 && choice <= 3, "Your choice must be 1 - ROCK, 2 - PAPER, 3 - SCISSORS");
        cpuChoice = getRandomFromHash();
        playerChoice = convertPlayerChoice(choice);
        result = playerWin(playerChoice, cpuChoice);
    }
}
