#! /bin/bash

set -euo pipefail


latest_version=$(cat VERSION)
latest_short_version=${latest_version%.*}

cp -r /src/content/$latest_short_version /src/content/latest
cp /src/content/$latest_short_version/_index.md  /src/content/_index.md

ls /src/content/
