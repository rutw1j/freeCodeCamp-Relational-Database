#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games;")

# INSERTING DATA TO TEAMS TABLE
cat games.csv | while IFS="," read YEAR ROUND WINR OPPN WING OPPG
do
    if [[ $WINR != "winner" && $OPPN != "opponent" ]]
    then
        # get team_id using winner column
        WINR_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINR';")
        # if not found
        if [[ -z $WINR_TEAM_ID ]]
        then
            # insert winner team to teams
            WINR_INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$WINR');")
            if [[ $WINR_INSERT_TEAMS_RESULT == "INSERT 0 1" ]]
            then
                echo "Inserted into teams, $WINR"
            fi
        fi

        # get team_id using opponent column
        OPPN_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPN';")
        # if not found
        if [[ -z $OPPN_TEAM_ID ]]
        then
            # insert opponent team to teams
            OPPN_INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPN');")
            if [[ $OPPN_INSERT_TEAMS_RESULT == "INSERT 0 1" ]]
            then
                echo "Inserted into teams, $OPPN"
            fi
        fi
    fi
done
# INSERTING DATA TO TEAMS TABLE


# INSERTING DATA TO GAMES TABLE
cat games.csv | while IFS="," read YEAR ROUND WINR OPPN WING OPPG
do
    if [[ $YEAR != "year" ]]
    then
        WINR_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINR';")
        OPPN_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPN';")

        INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINR_TEAM_ID, $OPPN_TEAM_ID, $WING, $OPPG);")
        if [[ $INSERT_GAMES_RESULT == "INSERT 0 1" ]]
        then
            echo Inserted into games, $YEAR, $ROUND, $WINR_TEAM_ID, $OPPN_TEAM_ID, $WING, $OPPG
        fi
    fi
done
# INSERTING DATA TO GAMES TABLE