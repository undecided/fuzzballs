#!/usr/bin/env bash

export APP="coffee/app/*.coffee"
export TESTS="coffee/tests/*.coffee"

coffee -w -j js/script.js -c $APP &
coffee -w -j js/tests.js -c $APP $TESTS