# Rubik's Cube Solver
###### Prolog solution for solving a 3x3x3 Rubik's Cube

#### Authors
* Trent Rand <<contact@Trentrand.com>>
* Robert Dinaro
* David A Gutierrez

#### Cube Map Guide
```
Colors: (W)hite, (Y)ellow,  (G)reen,  (B)lue,  (R)ed,   (O)range
Sides : (U)p,    (D)own,    (L)eft,   (R)ight, (F)ront, (B)ack
```

The cube is mapped in the following structure, where variables are listed in numerical order presented in the visual representation below:
```
   Side Labels:    UUUUUUUUU DDDDDDDDD LLLLLLLLL RRRRRRRRR FFFFFFFFF BBBBBBBBB
   Color Labels:   WWWWWWWWW YYYYYYYYY GGGGGGGGG BBBBBBBBB RRRRRRRRR OOOOOOOOO
```
1. The cube should be held so the top middle cube (U5/W5) is white.
2. The side that is facing you should have a red cube in the middle (F5/R5).
3. The side on the right of your orientation should have a blue cube in the middle.


#### Visual representation of cube map
```bash
   Side labels:                Color labels:

            B1 B2 B3                       O1 O2 O3
            B4 B5 B6                       O4 O5 O6
            B7 B8 B9                       O7 O8 O9
   L1 L2 L3 U1 U2 U3 R1 R2 R3     G1 G2 G3 W1 W2 W3 B1 B2 B3
   L4 L5 L6 U4 U5 U6 R4 R5 R6     G4 G5 G6 W4 W5 W6 B4 B5 B6
   L7 L8 L9 U7 U8 U9 R7 R8 R9     G7 G8 G9 W7 W8 W9 B7 B8 B9
            F1 F2 F3                       R1 R2 R3
            F4 F5 F6                       R4 R5 R6
            F7 F8 F9                       R7 R8 R9
            D1 D2 D3                       Y1 Y2 Y3
            D4 D5 D6                       Y4 Y5 Y6
            D7 D8 D9                       Y7 Y8 Y9
```

#### Usage
   Now that your cube is in the correct orientation, input your cube map to generate a solution.
   
   ```
   | :- solve(X, cube(r,w,o,r,w,b,w,w,b, r,r,r,o,y,y,b,y,y, g,g,o,o,g,w,o,g,b, r,r,b,y,b,b,g,o,o, g,g,w,r,r,b,y,y,y, w,g,g,w,o,o,w,b,y), C), solved(C).
   ```
#### Test case
   The following is a cube map for a solved cube with the Up side rotated 90 degrees:
   
   ```w,w,w,w,w,w,w,w,w, y,y,y,y,y,y,y,y,y, r,r,r,g,g,g,g,g,g, o,o,o,b,b,b,b,b,b, b,b,b,r,r,r,r,r,r, o,o,o,o,o,o,g,g,g ```

   To solve, it should require 3 rotations of Up side, with a solution of [up, up, up]. Currently if you trace the execution, you can see that this rule fails.
   
   ```| :- solve(X, cube(w,w,w,w,w,w,w,w,w, y,y,y,y,y,y,y,y,y, r,r,r,g,g,g,g,g,g, o,o,o,b,b,b,b,b,b, b,b,b,r,r,r,r,r,r, o,o,o,o,o,o,g,g,g), C), solved(C).```

 
