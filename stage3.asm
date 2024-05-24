      MOV R0, #username ; Load address of "Enter your name:" prompt into R0
      STR R0, .WriteString ; Display "Enter your name:" prompt
      MOV R0, #myName   ; Load address of name buffer into R0
      STR R0, .ReadString ; Read the user's name into the buffer
      MOV R0, #myName   ; Load address of name buffer into R0 (again for displaying)
      STR R0, .WriteString ; Display the entered name
      MOV R0, #userinput ; Load address of "How many..." prompt into R0
      STR R0, .WriteString ; Display "How many..." prompt
InputLoop:              ; Label for the input validation loop
      LDR R0, .InputNum ; Load user input (number) into R0
      CMP R0, #10       ; Compare with lower limit (10)
      BLT InvalidInput  ; Branch if less than (invalid)
      CMP R0, #100      ; Compare with upper limit (100)
      BGT InvalidInput  ; Branch if greater than (invalid)
ValidNumber:            ; Label for valid input processing
      MOV R3, R0        ; Store the total number of matchsticks in R3
      STR R0, .WriteSignedNum ; Display the entered number (initial display)
      MOV R0, #validMsg1 ; Load address of "Valid input! You entered: " string (part 1)
      STR R0, .WriteString ; Display "Valid input! You entered: "
      MOV R0, R3        ; Load the number from R3 again for displaying
      STR R0, .WriteSignedNum ; Display the entered number
      MOV R0, #validMsg2 ; Load address of string (part 2) to complete the message
      STR R0, .WriteString ; Display string completion (e.g., ".\n")
      MOV R0, #myName   ; Load address of the name buffer again (to display)
      STR R0, .WriteString ; Display the entered name
      MOV R0, #player1Msg ; Load address of "Player 1 is" message
      STR R0, .WriteString ; Display "Player 1 is"
GameLoop:               ; Label for the game loop
      CMP R3, #0        ; Compare with 0 (check if all matchsticks are gone)
      BEQ DrawGame      ; Branch if equal to 0 (draw game)
; Human Player's Turn
      MOV R0, #removePrompt ; Load address of the remove prompt message into R0
      STR R0, .WriteString ; Display the remove prompt message
PromptLoop:             ; Label for the prompt validation loop
      LDR R2, .InputNum ; Read the number of matchsticks to remove
      CMP R2, #1        ; Compare with lower limit (1)
      BLT PromptLoop    ; Branch back to the prompt validation loop if less than (invalid)
      CMP R2, #7        ; Compare with upper limit (7)
      BGT PromptLoop    ; Branch back to the prompt validation loop if greater than (invalid)
      CMP R2, R3        ; Compare with remaining matchsticks
      BGT PromptLoop    ; Branch back to the prompt validation loop if greater than remaining matchsticks (invalid)
      SUB R3, R3, R2    ; Update the total number of matchsticks remaining
      MOV R0, #removeMsg1 ; Load address of the "You chose to remove: " string
      STR R0, .WriteString ; Display "You chose to remove: "
      STR R2, .WriteUnsignedNum ; Display the entered number of matchsticks to remove
      MOV R0, #removeMsg2 ; Load address of string (part 2) to complete the message
      STR R0, .WriteString ; Display string completion (e.g., ".\n")
      CMP R3, #1        ; Check if only one matchstick is left
      BEQ PlayerWins    ; If so, the player wins
      CMP R3, #0        ; Check if no matchsticks are left
      BEQ DrawGame      ; If so, it's a draw
; Computer Player's Turn
      MOV R0, #compTurnMsg ; Load address of "Computers turn" message into R0
      STR R0, .WriteString ; Display "Computers turn" message
CompTurnLoop:           ; Label for the computer's turn loop
      LDR R2, .Random   ; Generate a random number
      AND R2, R2, #7    ; Limit the random number to 1-7
      CMP R2, #1        ; Ensure the random number is at least 1
      BLT CompTurnLoop  ; If less than 1, generate again
      CMP R2, R3        ; Ensure the random number does not exceed remaining matchsticks
      BGT CompTurnLoop  ; If greater, generate again
      SUB R3, R3, R2    ; Update the total number of matchsticks remaining
      MOV R0, #compRemoveMsg1 ; Load address of the "Computer chose to remove: " string
      STR R0, .WriteString ; Display "Computer chose to remove: "
      STR R2, .WriteUnsignedNum ; Display the number of matchsticks the computer removed
      MOV R0, #removeMsg2 ; Load address of string (part 2) to complete the message
      STR R0, .WriteString ; Display string completion (e.g., ".\n")
      CMP R3, #1        ; Check if only one matchstick is left
      BEQ ComputerWins  ; If so, the computer wins
      CMP R3, #0        ; Check if no matchsticks are left
      BEQ DrawGame      ; If so, it's a draw
      B GameLoop        ; Repeat the game loop
PlayerWins:             ; Label for the player winning message
      MOV R0, #playerWinsMsg ; Load address of "Player <name>, YOU WIN!" message
      STR R0, .WriteString ; Display "Player <name>, YOU WIN!" message
      B PlayAgain       ; Ask to play again
ComputerWins:           ; Label for the computer winning message
      MOV R0, #myName   ; Load address of name buffer into R0 (again for displaying)
      STR R0, .WriteString ; Display the entered name
      MOV R0, #playerLosesMsg ; Load address of "Player <name>, YOU LOSE!" message
      STR R0, .WriteString ; Display "Player <name>, YOU LOSE!" message
      B PlayAgain       ; Ask to play again
DrawGame:               ; Label for the draw game message
      MOV R0, #drawMsg  ; Load address of "It's a draw!" message
      STR R0, .WriteString ; Display "It's a draw!" message
      B PlayAgain       ; Ask to play again
; Code for invalid input handling
InvalidInput:
      MOV R0, #invalidMsg ; Load address of "Invalid input" message into R0
      STR R0, .WriteString ; Display "Invalid input" message
      B InputLoop       ; Branch back to the input loop (try again)
PlayAgain:              ; Label for asking to play again
      MOV R0, #playAgainMsg ; Load address of "Play again (y/n)?" message
      STR R0, .WriteString ; Display "Play again (y/n)?"
      MOV R0, #responseBuffer ; Load address of response buffer into R0
      STR R0, .ReadString ; Read the player's response into the buffer
      MOV R0, #responseBuffer ; Load the address of the response buffer into R0
      LDRB R1, [R0]     ; Load the first character of the response into R1
      CMP R1, #121      ; Compare response with 'y'
      BEQ RestartGame   ; If 'y', restart the game
      CMP R1, #110      ; Compare response with 'n'
      BEQ EndGame       ; If 'n', end the game
      B PlayAgain       ; If any other input, ask again
RestartGame:            ; Label for restarting the game
      B ResetGame       ; Branch to reset game settings
EndGame:                ; Label for ending the game
      HALT              ; Stop execution
ResetGame:              ; Label for resetting game settings
      MOV R0, #userinput ; Load address of "How many..." prompt into R0
      STR R0, .WriteString ; Display "How many..." prompt
      B InputLoop       ; Branch to input loop
username: .ASCIZ "Please enter your name: " ; Define "Enter your name:" prompt string
userinput: .ASCIZ "\nHow many MatchSticks (10-100)?: " ; Define "How many..." prompt string
invalidMsg: .ASCIZ "Invalid number. Please enter a value between 10 and 100.\n" ; Define "Invalid input" message
validMsg1: .ASCIZ "\nMatchSticks:" ; Define message part 1 (before number)
validMsg2: .ASCIZ "\n"  ; Define message part 2 (after number and newline)
removePrompt: .ASCIZ "\nPlayer, how many do you want to remove (1-7)? " ; Define the remove prompt message
removeMsg1: .ASCIZ "You chose to remove: " ; Define message part 1 (before number)
removeMsg2: .ASCIZ "\n" ; Define message part 2 (after number and newline)
compTurnMsg: .ASCIZ "\nComputer's turn\n" ; Define the computer's turn message
compRemoveMsg1: .ASCIZ "Computer chose to remove: " ; Define message part 1 for computer
gameOverMsg: .ASCIZ "\nGame Over\n" ; Define the "Game Over" message
myName: .BLOCK 128      ; Allocate space for the user's name
newline: .ASCIZ ".\n"   ; Define a string containing a newline character
player1Msg: .ASCIZ " is Player 1" ; Define "Player 1 is" message
playerWinsMsg: .ASCIZ "Player, YOU WIN!\n" ; Define "Player <name>, YOU WIN!" message
playerLosesMsg: .ASCIZ "Player, YOU LOSE!\n" ; Define "Player <name>, YOU LOSE!" message
drawMsg: .ASCIZ "It's a draw!\n" ; Define "It's a draw!" message
playAgainMsg: .ASCIZ "Play again (y/n)? " ; Define "Play again (y/n)?" message
responseBuffer: .BLOCK 1 ; Allocate space for the player's response