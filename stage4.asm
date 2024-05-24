  1|; Program combining the input validation and line drawing logic
  2|; Input validation and prompt for name
  3|      MOV R0, #username ; Load address of "Enter your name:" prompt into R0
  4|      STR R0, .WriteString ; Display "Enter your name:" prompt
  5|      MOV R0, #myName   ; Load address of name buffer into R0
  6|      STR R0, .ReadString ; Read the user's name into the buffer
  7|      MOV R0, #myName   ; Load address of name buffer into R0 (again for displaying)
  8|      STR R0, .WriteString ; Display the entered name
  9|      MOV R0, #userinput ; Load address of "How many..." prompt into R0
 10|      STR R0, .WriteString ; Display "How many..." prompt
 11|InputLoop:              ; Label for the input validation loop
 12|      LDR R0, .InputNum ; Load user input (number) into R0
 13|      CMP R0, #10       ; Compare with lower limit (10)
 14|      BLT InvalidInput  ; Branch if less than (invalid)
 15|      CMP R0, #100      ; Compare with upper limit (100)
 16|      BGT InvalidInput  ; Branch if greater than (invalid)
 17|ValidNumber:            ; Label for valid input processing
 18|      MOV R1, R0        ; Store the number in R1 (another register)
 19|      STR R1, .WriteSignedNum ; Display the entered number (initial display)
 20|; Concatenate "Valid input! You entered: " with the number
 21|      MOV R0, #validMsg1 ; Load address of "Valid input! You entered: " string (part 1)
 22|      STR R0, .WriteString ; Display "Valid input! You entered: "
 23|      MOV R0, R1        ; Load the number from R1 again for displaying
 24|      STR R0, .WriteSignedNum ; Display the entered number
 25|      MOV R0, #validMsg2 ; Load address of string (part 2) to complete the message
 26|      STR R0, .WriteString ; Display string completion (e.g., ".\n")
 27|      MOV R0, #myName   ; Load address of the name buffer again (to display)
 28|      STR R0, .WriteString ; Display the entered name
 29|      MOV R0, #player1Msg ; Load address of "Player 1 is" message
 30|      STR R0, .WriteString ; Display "Player 1 is"
 31|; Drawing the specified number of lines
 32|      MOV R8, #.PixelScreen // Start of the mid-res pixel screen memory
 33|      MOV R2, #.red
 34|      MOV R3, #0        // This is our pixel counter
 35|      MOV R5, #0        // Line counter
 36|linesLoop:
 37|      MOV R3, #0        // Reset pixel counter for each line
 38|pixelLoop:
 39|      ADD R4, R8, R3    // R4 now holds the address of the pixel of interest
 40|      STR R2, [R4]      // Paint the pixel at the address specified in R4.
 41|      ADD R3, R3, #4    // Increment the pixel number (by 4 bytes = 1 word = 1 pixel)
 42|      CMP R3, #128      // 256 will be one pixel past the end of the line (64 pixels x 4)
 43|      BLT pixelLoop
 44|      ADD R8, R8, #512  // Move to the start of the next line plus the gap (512 bytes further)
 45|      ADD R5, R5, #1    // Increment line counter
 46|      CMP R5, R1        // Check if we've drawn 5 lines
 47|      BLT linesLoop
 48|      HALT
 49|; Code for invalid input handling
 50|InvalidInput:
 51|      MOV R0, #invalidMsg ; Load address of "Invalid input" message into R0
 52|      STR R0, .WriteString ; Display "Invalid input" message
 53|      B InputLoop       ; Branch back to the input loop (try again)
 54|; Data section
 55|username: .ASCIZ "Please enter your name: " ; Define "Enter your name:" prompt string
 56|userinput: .ASCIZ "\nHow many MatchSticks (10-100)?: " ; Define "How many..." prompt string
 57|invalidMsg: .ASCIZ "Invalid number. Please enter a value between 10 and 100.\n" ; Define "Invalid input" message
 58|validMsg1: .ASCIZ "\nMatchSticks:" ; Define message part 1 (before number)
 59|validMsg2: .ASCIZ "\n"  ; Define message part 2 (after number and newline)
 60|myName: .BLOCK 128      ; Allocate space for the user's name
 61|newline: .ASCIZ ".\n"   ; Define a string containing a newline character
 62|player1Msg: .ASCIZ " is Player 1" ; Define "Player 1 is" message

