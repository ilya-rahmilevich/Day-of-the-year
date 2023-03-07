#! /bin/bash

function get_days_from_year () {
  months=("Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
  day=$1
  month=$2
  year=$3

  return $(date -d "${months[$month-1]} $day $year" +%j)
}

function get_days_from_month () {
  days=(31 28 31 30 31 30 31 31 30 31 30 31)

  month=$1
  year=$2
  if [[ ${days[$month-1]} -gt 2 && $((year%4)) -eq 0 ]] && [[ $((year%100)) -ne 0 || $((year%400)) -eq 0 ]]; then
    let "days[$month-1]++"
  fi
  return ${days[$month-1]}
}

function leap_year () {
  year=$1
  if [[ $((year%4)) -eq 0 ]]; then 
    if [[ $((year%100)) -eq 0 ]]; then
      if [[ $((year%400)) -eq 0 ]]; then 
        echo "Leap year"
      else
        echo "Common year"
      fi
    else
      echo "Common year"
    fi
  else
    echo "Common year"
  fi
}

function menu () {

  if (($# == 3)); then
    get_days_from_year $@
  elif (($# == 2)); then
    get_days_from_month $@
  elif (($# == 1)); then
    leap_year $@
  fi
  
  echo "Result:" $?
}

menu $@
