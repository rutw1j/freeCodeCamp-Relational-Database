#!/bin/bash

# PSQL
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# if no argument provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
# if argument is number
elif [[ $1 =~ ^[0-9]+$  ]]
then
  # get element using its atomic_number
  RESULT=$($PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
  # if not found
  if [[ -z RESULT ]]
  then
    echo "I could not find that element in the database."
  fi
  # if found
  echo $RESULT | while read NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
  do
    echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
# if argument is element symbol
elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
then
  # get element using its symbol
  RESULT=$($PSQL "SELECT atomic_number, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'")
  # if not found
  if [[ -z RESULT ]]
  then
    echo "I could not find that element in the database."
  fi
  # if found
  echo $RESULT | while read ATOMIC_NUMBER BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($1). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
# if argument is element name
elif [[ $1 =~ ^[A-Z][a-z]{2,}$ ]]
then
  # get element using its name
  RESULT=$($PSQL "SELECT atomic_number, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'")
  # if not found
  if [[ -z RESULT ]]
  then
    echo "I could not find that element in the database."
  fi
  # if found
  echo $RESULT | while read ATOMIC_NUMBER BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $1 ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $1 has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
# if no element found
else
  echo "I could not find that element in the database."
fi
