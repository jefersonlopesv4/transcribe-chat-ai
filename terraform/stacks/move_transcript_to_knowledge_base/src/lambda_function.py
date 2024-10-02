import boto3

import os

import json
from datetime import datetime

def get_transcript_from_s3(bucket_name, file_key):
    s3_client = boto3.client('s3')
    
    try:
        response = s3_client.get_object(Bucket=bucket_name, Key=file_key)
        file_content = response['Body'].read().decode('utf-8')
        json_content = json.loads(file_content)
        
        if 'results' in json_content and 'transcripts' in json_content['results']:
            transcripts = json_content['results']['transcripts']
            if transcripts and 'transcript' in transcripts[0]:
                return transcripts[0]['transcript']
            else:
                return None
        else:
            return None
    
    except Exception as e:
        print(f"Erro ao ler o arquivo do S3: {str(e)}")
        return None

def save_transcript_to_s3(bucket_name, transcript):
    s3_client = boto3.client('s3')
    
    try:
        # Gerar um nome de arquivo único baseado na data e hora atual
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        file_key = f"transcript_{timestamp}.txt"
        
        # Salvar o transcript no novo bucket
        s3_client.put_object(Bucket=bucket_name, Key=file_key, Body=transcript)
        
        print(f"Transcript salvo com sucesso em {bucket_name}/{file_key}")
        return file_key
    
    except Exception as e:
        print(f"Erro ao salvar o transcript no S3: {str(e)}")
        return None
        
def lambda_handler(event, context):

    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    try:
        
        transcript  = get_transcript_from_s3(bucket,key)
        if transcript:
            # Salvar o transcript no novo bucket
            saved_file_key = save_transcript_to_s3(os.environ['OUTPUT_BUCKET'], transcript)
            if saved_file_key:
                print(f"Processo concluído. Arquivo salvo: {saved_file_key}")
        else:
            print("Não foi possível extrair o transcript.")

        return {
            'statusCode': 200,
            'body': json.dumps('Transcription to knowledge base started successfully!')
        }
    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error starting Transcription to knowledge base  job: {str(e)}')
        }