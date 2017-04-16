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
% Cube Map Guide -
%   Colors: (W)hite, (Y)ellow,  (G)reen,  (B)lue,  (R)ed,   (O)range
%   Sides : (U)p,    (D)own,    (L)eft,   (R)ight, (F)ront, (B)ack
%
%
% The cube is mapped as follows -
%   Side Labels:    UUUUUUUUU DDDDDDDDD LLLLLLLLL RRRRRRRRR FFFFFFFFF BBBBBBBBB
%   Color Labels:   WWWWWWWWW YYYYYYYYY GGGGGGGGG BBBBBBBBB RRRRRRRRR OOOOOOOOO
%                                          ^ variables listed in numerical order
%
%   The cube should be held so the top middle cube (U5/W5) is white.
%   The side that is facing you should have a red cube in the middle (F5/R5).
%   The side on the right of your orientation should have a blue cube in the middle.
%
%
% Visual representation of cube map -
%   Side labels:                Color labels:
%
%            B1 B2 B3                       O1 O2 O3
%            B4 B5 B6                       O4 O5 O6
%            B7 B8 B9                       O7 O8 O9
%   L1 L2 L3 U1 U2 U3 R1 R2 R3     G1 G2 G3 W1 W2 W3 B1 B2 B3
%   L4 L5 L6 U4 U5 U6 R4 R5 R6     G4 G5 G6 W4 W5 W6 B4 B5 B6
%   L7 L8 L9 U7 U8 U9 R7 R8 R9     G7 G8 G9 W7 W8 W9 B7 B8 B9
%            F1 F2 F3                       R1 R2 R3
%            F4 F5 F6                       R4 R5 R6
%            F7 F8 F9                       R7 R8 R9
%            D1 D2 D3                       Y1 Y2 Y3
%            D4 D5 D6                       Y4 Y5 Y6
%            D7 D8 D9                       Y7 Y8 Y9
%
%
% Usage -
%   Now that your cube is in the correct orientation, input your cube map to generate a solution.
%   | :- solve(X, cube(r,w,o,r,w,b,w,w,b, r,r,r,o,y,y,b,y,y, g,g,o,o,g,w,o,g,b, r,r,b,y,b,b,g,o,o, g,g,w,r,r,b,y,y,y, w,g,g,w,o,o,w,b,y), C), solved(C).
%
% Test case -
%   The following is a cube map for a solved cube with the Up side rotated 90 degrees:
%     w,w,w,w,w,w,w,w,w, y,y,y,y,y,y,y,y,y, r,r,r,g,g,g,g,g,g, o,o,o,b,b,b,b,b,b, b,b,b,r,r,r,r,r,r, o,o,o,o,o,o,g,g,g
%
%   To solve, it should require 3 rotations of Up side, with a solution of [up, up, up]. Currently if you trace the execution, you can see that this rule fails.
%   | :- solve(X, cube(w,w,w,w,w,w,w,w,w, y,y,y,y,y,y,y,y,y, r,r,r,g,g,g,g,g,g, o,o,o,b,b,b,b,b,b, b,b,b,r,r,r,r,r,r, o,o,o,o,o,o,g,g,g), C), solved(C).
%
% %

% Define the base case, where all colors are in correct position and the cube is solved
solved(cube(W,W,W,W,W,W,W,W,W,Y,Y,Y,Y,Y,Y,Y,Y,Y,G,G,G,G,G,G,G,G,G,B,B,B,B,B,B,B,B,B,R,R,R,R,R,R,R,R,R,O,O,O,O,O,O,O,O,O)).

% Solve the Rubik's Cube by replacing C with your cube map
solve([], C, C), !.
solve([M | T], C, E) :- solve(T, D, E), write('.'), rotateside(M, C, D).


% Side Rotation translation maps-

% Rotate the Up side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       O1 O2 O3
%            O4 O5 O6                       O4 O5 O6
%            O7 O8 O9                       G7 G8 G9
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     R1 R2 R3 W1 W2 W3 O1 O2 O3
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     G4 G5 G6 W4 W5 W6 B4 B5 B6
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     G7 G8 G9 W7 W8 W9 B7 B8 B9
%            R1 R2 R3                       B1 B2 B3
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
        W1, W2, W3, W4, W5, W6, W7, W8, W9,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        R1, R2, R3, G4, G5, G6, G7, G8, G9,     % left side
        O1, O2, O3, B4, B5, B6, B7, B8, B9,     % right side
        B1, B2, B3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, G7, G8, G9      % back side
        )
).

% Rotate the Front side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       O1 O2 O3
%            O4 O5 O6                       O4 O5 O6
%            O7 O8 O9                       O7 O8 O9
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     G1 G2 Y3 W1 W2 W3 W1 B2 B3
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     G4 G5 Y6 W4 W5 W6 W4 B5 B6
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     G7 G8 Y9 G7 G8 G9 W7 B8 B9
%            R1 R2 R3                       R1 R2 R3
%            R4 R5 R6                       R4 R5 R6
%            R7 R8 R9                       R7 R8 R9
%            Y1 Y2 Y3                       B1 B2 B3
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
        B1, B2, B3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G1, G2, Y3, G4, G5, Y6, G7, G8, Y9,     % left side
        W1, B2, B3, W4, B5, B6, W7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
        )
).

% Rotate the Left side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       Y1 O2 O3
%            O4 O5 O6                       Y4 O5 O6
%            O7 O8 O9                       Y7 O8 O9
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     G1 G2 G3 O1 W2 W3 B1 B2 B3
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     G4 G5 G6 O4 W5 W6 B4 B5 B6
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     G7 G8 G9 O7 W8 W9 B7 B8 B9
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
        G1, G2, G3, G4, G5, G6, G7, G8, G9,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
        ),
    % to new cube map with Left side rotated clockwise by 90 degrees:
    cube(
        O1, W2, W3, O4, W5, W6, O7, W8, W9,     % top side
        R1, Y2, Y3, R4, Y5, Y6, R7, Y8, Y9,     % bottom side
        G1, G2, G3, G4, G5, G6, G7, G8, G9,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        W1, R2, R3, W4, R5, R6, W7, R8, R9,     % front side
        Y1, O2, O3, Y4, O5, O6, Y7, O8, O9      % back side
        )
).
