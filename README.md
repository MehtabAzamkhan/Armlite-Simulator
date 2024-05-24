# ARMLite Simulator Project
This project is an ARM assembly program that serves as a simulator for a matchstick game, combined with a line drawing feature. The program prompts the user for their name and the number of matchsticks, performs input validation, and then allows the user to play a matchstick game against the computer. Additionally, it demonstrates line drawing on a simulated pixel screen.

## Features
- Prompts the user for their name and the number of matchsticks (10-100).
- Validates user input for the number of matchsticks.
- Simulates a matchstick game where the player and the computer take turns to remove matchsticks.
- Displays messages indicating the winner of the game.
- Draws a specified number of lines on a simulated pixel screen.

## Files
- stage1.asm: Initial code for prompting and validating the user's name and number of matchsticks.
- stage2.asm: Adds the main game loop, handling both player and computer turns.
- stage3.asm: Adds logic for handling the end of the game and restarting the game.
- stage4.asm: Combines input validation and line drawing logic.

## Usage
- Assemble the ARM assembly code using an assembler that supports ARM syntax.
- Load the assembled code into an ARMLite simulator or any ARM emulator that supports the required system calls.
- Run the program.

## Sample Run
1. The program prompts: Please enter your name:.
2. The user enters their name.
3. The program prompts: How many MatchSticks (10-100)?:.
4. The user enters a number between 10 and 100.
5. The game begins, with the player and the computer taking turns to remove 1-7 matchsticks.
6. The program displays messages indicating each move.
7. The game continues until there are no matchsticks left.
8. The program announces the winner (the player or the computer).
9. After the game ends, the program asks if the user wants to play again.
10. If the user chooses to play again, the game restarts from step 3; otherwise, the program ends.
11. The program then proceeds to draw the specified number of lines on a simulated pixel screen.

## Code Overview

Stage 1
Prompts the user for their name and the number of matchsticks.
Validates the number of matchsticks to be between 10 and 100.

Stage 2
Implements the game loop where the player and the computer take turns to remove matchsticks.
Displays messages for each move and checks for game over conditions.

Stage 3
Adds logic to determine the winner of the game.
Handles restarting or ending the game based on user input.

Stage 4
Adds functionality to draw lines on a simulated pixel screen.

## Running the code:
Load armlite into your ARM simulator and execute it.

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or enhancements.
