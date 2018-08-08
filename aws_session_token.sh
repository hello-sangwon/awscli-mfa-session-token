#!/bin/bash

# 참고 문서:
# https://www.vividcortex.com/blog/setting-up-multi-factor-authentication-with-the-aws-cli
# https://gist.github.com/incognick/c121038dbd2180c683fda6ae5e30cba3

function usage() {
    echo "aws_session_token.sh <profile> <token_code>"
}

PROFILE=$1
TOKEN=$2
if [ -z "$PROFILE" ] || [ -z "$TOKEN" ]; then
    usage
    exit 1
fi

function aws_session_token() {
    PROF=$1
    TOKEN_CODE=$2

    cp ~/.aws/credentials.ini ~/.aws/credentials
    ID=`aws sts get-caller-identity --profile $PROF | jq -r '.Arn' | sed s'/:user/:mfa/'`
    SESSION_TOKEN_RESPONSE=$(aws sts get-session-token \
        --serial-number $ID \
        --token-code ${TOKEN_CODE} \
        --duration-seconds 129600 \
        --profile ${PROF} | \
        jq -r '.Credentials | "\(.AccessKeyId) \(.SecretAccessKey) \(.SessionToken)"')
    read access_key_id secret_access_key session_token <<< $SESSION_TOKEN_RESPONSE

    echo "[default]"                                    >  ~/.aws/credentials
    echo "aws_access_key_id = $access_key_id"           >> ~/.aws/credentials
    echo "aws_secret_access_key = $secret_access_key"   >> ~/.aws/credentials
    echo "aws_session_token = $session_token"           >> ~/.aws/credentials

    cat ~/.aws/credentials.ini >> ~/.aws/credentials
}

aws_session_token $PROFILE $TOKEN
