#!/bin/bash

value=$(<.version)

docker push sderunov/serge-dotnet:"$value"

sleep 5
