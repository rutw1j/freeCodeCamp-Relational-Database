#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n\n~~~~~ SALON APPOINTMENT CLI ~~~~~\n"

MAIN_MENU(){

  if [[ $1 ]]
  then
    echo -e "\n$1\n"
  fi

  SERVICES=$($PSQL "SELECT * FROM services")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  echo "0) Exit CLI"

  read SERVICE_ID_SELECTED

  if [[ $SERVICE_ID_SELECTED == 0 ]]
  then
    echo -e "\nThankyou for Visiting Us. See you soon."
    echo -e "~~~~ EXITING CLI ~~~~\n"
    exit
  fi

  GET_SERVICE_RESULT=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  if [[ -z $GET_SERVICE_RESULT ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME

      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi
    
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

    echo -e "\nWhat time would you like your$SERVICE_NAME,$CUSTOMER_NAME?"
    read SERVICE_TIME

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

    echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME,$CUSTOMER_NAME."

    MAIN_MENU "How else can we help you?"
  fi
}

MAIN_MENU "Welcome to My Salon, how can I help you?"