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
                                         ^ variables listed in numerical order
```
1. The cube should be held so the top middle cube (U5/W5) is white.
2. The side that is facing you should have a red cube in the middle (F5/R5).
3. The side on the right of your orientation should have a blue cube in the middle.


#### Visual representation of cube map
```bash
   Side labels:                Color labels:                    Order of Input:

            B1 B2 B3                       O1 O2 O3                         46 47 48
            B4 B5 B6                       O4 O5 O6                         49 50 51
            B7 B8 B9                       O7 O8 O9                         52 53 54
   L1 L2 L3 U1 U2 U3 R1 R2 R3     G1 G2 G3 W1 W2 W3 B1 B2 B3       19 20 21 1  2  3  28 29 30
   L4 L5 L6 U4 U5 U6 R4 R5 R6     G4 G5 G6 W4 W5 W6 B4 B5 B6       22 23 24 4  5  6  31 32 33
   L7 L8 L9 U7 U8 U9 R7 R8 R9     G7 G8 G9 W7 W8 W9 B7 B8 B9       25 26 27 7  8  9  34 35 36
            F1 F2 F3                       R1 R2 R3                         37 38 39
            F4 F5 F6                       R4 R5 R6                         40 41 42
            F7 F8 F9                       R7 R8 R9                         43 44 45
            D1 D2 D3                       Y1 Y2 Y3                         10 11 12
            D4 D5 D6                       Y4 Y5 Y6                         13 14 15
            D7 D8 D9                       Y7 Y8 Y9                         16 17 18
```

#### Usage
   Now that your cube is in the correct orientation, input your cube map to generate a solution. Input each face in the order specfied above.

   For example, the following is how you can solve a solved cube with F,R,U applied:
   ```
   | :- solve(Solution, cube(g,w,w,g,w,w,r,r,r,b,b,o,y,y,o,y,y,o,g,g,r,g,g,r,y,y,b,o,b,b,o,b,b,g,b,b,w,w,w,r,r,y,r,r,y,o,o,w,o,o,w,y,g,g), C), solved(C).
   ```

#### Test case
   The following is a cube map for a solved cube with the Left side rotated 90 degrees:

   ```o,w,w,o,w,w,o,w,w, r,y,y,r,y,y,r,y,y, g,g,g,g,g,g,g,g,g, b,b,b,b,b,b,b,b,b, w,r,r,w,r,r,w,r,r, y,o,o,y,o,o,y,o,o```

   To solve, it should require 3 rotations of Left side, with a solution of [left,left,left].

   ```| ?- solve(Solution, cube(o,w,w,o,w,w,o,w,w, r,y,y,r,y,y,r,y,y, g,g,g,g,g,g,g,g,g, b,b,b,b,b,b,b,b,b, w,r,r,w,r,r,w,r,r, y,o,o,y,o,o,y,o,o), C), solved(C).```
