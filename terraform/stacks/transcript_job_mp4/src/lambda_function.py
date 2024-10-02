import boto3
import os
import json
import uuid



def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    transcribe_client = boto3.client('transcribe')
    
    # Get the object from the event
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    try:

        if key.find("processed/") == -1 or key.find("error/") == -1:
            print(f"The key is not in the processed or error folder : {key}")
        else:
            print(f"Key is in the processed or error folder: {key}")
            return {
                'statusCode': 200,
                'body': json.dumps('The processed folder!')
            }

        myuuid = uuid.uuid4()

        job_name = f"{str(myuuid)}-transcribe-{key.split('/')[-1].split('.')[0]}"
        
        output_bucket = os.environ['OUTPUT_BUCKET']
       
        job_uri = f"s3://{bucket}/{key}"

        response = transcribe_client.start_transcription_job(
            TranscriptionJobName= ""+ job_name,
            Media={'MediaFileUri': job_uri},
            MediaFormat='mp4',
            LanguageCode='pt-BR',
            OutputBucketName=output_bucket
        )
        
        return {
            'statusCode': 200,
            'body': json.dumps('Transcription job started successfully!')
        }
    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error starting transcription job: {str(e)}')
        }