#!/bin/zsh

set -euxo pipefail

for payload in `ls ./TEST-QA/payloads/*.json`
do
    echo
    echo "#### Starting submission for "$payload
    echo $payload
    analysis_id=`song-client/bin/sing submit -f $payload | jq -er .analysisId`
    echo $analysis_id
    manifest=$payload".manifest.txt"
    song-client/bin/sing manifest -a $analysis_id -d ./data-files -f $manifest
    score-client/bin/score-client upload --manifest $manifest
    song-client/bin/sing publish -a $analysis_id
    echo "#### Finished submission for "$payload
    echo
    echo

done