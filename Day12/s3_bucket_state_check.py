import json
import os
import boto3

client = boto3.client('sns')

def lambda_handler(event, context):
    sns_topic_arn = os.environ.get('SNS_TOPIC_ARN')

    # Check if 'Records' key exists in the event
    if 'Records' in event:
        for record in event['Records']:
            
            # Extract S3 bucket information from each record
            if 's3' in record and 'bucket' in record['s3']:
                s3_bucket = record['s3']['bucket']['name']
                event_name = record['eventName']

                if event_name == 'CreateBucket':
                    message = f'Bucket {s3_bucket} was created.'
                elif event_name == 'DeleteBucket':
                    message = f'Bucket {s3_bucket} was deleted.'
                else:
                    message = f'Unknown event {event_name} occurred for bucket {s3_bucket}.'

                # Publish message to SNS topic if topic ARN is provided
                if sns_topic_arn:
                    client.publish(
                        TopicArn=sns_topic_arn,
                        Message=message
                    )
                else:
                    print("SNS topic ARN not provided. Skipping SNS notification.")
    else:
        print("Records key not found in the event.")

