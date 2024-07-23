#!/bin/bash

# PSQL database connection variable
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"


START_GAME() {
  # ask user for username
  echo "Enter your username:"
  read USERNAME

  # get username from database
  GET_USER_RESULT=$($PSQL "SELECT games_played, best_game FROM users WHERE username = '$USERNAME'")

  # if user details not found
  if [[ -z $GET_USER_RESULT ]]
  then
    # insert new user to database
    INSERT_NEW_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
    if [[ $INSERT_NEW_USER == "INSERT 0 1" ]]
    then
      # if new user added successfully
      echo "Welcome, $USERNAME! It looks like this is your first time here."
    fi
  else
    # if user details are found
    echo $GET_USER_RESULT | while read GAMES_PLAYED BAR BEST_GAME
    do
      echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    done
  fi

  SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
  NUMBER_OF_GUESSES=0
  echo "Guess the secret number between 1 and 1000:"
  read GUESS

  # loop through until user guesses secret number
  while [[ $GUESS != $SECRET_NUMBER ]]
  do
    if [[ ! $GUESS =~ ^[0-9]+$ ]]
    then
      # if guess is not an integer
      echo "That is not an integer, guess again:"
      read GUESS
    else
      # if guess is an integer then increment number of guesses
      (( NUMBER_OF_GUESSES++ ))
      if [[ $GUESS -gt $SECRET_NUMBER ]]
      then
        # if guess is higher than secret number
        echo "It's lower than that, guess again:"
        read GUESS
      elif [[ $GUESS -lt $SECRET_NUMBER ]]
      then
        # if guess is lower than secret number
        echo "It's higher than that, guess again:"
        read GUESS
      fi
    fi
  done

  # Increment the number of guesses for the correct guess
  (( NUMBER_OF_GUESSES++ ))

  UPDATE_USER_DETAILS=$($PSQL "
  UPDATE users 
  SET 
    games_played = games_played + 1, 
    best_game = CASE
      WHEN best_game = 0 THEN $NUMBER_OF_GUESSES
      WHEN best_game > $NUMBER_OF_GUESSES THEN $NUMBER_OF_GUESSES
      ELSE best_game
    END
  WHERE username = '$USERNAME'
  ")

  if [[ $UPDATE_USER_DETAILS == "UPDATE 1" ]]
  then
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
  fi
}

START_GAME