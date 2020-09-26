#!/bin/bash

nohup java -jar jenkins.war  > jenkins.log 2>&1 </dev/null &
