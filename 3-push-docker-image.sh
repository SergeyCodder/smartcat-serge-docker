#!/bin/bash

value=$(<.version)

docker push smartcatcom/serge:"$value"

sleep 5
