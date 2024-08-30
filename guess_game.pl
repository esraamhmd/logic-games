% Guessing Game:
% This is a simple guessing game where the player tries to guess a randomly selected number between 1 and 100.

:- dynamic answer/1.

% Start the game
start :-
    write('Welcome to the guessing game!'), nl, nl, % Welcome message
    write('I have selected a number between 1 and 100.'), nl, % Instructions to the player
    write('Can you guess what it is?'), nl, % Prompt to guess the number
    retractall(answer(_)), % Clear any previous answers
    random(1, 101, Answer), % Generate a random number between 1 and 100
    assertz(answer(Answer)), % Store the answer
    guess_number. % Start the guessing process

% The guessing process
guess_number :-
    repeat,
    write('Enter your guess: '), % Prompt the player to enter their guess
    read(Guess), % Read the guess from the player
    process_guess(Guess). % Process the guess

% Process the guess
process_guess(Guess) :-
    answer(Answer),
    Guess =:= Answer, % Check if the guess is correct
    write('Congratulations! You guessed it right.'), nl, nl, % Congratulate the player
    retractall(answer(_)), % Clear the answer
    write('----------------------------------'), nl, % Print line here
    start. % Start a new game

process_guess(Guess) :-
    answer(Answer),
    Guess < Answer, % Check if the guess is too low
    write('Too low! Try again.'), nl, % Prompt the player to guess higher
    guess_number. % Continue the guessing process

process_guess(Guess) :-
    answer(Answer),
    Guess > Answer, % Check if the guess is too high
    write('Too high! Try again.'), nl, % Prompt the player to guess lower
    guess_number. % Continue the guessing process
