# Serverless Certificate Vending Machine

Based on [awslabs/aws-iot-certificate-vending-machine](awslabs/aws-iot-certificate-vending-machine) this deployment uses Serverless framework instead

## Setup Serverless

```bash
npm install -g serverless
serverless config credentials --provider aws --key <ACCESS KEY ID> --secret <SECRET KEY>
```

## Requirements

```bash
serverless plugin install -n serverless-pseudo-parameters
```

Add the following to the `serveress.yml` file

```yaml
plugins:
  - serverless-pseudo-parameters
```

## Deploy

```bash
npm install
serverless deploy

# api keys:
#   None
# endpoints:
#   GET - https://XXXXXXXXXXXXX.execute-api.us-east-1.amazonaws.com/dev/getcert
#   ANY - https://XXXXXXXXXXXXX.execute-api.us-east-1.amazonaws.com/dev/shadow
# functions:
#   cvm: serverless-cvm-dev-cvm
# layers:
#   None
```

## Create Device

```bash
aws dynamodb put-item \
  --table-name iot-cvm-device-info \
  --item '{"deviceToken":{"S":"secret_key"},"serialNumber":{"S":"devopstar-iot-01"}}'
```

### Retrieve Certificates

```bash
https://XXXXXXXXXXXXX.execute-api.us-east-1.amazonaws.com/dev/getcert?serialNumber=devopstar-iot-01&deviceToken=secret_key

# {
#     "certificateArn": "arn:aws:iot:us-east-1::cert/009f.........",
#     "certificateId": "009ff......",
#     "certificatePem": "-----BEGIN CERTIFICATE-----\nMIIDW......-----END CERTIFICATE-----\n",
#     "keyPair": {
#         "PublicKey": "-----BEGIN PUBLIC KEY-----\nMIIBIj.......-----END PUBLIC KEY-----\n",
#         "PrivateKey": "-----BEGIN RSA PRIVATE KEY-----\nMI........-----END RSA PRIVATE KEY-----\n"
#     },
#     "RootCA": "-----BEGIN CERTIFICATE-----\r\nMIIE0zCC........-----END CERTIFICATE-----"
# }
```

## Attribution

* [awslabs/aws-iot-certificate-vending-machine](https://github.com/awslabs/aws-iot-certificate-vending-machine)
* [Support re-issue certificates; Updated CF to use SAM; Upgrade to nodejs8 /w promises](https://github.com/brightsparc/aws-iot-certificate-vending-machine)
