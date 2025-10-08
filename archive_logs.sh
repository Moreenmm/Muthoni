#!/bin/bash

#ARCHIVAL SCRIPT FOR HOSPITAL DATA

# create path variables
LOG_PATH="hospital_data/active_logss/"
HEART_ARCHIVE="hospital_data/archived_logs/heart_data_archive/"
TEMP_ARCHIVE="hospital_data/archived_logs/temperature_data_archive/"
WATER_ARCHIVE="hospital_data/archived_logs/water_usage_data_archive/"

#ensuring that the directories exist and initializing a menu option for the user input

mkdir -p "HEART_ARCHIVE" "TEMP_ARCHIVE" "WATER_ARCHIVE"

echo "enter the notation of the file you want to archive"
echo "a) heart_rate.log"
echo "b) temperature.log"
echo "c) water_usage.log"
read -p "enter your preferred file choice (a-b): " choice

#initiate a condition to update the archival details

case $choice in
	a)
		LOG_FILE="$LOG_PATH/heart_rate.log"
		ARCHIVE_DIR="$HEART_ARCHIVE"
		BASE_NAME="heart_rate"
		;;

	b)
		LOG_FILE="$LOG_PATH/temperature.log"
		ARCHIVE_DIR="$TEMP_ARCHIVE"
		BASE_NAME="temperature"
		;;

	c)
		LOG_FILE="$LOG_PATH/water_usage.log"                                  ARCHIVE_DIR="$WATER_ARCHIVE"                                          BASE_NAME="water_usage"                                               ;;
	*)
		echo "Error: Invalid choice, please enter a,b or c"
		exit 1
		;;
esac

#check if the files exist

if [ ! -f "$LOG_FILE"]; then
	echo "Error! file '$LOG_FILE' does not exist"
	exit 1 
fi

#update the naming and create timestamp variables

TIMESTAMP="(date +%y-%m-%d_%H:%M:%S)"
ARCHIVALFILE_NAME="${BASE_NAME}_${TIMESTAMP}.log"
ARCHIVAL_PATH="$ARCHIVE_DIR/$ARCHIVALFILE_NAME"

#move to the designated archive folder and create an new empty log file
if mv "$LOG_FILE" "$ARCHIVAL_PATH" 2>/dev/null; then
touch "$LOG_FILE"
    echo "Successfully archived to $ARCHIVAL_PATH and created $LOG_FILE"
else
	echo "Error: Failed to move the $LOG_FILE to $ARCHIVAL_PATH." 
	
fi

echo "MISSION SUCCESSFUL!!"

