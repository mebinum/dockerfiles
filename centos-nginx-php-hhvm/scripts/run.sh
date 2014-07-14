#!/bin/bash
set -e -x
echo "starting supervisor in foreground"
supervisord -n
