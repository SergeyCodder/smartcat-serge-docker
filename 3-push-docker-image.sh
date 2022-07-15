#!/bin/bash

value=$(<.version)

docker push docker-registry.smartcat.ai/serge-dotnet:"$value"

sleep 5
