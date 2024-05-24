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
      MOV R1, R0        ; Store the number in R1 (another register)
      STR R1, .WriteSignedNum ; Display the entered number (initial display)
; Concatenate "Valid input! You entered: " with the number
      MOV R0, #validMsg1 ; Load address of "Valid input! You entered: " string (part 1)
      STR R0, .WriteString ; Display "Valid input! You entered: "
      MOV R0, R1        ; Load the number from R1 again for displaying
      STR R0, .WriteSignedNum ; Display the entered number
      MOV R0, #validMsg2 ; Load address of string (part 2) to complete the message
      STR R0, .WriteString ; Display string completion (e.g., ".\n")
      MOV R0, #myName   ; Load address of the name buffer again (to display)
      STR R0, .WriteString ; Display the entered name
      MOV R0, #player1Msg ; Load address of "Player 1 is" message
      STR R0, .WriteString ; Display "Player 1 is"
      MOV R3, R1        ; Store the total number of matchsticks in R3
GameLoop:               ; Label for the game loop
      CMP R3, #0        ; Compare with 0 (check if all matchsticks are gone)
      BEQ GameOver      ; Branch if equal to 0 (game over)
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
      STR R0, .WriteString ; Display string completion (e
      B GameLoop        ; Repeat the game loop
GameOver:               ; Label for the game over message
      MOV R0, #gameOverMsg ; Load address of "Game Over" message into R0
      STR R0, .WriteString ; Display "Game Over" message
      HALT              ; Stop execution
; Code for invalid input handling
InvalidInput:
      MOV R0, #invalidMsg ; Load address of "Invalid input" message into R0
      STR R0, .WriteString ; Display "Invalid input" message
      B InputLoop       ; Branch back to the input loop (try again)
username: .ASCIZ "Please enter your name: " ; Define "Enter your name:" prompt string
userinput: .ASCIZ "\nHow many MatchSticks (10-100)?: " ; Define "How many..." prompt string
invalidMsg: .ASCIZ "Invalid number. Please enter a value between 10 and 100.\n" ; Define "Invalid input" message
validMsg1: .ASCIZ "\nMatchSticks:" ; Define message part 1 (before number)
validMsg2: .ASCIZ "\n"  ; Define message part 2 (after number and newline)
removePrompt: .ASCIZ "\nPlayer, how many do you want to remove (1-7)? " ; Define the remove prompt message
removeMsg1: .ASCIZ "You chose to remove: " ; Define message part 1 (before number)
removeMsg2: .ASCIZ "\n" ; Define message part 2 (after number and newline)
gameOverMsg: .ASCIZ "\nGame Over\n" ; Define the "Game Over" message
myName: .BLOCK 128      ; Allocate space for the user's name
newline: .ASCIZ ".\n"   ; Define a string containing a newline character
player1Msg: .ASCIZ " is Player 1" ; Define "Player 1 is" message
