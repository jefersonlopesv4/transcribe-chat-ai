
# Projeto de Transcrição de Vídeos e Chatbot IA com AWS, Flowise e Terraform

  

## 1. Introdução

  

### Visão Geral

Este projeto foca na transcrição de vídeos e criação de um chatbot IA utilizando serviços AWS, Flowise e Terraform.

  

### Objetivos

- Processar e transcrever vídeos automaticamente

- Gerar uma base de conhecimento a partir das transcrições

- Implementar um chatbot IA capaz de interagir com o conteúdo transcrito

  

### Tecnologias Utilizadas

-  **AWS S3**: Armazenamento de vídeos e transcrições

-  **AWS Lambda**: Processamento serverless de vídeos

-  **AWS Bedrock**: Serviço de IA para modelos de linguagem

-  **AWS Transcribe**: Reconhecimento de fala e transcrição

-  **AWS Bedrock Knowledge Base**: Indexação e vetorização de dados textuais

-  **Python**: Desenvolvimento de funções Lambda

-  **Flowise**: Criação de fluxos de trabalho de IA

-  **Terraform**: Gerenciamento de infraestrutura como código (IaC)

  

## 2. Arquitetura do Sistema

### Diagrama do projeto

![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/transcribe-chat-ia.drawio.png)

  

### Fluxo de dados

1. Upload de vídeos pelo usuário para o S3

2. Acionamento automático da função Lambda

3. Processamento do vídeo e envio para transcrição

4. Recebimento da transcrição do AWS Transcribe

5. Armazenamento da transcrição no S3

6. Envio da transcrição para vetorização no AWS Bedrock

7. Vetorização e armazenamento na AWS Bedrock Knowledge Base

8. Consulta do Flowise à base de conhecimento

9. Geração de respostas utilizando o AWS Bedrock

10. Interação do frontend com o Flowise

11. Uso do chatbot pelo usuário final

  

## 3. Configuração do Ambiente

##### Pré-requisitos

- Conta AWS

- AWS CLI instalado e configurado

- Terraform instalado

- Node.js e npm (para Flowise)

- Python 3.8+

  

##### Configuração Inicial

1. Clone o repositório:

```

git clone https://github.com/jefersonlopesv4/transcribe-chat-ia.git

cd transcribe-chat-ia

```

  

2. Configure as credenciais AWS:

```

aws configure

```

  

3. Instale as dependências do projeto front-end:

```

cd frontend

npm install

```

  

## 4. Infraestrutura como Código com Terraform

### Estrutura do Código Terraform

```

terraform/

├── sample/

├── terraform_state/

├── deploy.sh

└── destroy.sh

└── modules/

├── state/

├── main.tf

├── outputs.tf

└── variable.tf

├── stacks/

├── move_transcript_to_knowledge_base/

└── transcript_job_mp4/

```

  

### Implantação da Infraestrutura

1. Navegue até o diretório do Terraform state:

```

cd terraform/sample/terraform_state

```

  

2. Inicialize o Terraform:

```

terraform init

```

  

3. Revise o plano de execução:

```

terraform plan

```

  

4. Aplique as mudanças:

```

terraform apply

```

5. Navegue até o diretório sample:

```

cd ..

```

6. Rode o Shell Script para realizar o deploy:

```

sh deploy.sh

```

7. Após os testes, rode o Shell Script para destruir:

```

sh destroy.sh

```

### Configuração do AWS Bedrock

1. Acesse o console AWS Bedrock

![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/console-bedrock.png)

2. Navegue até Bedrock Configurations, Model Access e clique em Modify model access
![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/bedrock-configurations.png)
3. Faça o Request access dos modelos Titan Text Embeddings V2 e Claude 3 Haiku, preencha os dados que forem requeridos
![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/edit-model-access.png)
![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/request-model.png)
4. Realize o submit

### Configuração Base de Conhecimento Bedrock
1. Acesse o console AWS Bedrock

![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/console-bedrock.png)

2. Navegue até o Knowledge bases e clique em Create knowledge base![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/base-conhecimento.png)
3. Preencha os detalhes da base de conhecimento![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/base-conhecimento-detalhes.png)
4. Preencha os dados de Data Source, selecione o bucket da base de conhecimento
![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/base-conhecimento-data-source.png)
5. Selecione o Embedding model, no caso o Titan Text Embeddings v2 e depois em next
![Console Bedrock](https://sample-transcribe-chat-ia.s3.amazonaws.com/base-conhecimento-embedding.png)
5. Faça o submit e pronto, a base de conhecimento foi criada