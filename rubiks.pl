% %
% Rubik's Cube Solver
% Solve a 3x3x3 Rubik's Cube
%
% Authors -
%   Trent Rand <contact@Trentrand.com>
%   Robert Dinaro
%   David A Gutierrez
%
%
% Cube Map Variable Reference -
%   Colors: (W)hite, (Y)ellow,  (G)reen,  (B)lue,  (R)ed,   (O)range
%   Sides : (U)p,    (D)own,    (L)eft,   (R)ight, (F)ront, (B)ack
%
%
% The cube map is structured as follows -
%   Side Labels:    UUUUUUUUU DDDDDDDDD LLLLLLLLL RRRRRRRRR FFFFFFFFF BBBBBBBBB
%   Color Labels:   WWWWWWWWW YYYYYYYYY GGGGGGGGG BBBBBBBBB RRRRRRRRR OOOOOOOOO
%                                          ^ variables listed in numerical order
%
%
% Visual order of
%   Order of sides:                Order of pieces:
%
%            ## ## ##                       46 47 48
%            ## 6  ##                       49 50 51
%            ## ## ##                       52 53 54
%   ## ## ## ## ## #### ## ##      19 20 21 1  2  3  28 29 30
%   ## 3  ## ## 1  #### 4  ##      22 23 24 4  5  6  31 32 33
%   ## ## ## ## ## #### ## ##      25 26 27 7  8  9  34 35 36
%            ## ## ##                       37 38 39
%            ## 5  ##                       40 41 42
%            ## ## ##                       43 44 45
%            ## ## ##                       10 11 12
%            ## 2  ##                       13 14 15
%            ## ## ##                       16 17 18
%
%
% Test case -
%   The following is a cube map for a solved cube with the Left side rotated 90 degrees:
%     o,w,w,o,w,w,o,w,w, r,y,y,r,y,y,r,y,y, g,g,g,g,g,g,g,g,g, b,b,b,b,b,b,b,b,b, w,r,r,w,r,r,w,r,r, y,o,o,y,o,o,y,o,o
%
%   To solve, it should require 3 rotations of Left side, with a solution of [left,left,left].
%   | :- solve(X, cube(o,w,w,o,w,w,o,w,w, r,y,y,r,y,y,r,y,y, g,g,g,g,g,g,g,g,g, b,b,b,b,b,b,b,b,b, w,r,r,w,r,r,w,r,r, y,o,o,y,o,o,y,o,o), C), solved(C).
%   X = [left,left,left] ?
%
%
% Visual representation of a solved cube map -
%
% Color labels:                   Side labels:
%           B1 B2 B3                       O1 O2 O3
%           B4 B5 B6                       O4 O5 O6
%           B7 B8 B9                       O7 O8 O9
%  L1 L2 L3 U1 U2 U3 R1 R2 R3     G1 G2 G3 W1 W2 W3B1 B2 B3
%  L4 L5 L6 U4 U5 U6 R4 R5 R6     G4 G5 G6 W4 W5 W6B4 B5 B6
%  L7 L8 L9 U7 U8 U9 R7 R8 R9     G7 G8 G9 W7 W8 W9B7 B8 B9
%           F1 F2 F3                       R1 R2 R3
%           F4 F5 F6                       R4 R5 R6
%           F7 F8 F9                       R7 R8 R9
%           D1 D2 D3                       Y1 Y2 Y3
%           D4 D5 D6                       Y4 Y5 Y6
%           D7 D8 D9                       Y7 Y8 Y9
%
%   The cube should be held so the top middle cube (U5/W5) is white.
%   The side that is facing you should have a red cube in the middle (F5/R5).
%   The side on the right of your orientation should have a blue cube in the middle.
%
% Cube map string:
%   W,W,W,W,W,W,W,W,W,Y,Y,Y,Y,Y,Y,Y,Y,Y,G,G,G,G,G,G,G,G,G,B,B,B,B,B,B,B,B,B,R,R,R,R,R,R,R,R,R,O,O,O,O,O,O,O,O,O
%
%
% Usage -
%   Now that your cube is in the correct orientation, input your cube map to generate a solution. Input each face in the order specfied
%   | :- solve(X, cube(b,w,w,r,w,w,r,o,o, o,y,r,o,y,r,g,y,r, r,r,w,g,g,g,g,g,g, o,b,b,o,b,b,y,b,b, y,b,b,y,r,w,y,r,w, w,o,y,w,o,y,o,g,g), C), solved(C).
%
% %

% Define the base case, where all colors are in correct position and the cube is solved
solved(cube(W,W,W,W,W,W,W,W,W,Y,Y,Y,Y,Y,Y,Y,Y,Y,G,G,G,G,G,G,G,G,G,B,B,B,B,B,B,B,B,B,R,R,R,R,R,R,R,R,R,O,O,O,O,O,O,O,O,O)).

% Solve the Rubik's Cube by replacing C with your cube map
solve([], C, C).
solve([M | T], C, E) :- solve(T, D, E), rotateside(M, C, D).


% Side Rotation translation maps-

% Rotate the Up side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       O1 O2 O3
%            O4 O5 O6                       O4 O5 O6
%            O7 O8 O9                       G9 G6 G3
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     G1 G2 R1 W7 W4 W1 O7 B2 B3
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     G4 G5 R2 W8 W5 W2 O8 B5 B6
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     G7 G8 R3 W9 W6 W3 O9 B8 B9
%            R1 R2 R3                       B7 B4 B1
%            R4 R5 R6                       R4 R5 R6
%            R7 R8 R9                       R7 R8 R9
%            Y1 Y2 Y3                       Y1 Y2 Y3
%            Y4 Y5 Y6                       Y4 Y5 Y6
%            Y7 Y8 Y9                       Y7 Y8 Y9
rotateside(
    up,
    % translate cube map from:
    cube(
        W1, W2, W3, W4, W5, W6, W7, W8, W9,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G1, G2, G3, G4, G5, G6, G7, G8, G9,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
        ),
    % to new cube map with Up side rotated clockwise by 90 degrees:
    cube(
        W7, W4, W1, W8, W5, W2, W9, W6, W3,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G1, G2, R1, G4, G5, R2, G7, G8, R3,     % left side
        O7, B2, B3, O8, B5, B6, O9, B8, B9,     % right side
        B7, B4, B1, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, G9, G6, G3      % back side
        )
).

% Rotate the Down side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       B3 B6 B9
%            O4 O5 O6                       O4 O5 O6
%            O7 O8 O9                       O7 O8 O9
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     O3 G2 G3 W1 W2 W3 B1 B2 R9
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     O2 G4 G5 W4 W5 W6 B4 B5 R8
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     O1 G6 G7 W7 W8 W9 B7 B8 R7
%            R1 R2 R3                       R1 R2 R3
%            R4 R5 R6                       R4 R5 R6
%            R7 R8 R9                       G1 G4 G7
%            Y1 Y2 Y3                       Y7 Y4 Y1
%            Y4 Y5 Y6                       Y8 Y5 Y2
%            Y7 Y8 Y9                       Y9 Y6 Y3
rotateside(
    down,
    % translate cube map from:
    cube(
        W1, W2, W3, W4, W5, W6, W7, W8, W9,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G1, G2, G3, G4, G5, G6, G7, G8, G9,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
        ),
    % to new cube map with Down side rotated clockwise by 90 degrees:
    cube(
        W1, W2, W3, W4, W5, W6, W7, W8, W9,     % top side
        Y7, Y4, Y1, Y8, Y5, Y2, Y9, Y6, Y3,     % bottom side
        O3, G2, G3, O2, G4, G5, O1, G6, G7,     % left side
        B1, B2, R9, B4, B5, R8, B7, B8, R7,     % right side
        R1, R2, R3, R4, R5, R6, G1, G4, G7,     % front side
        B3, B6, B9, O4, O5, O6, O7, O8, O9      % back side
        )
).

% Rotate the Front side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       O1 O2 O3
%            O4 O5 O6                       O4 O5 O6
%            O7 O8 O9                       O7 O8 O9
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     G1 G2 G3 W1 W2 W3 B1 B2 B3
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     G4 G5 G6 W4 W5 W6 B4 B5 B6
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     Y3 Y2 Y1 G7 G8 G9 W7 W8 W9
%            R1 R2 R3                       R7 R4 R1
%            R4 R5 R6                       R8 R5 R2
%            R7 R8 R9                       R9 R6 R3
%            Y1 Y2 Y3                       B9 B8 B7
%            Y4 Y5 Y6                       Y4 Y5 Y6
%            Y7 Y8 Y9                       Y7 Y8 Y9
rotateside(
    front,
    % translate cube map from:
    cube(
        W1, W2, W3, W4, W5, W6, W7, W8, W9,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G1, G2, G3, G4, G5, G6, G7, G8, G9,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
        ),
    % to new cube map with Front side rotated clockwise by 90 degrees:
    cube(
        W1, W2, W3, W4, W5, W6, G7, G8, G9,     % top side
        B9, B8, B7, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G1, G2, G3, G4, G5, G6, Y3, Y2, Y1,     % left side
        B1, B2, B3, B4, B5, B6, W7, W8, W9,     % right side
        R7, R4, R1, R8, R5, R2, R9, R6, R3,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
        )
).

% Rotate the Left side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       Y1 O2 O3
%            O4 O5 O6                       Y4 O5 O6
%            O7 O8 O9                       Y7 O8 O9
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     G7 G4 G1 O1 W2 W3 B1 B2 B3
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     G8 G5 G2 O4 W5 W6 B4 B5 B6
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     G9 G6 G3 O7 W8 W9 B7 B8 B9
%            R1 R2 R3                       W1 R2 R3
%            R4 R5 R6                       W4 R5 R6
%            R7 R8 R9                       W7 R8 R9
%            Y1 Y2 Y3                       R1 Y2 Y3
%            Y4 Y5 Y6                       R4 Y5 Y6
%            Y7 Y8 Y9                       R7 Y8 Y9
rotateside(
    left,
    % translate cube map from:
    cube(
        W1, W2, W3, W4, W5, W6, W7, W8, W9,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G7, G4, G1, G8, G5, G2, G9, G6, G3,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
        ),
    % to new cube map with Left side rotated clockwise by 90 degrees:
    cube(
        O1, W2, W3, O4, W5, W6, O7, W8, W9,     % top side
        R1, Y2, Y3, R4, Y5, Y6, R7, Y8, Y9,     % bottom side
        G7, G4, G1, G8, G5, G2, G9, G6, G3,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        W1, R2, R3, W4, R5, R6, W7, R8, R9,     % front side
        Y1, O2, O3, Y4, O5, O6, Y7, O8, O9      % back side
        )
).
