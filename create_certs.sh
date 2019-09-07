#!/bin/bash

# https://XXXXXX.execute-api.us-east-1.amazonaws.com/dev/getcert?serialNumber=devopstar-iot-01&deviceToken=1234567890
ENDPOINT_URL="$1"

# Retrieve Certs
certificates=$(curl $ENDPOINT_URL)
certificatePemCrt=$(echo $certificates | jq '.certificatePem')
certificatePemKey=$(echo $certificates | jq '.keyPair.PrivateKey')
certificateRootCa=$(echo $certificates | jq '.RootCA')

# Save to files
echo -n $certificatePemCrt | sed 's/\\n/\n/g' | sed 's/"//g' > certs/iot-certificate.pem.crt
echo -n $certificatePemKey | sed 's/\\n/\n/g' | sed 's/"//g' > certs/iot-private.pem.key
echo -n $certificateRootCa | sed 's/\\n/\n/g' | sed 's/"//g' > certs/iot-root-ca.crt