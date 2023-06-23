#!/bin/bash

modes=()

help_message="
-o (off) Nothing is enabled. Xdebug does no work besides checking whether functionality is enabled. Use this setting if you want close to 0 overhead.
-D (develop) Enables Development Aids including the overloaded var_dump().
-c (coverage) Enables Code Coverage Analysis to generate code coverage reports, mainly in combination with PHPUnit.
-d (debug) Enables Step Debugging. This can be used to step through your code while it is running, and analyse values of variables.
-g (gcstats) Enables Garbage Collection Statistics to collect statistics about PHP's Garbage Collection Mechanism.
-p (profile) Enables Profiling, with which you can analyse performance bottlenecks with tools like KCacheGrind.
-t (trace) Enables the Function Trace feature, which allows you record every function call, including arguments, variable assignment, and return value that is made during a request to a file.
"

OPTIONS=oDcdgpth

! PARSED=$(getopt --options=$OPTIONS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    exit 2
fi

eval set -- "$PARSED"

while true; do
    case "$1" in
        -h) 
            echo "$help_message"
            shift
            ;;
        -o) 
            modes+=("off")
            shift
            ;;
        -D) 
            modes+=("develop")
            shift
            ;;
        -c) 
            modes+=("coverage")
            shift
            ;;
        -d) 
            modes+=("debug")
            shift
            ;;
        -g) 
            modes+=("gcstats")
            shift
            ;;
        -p) 
            modes+=("profile")
            shift
            ;;
        -t) 
            modes+=("trace")
            shift
            ;;
        --)
            shift
            break
            ;;
    esac
done

if [ ${#modes[@]} -gt 0 ]
then

    function join_by { local d=$1; shift; local f=$1; shift; printf %s "$f" "${@/#/$d}"; }
    string_modes=$(join_by , "${modes[@]}")
    echo "$string_modes"
    sudo sed -i "s/xdebug\.mode=.*/xdebug.mode=$string_modes/" /usr/local/etc/php/conf.d/20-xdebug.ini
    kill -USR2 1
