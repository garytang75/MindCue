import './env_config.dart';
const AppClientId = EnvConfig.APP_CLIENT_ID;
const AppClientSecret = EnvConfig.APP_CLIENT_SECRET;
const PoolId = EnvConfig.POOL_ID;
const Endpoint = EnvConfig.ENDPOINT;

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
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:b7c5572f-2c4f-42b4-84ac-cd3b84da4f8b",
                            "Region": "us-east-1"
                        }
                    }
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
                 "mc-api": {
                     "endpointType": "REST",
                     "endpoint": "$Endpoint",
                     "region": "us-east-1",
                     "authorizationType": "AMAZON_COGNITO_USER_POOLS"
                    }    
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "dev-mc-dev-lambda-storage",
                "region": "us-east-1"
        }
    }
  }
}''';