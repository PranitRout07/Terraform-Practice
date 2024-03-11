import json
import os
import boto3

client = boto3.client('sns')

def lambda_handler(event, context):
    sns_topic_arn = os.environ.get('SNS_TOPIC_ARN')

    record = event['Records'][0]
    event_name = record['eventName']
    bucket = record['s3']['bucket']['name']
    key = record['s3']['object']['key']
    

    message = f"Event '{event_name}' occurred for object '{key}' in bucket '{bucket}'"
    
    response = client.publish(
        TopicArn=sns_topic_arn,
        Message=message
    )




