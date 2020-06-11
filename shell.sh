#! /bin/sh

# pipelines.sh

# NOTES
# Follow Google Styleguide for shell scripts
# https://google.github.io/styleguide/shellguide.html

# Configuration
# exit when any command fails
set -e

# Utility Functions

# Help text
show_usage() {
  printf -- 'Base shell scripts\n';
  printf -- '\n'
  printf -- '   -f | --flag [--name]] \n';
  printf -- '  -mp | --multi [--target] [--destination] \n';
  printf -- '   -t | --target \n';
  printf -- '   -d | --destination \n';
  printf -- '   -h | --help \n';
  check_commands
  exit 0;
}

# Check if required commands is available
check_commands() {
  if ! [ -x "$(command -v foo)" ]; then
    printf -- "\nYou don't seem to have foo installed.\n";
    printf -- 'Please install foo \n';
    printf -- 'Exiting with code 127...\n';
    exit 127;
  else
    echo "foo --version"
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
RUN_DIRECTORY="$(pwd)"

# Tasks
flag() {
  if [ ! -z $FLAG ]; then
    printf -- 'FLAG is set\n'
  else
    printf -- "-f or --flag not-set\n"
  fi
}

multi_parameter() {
  if [ ! -z $TARGET ] && [ ! -z $DESTINATION ]; then
    printf -- "Target: ${TARGET}\n"
    printf -- "Destination: ${DESTINATION}\n"
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
    show_usage
  fi
}

# Run main function
main
