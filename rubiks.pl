% %
% Rubik's Cube Solver
% Solve a 3x3x3 Rubik's Cube
%
% Authors -
%   Trent Rand <contact@Trentrand.com>
%   Robert Dinaro
%
% Documentation -
%   Please see the README file or presentation for more information.
%
% Usage -
%   With your cube in the correct orientation, as explained in the documentation, input your cube map to generate a solution.
%   Input each face in the order specfied above by the 'Order of Input' representation above.
%
%   For example, the following is how you can solve a solved cube with F,R,U applied:
%   | :- solve(Solution, cube(g,w,w,g,w,w,r,r,r,b,b,o,y,y,o,y,y,o,g,g,r,g,g,r,y,y,b,o,b,b,o,b,b,g,b,b,w,w,w,r,r,y,r,r,y,o,o,w,o,o,w,y,g,g), C), solved(C).
%
% %

% Define the base case, where all colors are in correct position and the cube is solved
solved(cube(W,W,W,W,W,W,W,W,W,Y,Y,Y,Y,Y,Y,Y,Y,Y,G,G,G,G,G,G,G,G,G,B,B,B,B,B,B,B,B,B,R,R,R,R,R,R,R,R,R,O,O,O,O,O,O,O,O,O)).

% Solve the Rubik's Cube by inputting your cube map as variable Cube
solve([], Cube, Cube).
solve([NextRotation | Rotation], Cube, NewState) :- solve(Rotation, CurrentState, NewState), rotateside(NextRotation, Cube, CurrentState).


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
%            O1 O2 O3                       G7 G4 G1
%            O4 O5 O6                       O4 O5 O6
%            O7 O8 O9                       O7 O8 O9
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     R7 G2 G3 W1 W2 W3 B1 B2 O1
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     R8 G5 G6 W4 W5 W6 B4 B5 O2
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     R9 G8 G9 W7 W8 W9 B7 B8 O3
%            R1 R2 R3                       R1 R2 R3
%            R4 R5 R6                       R4 R5 R6
%            R7 R8 R9                       B9 B6 B3
%            Y1 Y2 Y3                       Y3 Y6 Y9
%            Y4 Y5 Y6                       Y2 Y5 Y8
%            Y7 Y8 Y9                       Y1 Y4 Y7
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
        Y3, Y6, Y9, Y2, Y5, Y8, Y1, Y4, Y7,     % bottom side
        R7, G2, G3, R8, G5, G6, R9, G8, G9,     % left side
        B1, B2, O1, B4, B5, O2, B7, B8, O3,     % right side
        R1, R2, R3, R4, R5, R6, B9, B6, B3,     % front side
        G7, G4, G1, O4, O5, O6, O7, O8, O9      % back side
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

% Rotate the Right side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       O1 O2 W3
%            O4 O5 O6                       O4 O5 W6
%            O7 O8 O9                       O7 O8 W9
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     G1 G2 G3 W1 W2 R3 B7 B4 B1
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     G4 G5 G6 W4 W5 R6 B8 B5 B2
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     G7 G8 G9 W7 W8 R9 B9 B6 B3
%            R1 R2 R3                       R1 R2 Y3
%            R4 R5 R6                       R4 R5 Y6
%            R7 R8 R9                       R7 R8 Y9
%            Y1 Y2 Y3                       Y1 Y2 O3
%            Y4 Y5 Y6                       Y4 Y5 O6
%            Y7 Y8 Y9                       Y7 Y8 O9
rotateside(
    right,
    % translate cube map from:
    cube(
        W1, W2, W3, W4, W5, W6, W7, W8, W9,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G1, G2, G3, G4, G5, G6, G7, G8, G9,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
    ),
    % to new cube map with Right side rotated clockwise by 90 degrees:
    cube(
        W1, W2, R3, W4, W5, R6, W7, W8, R9,     % top side
        Y1, Y2, O3, Y4, Y5, O6, Y7, Y8, O9,     % bottom side
        G1, G2, G3, G4, G5, G6, G7, G8, G9,     % left side
        B7, B4, B1, B8, B5, B2, B9, B6, B3,     % right side
        R1, R2, Y3, R4, R5, Y6, R7, R8, Y9,     % front side
        O1, O2, W3, O4, O5, W6, O7, O8, W9      % back side
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

% Rotate the Back side clockwise by 90 degrees
%   From:                        To:
%
%            O1 O2 O3                       O3 O6 O9
%            O4 O5 O6                       O2 O5 O8
%            O7 O8 O9                       O1 O4 O7
%   G1 G2 G3 W1 W2 W3 B1 B2 B3     Y9 Y8 Y7 G1 G2 G3 W1 W2 W3
%   G4 G5 G6 W4 W5 W6 B4 B5 B6     G4 G5 G6 W4 W5 W6 B4 B5 B6
%   G7 G8 G9 W7 W8 W9 B7 B8 B9     G7 G8 G9 W7 W8 W9 B7 B8 B9
%            R1 R2 R3                       R1 R2 R3
%            R4 R5 R6                       R4 R5 R6
%            R7 R8 R9                       R7 R8 R9
%            Y1 Y2 Y3                       Y1 Y2 Y3
%            Y4 Y5 Y6                       Y4 Y5 Y6
%            Y7 Y8 Y9                       B3 B2 B1
rotateside(
    back,
    % translate cube map from:
    cube(
        W1, W2, W3, W4, W5, W6, W7, W8, W9,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9,     % bottom side
        G1, G2, G3, G4, G5, G6, G7, G8, G9,     % left side
        B1, B2, B3, B4, B5, B6, B7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O1, O2, O3, O4, O5, O6, O7, O8, O9      % back side
    ),
    % to new cube map with Back side rotated clockwise by 90 degrees:
    cube(
        G1, G2, G3, W4, W5, W6, W7, W8, W9,     % top side
        Y1, Y2, Y3, Y4, Y5, Y6, B3, B2, B1,     % bottom side
        Y9, Y8, Y7, G4, G5, G6, G7, G8, G9,     % left side
        W1, W2, W3, B4, B5, B6, B7, B8, B9,     % right side
        R1, R2, R3, R4, R5, R6, R7, R8, R9,     % front side
        O3, O6, O9, O2, O5, O8, O1, O4, O7      % back side
    )
).
