import './env_config.dart';
const AppClientId = EnvConfig.APP_CLIENT_ID;
const AppClientSecret = EnvConfig.APP_CLIENT_SECRET;
const PoolId = EnvConfig.POOL_ID;

const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "$PoolId",
                        "AppClientId": "$AppClientId",
                        "AppClientSecret": "$AppClientSecret",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                }
            }
        }
    },
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                 "dev-lambda": {
                     "endpointType": "REST",
                     "endpoint": "",
                     "region": "us-east-1",
                     "authorizationType": "AMAZON_COGNITO_USER_POOLS"
                    }   
            }
        }
    }
}''';