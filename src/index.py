import boto3
import json
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    bucket = os.environ['BUCKET_NAME']
    # get the filename from the URL parameter, for example: ?file=test.zip
    # this means if you need to download A.pdf , then /?file=A.pdf
    query_params = event.get('queryStringParameters') or {}
    file_key = query_params.get('file')
    
    if not file_key:
        return {'statusCode': 400, 'body': 'Missing file parameter'}
    
    url = s3.generate_presigned_url(
        'get_object',
        Params={'Bucket': bucket, 'Key': file_key},
        ExpiresIn=3600 # means 1 hour
    )
    
    return {'statusCode': 200, 'body': json.dumps({'url': url})}