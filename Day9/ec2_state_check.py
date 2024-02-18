import json
import os
import boto3
client = boto3.client('sns')
def lambda_handler(event, context):
    topic_arn = os.environ['SNS_TOPIC_ARN']
    # print(topic_arn)
    instance_id = event['detail']['instance-id']
    instance_state = event['detail']['state']

    # Send SNS notifications based on instance state
    if instance_state == 'running':
        message = f'EC2-{instance_id} is in running state.'
        client.publish(
            TopicArn=topic_arn,
            Message=message
            )
    elif instance_state == 'stopped':
        message = f'EC2-{instance_id} is stopped.'
        client.publish(
            TopicArn=topic_arn,
            Message=message
            )
    elif instance_state == 'shutting-down':
        message = f'EC2-{instance_id} is shutting down.'
        client.publish(
            TopicArn=topic_arn,
            Message=message
            )
    elif instance_state == 'terminated':
        message = f'EC2-{instance_id} is terminated.'
        client.publish(
            TopicArn=topic_arn,
            Message=message
            )
    elif instance_state == 'pending':
        message = f'EC2-{instance_id} is in pending state.'
        client.publish(
            TopicArn=topic_arn,
            Message=message
            )
    elif instance_state == 'stopping':
        message = f'EC2-{instance_id} is stopping'
        client.publish(
            TopicArn=topic_arn,
            Message=message
            )