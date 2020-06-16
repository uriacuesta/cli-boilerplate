#! /bin/sh
# Use Single Brackets [] for /bin/sh 
# Double Brackets [[]] for /bin/bash

# NOTES
# Follow Google Styleguide for shell scripts
# https://google.github.io/styleguide/shellguide.html

# @TODO
# Add Auto Completion

# Configuration
set -e  # Exit when any command fails

# Utility Functions

# Help text
help() {
  printf -- 'Base shell scripts\n';
  printf -- '\n'
  printf -- '   -f | --flag [--name]] \n';
  printf -- '  -mp | --multi [--target] [--destination] \n';
  printf -- '   -t | --target \n';
  printf -- '   -d | --destination \n';
  printf -- '   -h | --help \n';
  check_command foo
  exit 0;
}

# Check if required commands is available
check_command() {
  # Check if command is available
  if ! [ -x "$(command -v $1)" ]; then
    printf -- "\033[0;31m";
    printf -- " You don't seem to have '$1' installed.\n";
    printf -- " Please install $1 \n";
    exit 127;
  fi;
}

# Generic Named Parameters
while [ ! -z "$1" ]; do
  case "$1" in
    -f|--flag)
      FLAG=1
      ;;
    -mp|--multi)
      MULTI_PARAMETER="$1"
      ;;
    -t|--target)
      shift
      TARGET="$1"
      ;;
    -d|--destination)
      shift
      DESTINATION="$1"
      ;;
    -h|--help)
      show_usage
      ;;
  esac
  shift
done

# Variables
RUN_DIRECTORY="$(pwd)" # Variable for running tasks relative to current directory

# Tasks

# Example usage of flag arguments
# shell.sh --flag
flag() {
  if [ ! -z $FLAG ]; then
    printf -- 'FLAG is set\n'
  else
    printf -- "-f or --flag not-set\n"
  fi
}

# Example usage of multi arguments
# shell.sh --multi --destination foo --target '/bar'
multi_parameter() {
  if [ ! -z $TARGET ] && [ ! -z $DESTINATION ]; then
  
    # Check if it starts with '/'
    # Posix must use case
    case $TARGET in
      "/"*) 
        printf -- "Target: ${TARGET}\n" ;;
      *) 
        printf -- "Target: ${RUN_DIRECTORY}/${TARGET}\n";;
    esac

    case $DESTINATION in
      "/"*) 
        printf -- "Destination: ${DESTINATION}\n" ;;
      *) 
        printf -- "Destination: ${RUN_DIRECTORY}/${DESTINATION}\n";;
    esac

    # Double Brackets only work in bash
    # if [[ $TARGET == /* ]]; then
    #   printf -- "Target: ${TARGET}\n"
    # else
    #   printf -- "Target: ${RUN_DIRECTORY}/${TARGET}\n"
    # fi

    # if [[ $DESTINATION == /* ]]; then
    #   printf -- "Destination: ${DESTINATION}\n"
    # else
    #   printf -- "Destination: ${RUN_DIRECTORY}/${DESTINATION}\n"
    # fi
  else
    printf -- "--target or --destination not-set\n"
  fi
}

# Main Function
main() {
  if [ ! -z $FLAG ]; then
    printf -- "Running Flag command: \n"
    flag
  elif [ ! -z $MULTI_PARAMETER ]; then
    printf -- "Running Multi Parameter command: \n"
    multi_parameter
  else
    help
  fi
}

# Run main function
main
