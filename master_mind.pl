% Mastermind Game:
% Mastermind is a code-breaking game where the player attempts to guess a secret code.
% The code consists of a sequence of colored pegs chosen from a set of available colors.
% After each guess, the game provides feedback in the form of black and white pegs.
% A black peg indicates that a guessed color is correct and in the correct position.
% A white peg indicates that a guessed color is correct but in the wrong position.
% The player continues guessing until the correct code is guessed or until a maximum number of attempts is reached.
% Define the colors available for the code
color(red).
color(blue).
color(green).
color(yellow).
color(orange).
color(purple).

% Generate a random code of length N using the available colors
generate_code(N, Code) :-
    % Create a list of length N
    length(Code, N),
    % Fill the list with colors chosen randomly from the available colors
    maplist(color, Code).

% Evaluate a guess and provide feedback
evaluate(Code, Guess, Black, White) :-
    % Helper predicate to evaluate the guess
    evaluate(Code, Guess, 0, Black, White).

% Base case: all elements in both Code and Guess are checked
evaluate([], _, Black, Black, 0).

% Case: element in Guess matches corresponding element in Code
evaluate([X|CodeTail], [X|GuessTail], BlackAcc, Black, White) :-
    % If the guessed color is in the same position in the code
    % Increase the count of black pegs and continue with the rest of the list
    evaluate(CodeTail, GuessTail, BlackAcc, BlackNext, White),
    Black is BlackNext + 1.

% Case: element in Guess matches an element in Code, but not in the same position
evaluate([X|CodeTail], BlackAcc, Black, White) :-
    % If the guessed color is in the code but in a different position
    % Increase the count of white pegs and continue with the rest of the list
    member(X, Guess),
    delete(Guess, X, GuessTail),
    evaluate(CodeTail, GuessTail, BlackAcc, Black, WhiteNext),
    White is WhiteNext + 1.

% Case: element in Guess does not match any element in Code
evaluate([_|CodeTail], Guess, BlackAcc, Black, White) :-
    % If the guessed color is not in the code, continue with the rest of the list
    evaluate(CodeTail, Guess, BlackAcc, Black, White).

% Play the Mastermind game
play_mastermind :-
    % Welcome message
    writeln('Welcome to Mastermind!'),
    % Prompt the user to enter the length of the code
    writeln('Enter the length of the code:'),
    read(N),
    % Generate a random code of the specified length
    writeln('Generating a random code...'),
    generate_code(N, Code),
    % Inform the player that the code has been generated and prompt for guesses
    writeln('Code generated. Guess the code!'),
    play_round(Code, 0).

% Play a round of the game
play_round(Code, Attempts) :-
    % Increment the attempt counter
    Attempts1 is Attempts + 1,
    % Display the current attempt number
    write('Attempt '), write(Attempts1), writeln(':'),
    % Read the guess from the user
    read(Guess),
    % Evaluate the guess and provide feedback
    evaluate(Code, Guess, Black, White),
    % Display the number of black and white pegs
    format('Black: ~w, White: ~w~n', [Black, White]),
    % Check if the guess is correct
    (Code = Guess ->
        % If the guess is correct, display a congratulatory message
        writeln('Congratulations! You guessed the code.')
    ;
        % If the guess is incorrect, play another round
        play_round(Code, Attempts1)
    ).
