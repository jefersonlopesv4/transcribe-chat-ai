<h1 class="code-line" data-line-start=1 data-line-end=2 ><a id="Projeto_de_Transcrio_de_Vdeos_e_Chatbot_IA_com_AWS_Flowise_e_Terraform_1"></a>Projeto de Transcrição de Vídeos e Chatbot IA com AWS, Flowise e Terraform</h1>
<h2 class="code-line" data-line-start=5 data-line-end=6 ><a id="1_Introduo_5"></a>1. Introdução</h2>
<h3 class="code-line" data-line-start=9 data-line-end=10 ><a id="Viso_Geral_9"></a>Visão Geral</h3>
<p class="has-line-data" data-line-start="11" data-line-end="12">Este projeto foca na transcrição de vídeos e criação de um chatbot IA utilizando serviços AWS, Flowise e Terraform.</p>
<h3 class="code-line" data-line-start=15 data-line-end=16 ><a id="Objetivos_15"></a>Objetivos</h3>
<ul>
<li class="has-line-data" data-line-start="17" data-line-end="19">
<p class="has-line-data" data-line-start="17" data-line-end="18">Processar e transcrever vídeos automaticamente</p>
</li>
<li class="has-line-data" data-line-start="19" data-line-end="21">
<p class="has-line-data" data-line-start="19" data-line-end="20">Gerar uma base de conhecimento a partir das transcrições</p>
</li>
<li class="has-line-data" data-line-start="21" data-line-end="22">
<p class="has-line-data" data-line-start="21" data-line-end="22">Implementar um chatbot IA capaz de interagir com o conteúdo transcrito</p>
</li>
</ul>
<h3 class="code-line" data-line-start=25 data-line-end=26 ><a id="Tecnologias_Utilizadas_25"></a>Tecnologias Utilizadas</h3>
<ul>
<li class="has-line-data" data-line-start="27" data-line-end="29">
<p class="has-line-data" data-line-start="27" data-line-end="28"><strong>AWS S3</strong>: Armazenamento de vídeos e transcrições</p>
</li>
<li class="has-line-data" data-line-start="29" data-line-end="31">
<p class="has-line-data" data-line-start="29" data-line-end="30"><strong>AWS Lambda</strong>: Processamento serverless de vídeos</p>
</li>
<li class="has-line-data" data-line-start="31" data-line-end="33">
<p class="has-line-data" data-line-start="31" data-line-end="32"><strong>AWS Bedrock</strong>: Serviço de IA para modelos de linguagem</p>
</li>
<li class="has-line-data" data-line-start="33" data-line-end="35">
<p class="has-line-data" data-line-start="33" data-line-end="34"><strong>AWS Transcribe</strong>: Reconhecimento de fala e transcrição</p>
</li>
<li class="has-line-data" data-line-start="35" data-line-end="37">
<p class="has-line-data" data-line-start="35" data-line-end="36"><strong>AWS Bedrock Knowledge Base</strong>: Indexação e vetorização de dados textuais</p>
</li>
<li class="has-line-data" data-line-start="37" data-line-end="39">
<p class="has-line-data" data-line-start="37" data-line-end="38"><strong>Python</strong>: Desenvolvimento de funções Lambda</p>
</li>
<li class="has-line-data" data-line-start="39" data-line-end="41">
<p class="has-line-data" data-line-start="39" data-line-end="40"><strong>Flowise</strong>: Criação de fluxos de trabalho de IA</p>
</li>
<li class="has-line-data" data-line-start="41" data-line-end="42">
<p class="has-line-data" data-line-start="41" data-line-end="42"><strong>Terraform</strong>: Gerenciamento de infraestrutura como código (IaC)</p>
</li>
</ul>
<h2 class="code-line" data-line-start=45 data-line-end=46 ><a id="2_Arquitetura_do_Sistema_45"></a>2. Arquitetura do Sistema</h2>
<h3 class="code-line" data-line-start=47 data-line-end=48 ><a id="Diagrama_do_projeto_47"></a>Diagrama do projeto</h3>
<p class="has-line-data" data-line-start="49" data-line-end="50"><img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/transcribe-chat-ia.drawio.png" alt="Console Bedrock"></p>
<h3 class="code-line" data-line-start=53 data-line-end=54 ><a id="Fluxo_de_dados_53"></a>Fluxo de dados</h3>
<ol>
<li class="has-line-data" data-line-start="55" data-line-end="57">
<p class="has-line-data" data-line-start="55" data-line-end="56">Upload de vídeos pelo usuário para o S3</p>
</li>
<li class="has-line-data" data-line-start="57" data-line-end="59">
<p class="has-line-data" data-line-start="57" data-line-end="58">Acionamento automático da função Lambda</p>
</li>
<li class="has-line-data" data-line-start="59" data-line-end="61">
<p class="has-line-data" data-line-start="59" data-line-end="60">Processamento do vídeo e envio para transcrição</p>
</li>
<li class="has-line-data" data-line-start="61" data-line-end="63">
<p class="has-line-data" data-line-start="61" data-line-end="62">Recebimento da transcrição do AWS Transcribe</p>
</li>
<li class="has-line-data" data-line-start="63" data-line-end="65">
<p class="has-line-data" data-line-start="63" data-line-end="64">Armazenamento da transcrição no S3</p>
</li>
<li class="has-line-data" data-line-start="65" data-line-end="67">
<p class="has-line-data" data-line-start="65" data-line-end="66">Envio da transcrição para vetorização no AWS Bedrock</p>
</li>
<li class="has-line-data" data-line-start="67" data-line-end="69">
<p class="has-line-data" data-line-start="67" data-line-end="68">Vetorização e armazenamento na AWS Bedrock Knowledge Base</p>
</li>
<li class="has-line-data" data-line-start="69" data-line-end="71">
<p class="has-line-data" data-line-start="69" data-line-end="70">Consulta do Flowise à base de conhecimento</p>
</li>
<li class="has-line-data" data-line-start="71" data-line-end="73">
<p class="has-line-data" data-line-start="71" data-line-end="72">Geração de respostas utilizando o AWS Bedrock</p>
</li>
<li class="has-line-data" data-line-start="73" data-line-end="75">
<p class="has-line-data" data-line-start="73" data-line-end="74">Interação do frontend com o Flowise</p>
</li>
<li class="has-line-data" data-line-start="75" data-line-end="76">
<p class="has-line-data" data-line-start="75" data-line-end="76">Uso do chatbot pelo usuário final</p>
</li>
</ol>
<h2 class="code-line" data-line-start=79 data-line-end=80 ><a id="3_Configurao_do_Ambiente_79"></a>3. Configuração do Ambiente</h2>
<h5 class="code-line" data-line-start=81 data-line-end=82 ><a id="Prrequisitos_81"></a>Pré-requisitos</h5>
<ul>
<li class="has-line-data" data-line-start="83" data-line-end="85">
<p class="has-line-data" data-line-start="83" data-line-end="84">Conta AWS</p>
</li>
<li class="has-line-data" data-line-start="85" data-line-end="87">
<p class="has-line-data" data-line-start="85" data-line-end="86">AWS CLI instalado e configurado</p>
</li>
<li class="has-line-data" data-line-start="87" data-line-end="89">
<p class="has-line-data" data-line-start="87" data-line-end="88">Terraform instalado</p>
</li>
<li class="has-line-data" data-line-start="89" data-line-end="91">
<p class="has-line-data" data-line-start="89" data-line-end="90">Node.js e npm (para Flowise)</p>
</li>
<li class="has-line-data" data-line-start="91" data-line-end="92">
<p class="has-line-data" data-line-start="91" data-line-end="92">Python 3.8+</p>
</li>
</ul>
<h5 class="code-line" data-line-start=95 data-line-end=96 ><a id="Configurao_Inicial_95"></a>Configuração Inicial</h5>
<ol>
<li class="has-line-data" data-line-start="97" data-line-end="99">Clone o repositório:</li>
</ol>
<pre><code class="has-line-data" data-line-start="100" data-line-end="106">
git clone https://github.com/jefersonlopesv4/transcribe-chat-ia.git

cd transcribe-chat-ia

</code></pre>
<ol start="2">
<li class="has-line-data" data-line-start="109" data-line-end="111">Configure as credenciais AWS:</li>
</ol>
<pre><code class="has-line-data" data-line-start="112" data-line-end="116">
aws configure

</code></pre>
<ol start="3">
<li class="has-line-data" data-line-start="119" data-line-end="121">Instale as dependências do projeto front-end:</li>
</ol>
<pre><code class="has-line-data" data-line-start="122" data-line-end="128">
cd frontend

npm install

</code></pre>
<h2 class="code-line" data-line-start=131 data-line-end=132 ><a id="4_Infraestrutura_como_Cdigo_com_Terraform_131"></a>4. Infraestrutura como Código com Terraform</h2>
<h3 class="code-line" data-line-start=133 data-line-end=134 ><a id="Estrutura_do_Cdigo_Terraform_133"></a>Estrutura do Código Terraform</h3>
<pre><code class="has-line-data" data-line-start="136" data-line-end="164">
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

</code></pre>
<h3 class="code-line" data-line-start=167 data-line-end=168 ><a id="Implantao_da_Infraestrutura_167"></a>Implantação da Infraestrutura</h3>
<ol>
<li class="has-line-data" data-line-start="169" data-line-end="171">Navegue até o diretório do Terraform state:</li>
</ol>
<pre><code class="has-line-data" data-line-start="172" data-line-end="176">
cd terraform/sample/terraform_state

</code></pre>
<ol start="2">
<li class="has-line-data" data-line-start="179" data-line-end="181">Inicialize o Terraform:</li>
</ol>
<pre><code class="has-line-data" data-line-start="182" data-line-end="186">
terraform init

</code></pre>
<ol start="3">
<li class="has-line-data" data-line-start="189" data-line-end="191">Revise o plano de execução:</li>
</ol>
<pre><code class="has-line-data" data-line-start="192" data-line-end="196">
terraform plan

</code></pre>
<ol start="4">
<li class="has-line-data" data-line-start="199" data-line-end="201">Aplique as mudanças:</li>
</ol>
<pre><code class="has-line-data" data-line-start="202" data-line-end="206">
terraform apply

</code></pre>
<ol start="5">
<li class="has-line-data" data-line-start="207" data-line-end="209">Navegue até o diretório sample:</li>
</ol>
<pre><code class="has-line-data" data-line-start="210" data-line-end="214">
cd ..

</code></pre>
<ol start="6">
<li class="has-line-data" data-line-start="215" data-line-end="217">Rode o Shell Script para realizar o deploy:</li>
</ol>
<pre><code class="has-line-data" data-line-start="218" data-line-end="222">
sh deploy.sh

</code></pre>
<ol start="7">
<li class="has-line-data" data-line-start="223" data-line-end="225">Após os testes, rode o Shell Script para destruir:</li>
</ol>
<pre><code class="has-line-data" data-line-start="226" data-line-end="230">
sh destroy.sh

</code></pre>
<h3 class="code-line" data-line-start=231 data-line-end=232 ><a id="Configurao_do_AWS_Bedrock_231"></a>Configuração do AWS Bedrock</h3>
<ol>
<li class="has-line-data" data-line-start="233" data-line-end="236">
<p class="has-line-data" data-line-start="233" data-line-end="235">Acesse o console AWS Bedrock<br>
<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/console-bedrock.png" alt="Console Bedrock"></p>
</li>
<li class="has-line-data" data-line-start="236" data-line-end="238">
<p class="has-line-data" data-line-start="236" data-line-end="238">Navegue até Bedrock Configurations, Model Access e clique em Modify model access<br>
<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/bedrock-configurations.png" alt="Console Bedrock"></p>
</li>
<li class="has-line-data" data-line-start="238" data-line-end="241">
<p class="has-line-data" data-line-start="238" data-line-end="241">Faça o Request access dos modelos Titan Text Embeddings V2 e Claude 3 Haiku, preencha os dados que forem requeridos<br>
<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/edit-model-access.png" alt="Console Bedrock"><br>
<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/request-model.png" alt="Console Bedrock"></p>
</li>
<li class="has-line-data" data-line-start="241" data-line-end="243">
<p class="has-line-data" data-line-start="241" data-line-end="242">Realize o submit</p>
</li>
</ol>
<h3 class="code-line" data-line-start=243 data-line-end=244 ><a id="Configurao_Base_de_Conhecimento_Bedrock_243"></a>Configuração Base de Conhecimento Bedrock</h3>
<ol>
<li class="has-line-data" data-line-start="244" data-line-end="246">Acesse o console AWS Bedrock<br>
<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/console-bedrock.png" alt="Console Bedrock"></li>
<li class="has-line-data" data-line-start="246" data-line-end="247">Navegue até o Knowledge bases e clique em Create knowledge base<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/base-conhecimento.png" alt="Console Bedrock"></li>
<li class="has-line-data" data-line-start="247" data-line-end="248">Preencha os detalhes da base de conhecimento<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/base-conhecimento-detalhes.png" alt="Console Bedrock"></li>
<li class="has-line-data" data-line-start="248" data-line-end="250">Preencha os dados de Data Source, selecione o bucket da base de conhecimento<br>
<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/base-conhecimento-data-source.png" alt="Console Bedrock"></li>
<li class="has-line-data" data-line-start="250" data-line-end="252">Selecione o Embedding model, no caso o Titan Text Embeddings v2 e depois em next<br>
<img src="https://sample-transcribe-chat-ia.s3.amazonaws.com/base-conhecimento-embedding.png" alt="Console Bedrock"></li>
<li class="has-line-data" data-line-start="252" data-line-end="253">Faça o submit e pronto, a base de conhecimento foi criada</li>
</ol>
