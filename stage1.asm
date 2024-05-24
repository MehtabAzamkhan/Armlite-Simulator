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
      HALT              ; Stop execution (after displaying everything)
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
myName: .BLOCK 128      ; Allocate space for the user's name
newline: .ASCIZ ".\n"   ; Define a string containing a newline character
player1Msg: .ASCIZ " is Player 1" ; Define "Player 1 is" message
