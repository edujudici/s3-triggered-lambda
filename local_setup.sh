#/bin/bash

S3_BUCKET="my-bucket"
LAMBDA_NAME="my-lambda"

# Create S3 bucket
aws --endpoint-url=http://localhost:4566 s3 mb s3://${S3_BUCKET}

# Deployment package
# zip function.zip main; rm main

# Deploy lambda
aws --endpoint-url=http://localhost:4566 lambda create-function \
    --region us-east-1 \
    --function-name ${LAMBDA_NAME} \
    --runtime nodejs12.x \
    --handler index.handler \
    --memory-size 128 \
    --zip-file fileb://lambda-src/function.zip \
    --role arn:aws:iam::000000000000:role/irrelevant \
    --environment \
        "{\"Variables\":
            {
                \"AWS_REGION\": \"us-east-1\",
                \"AWS_ENDPOINT\": \"http://localstack:4566\",
                \"S3_BUCKET\": \"${S3_BUCKET}\"
            }
        }"