# puc_devops_co_practice01_docker

## Descrição
Este projeto visa containerizar o projeto **GuessGame** e todas as suas dependências, criando uma imagem para o **Frontend** da aplicação, um para o **Backend** e utilizando-se de uma imagem oficial para o banco de dados PostgreSQL.

## Estrutura
A estrutura básica do repositório consiste em:

    .
    ├── back
    │   ├── backend                   # The backend application files
    │   └── Dockerfile                (backend Dockerfile)
    ├── front
    │   ├── Dockerfile                (frontend/nginx Dockerfile)
    │   ├── frontend                  # The frontend application files
    │   └── nginx
    │       ├── nginx-entrypoint.sh   # Generates the nginx.conf and start nginx
    │       └── nginx.conf.template   # Template to generate the nginx.conf
    ├── docker-compose.yml
    └── README.md

### Práticas e Opções de Design Adotadas
- Serviços:
  - **Frontend**: Nginx que serve os arquivos estáticos da aplicação React, atua como proxy reverso e load balancer para as requisições ao backend.
  - **Backend**: Aplicação web construída em Python com framework Flask. Configurado no docker-compose para ter mais de uma réplica.
  - **Database**: Database PostgreSQL que armazena as informação relacionado as palavras e senhas.
- Network:
  - Foi criada duas networks. Uma network visa isolar o banco de dados para ser acessado somente pelos serviços do backend. A outra network engloba o frontend e o backend.
- Volumes:
  - Um volume isolado separado para o banco de dados para garantir a persitência dos dados mesmo se o container do banco fosse removido.
- Balanceamento de Carga: Servidor NGINX cuida do balanceamento de carga das requisições para o serviço de API do backend. Conta com a resolução de DNS automático do Docker (por estarem na mesma rede) para não ter que ser mapeado o endereço de cada réplica do backend, portanto, basta ser referenciado o serviço de backend definido no docker-compose nos arquivos de configuração (nginx.conf). Obs.: Para este projeto checar variáveis de ambiente mapeadas.

## Instruções de Instalação, Atualização e Execução

### Requisitos
Os seguintes recursos precisam estar instalados:
- Git
- Docker
- Docker-Compose

### Instruções
- Clonar repositório:

```bash
https://github.com/matheuspsouza/puc_devops_co_practice01_docker.git
```
- Configurar variáveis de ambiente:
  - Todas as variáveios de ambiente ficaram definidas e facilmente configuráveis no arquivo **.env** (pode se seguir o template no arquivo **.env.template**). Especial detalhamento para as seguintes variáveis:
    - **FRONTEND_VERSION** -> define a versão da imagem gerada na etapa de build (próximo passo). Deve ser alterado caso se deseje gerar uma nova imagem;
    - **BACKEND_VERSION** -> define a versão da imagem gerada na etapa de build (próximo passo). Deve ser alterado caso se deseje gerar uma nova imagem;
    - **BACKEND_REPLICAS** -> Define o número de réplicas do serviço de backend;
    - **BACKEND_HOST**, **BACKEND_PORT** -> Variáveis a serem utilizadas para gerar o nginx.conf do servidor NGIX, apontando para o serviço de backend (evitando o uso de referências hard-coded). Deve ser preenchido com o nome do serviço definido no arquivo docker-compose.yml (nesse exemplo **backend**);
    - **BACKEND_PATH** -> URL mapeada para enviar as requisições para o(s) serviço(s) de backend. Outros APIs podem ter URLs mapeadas de maneira semelhante, tornando a definição de forma flexível.

- Build das imagens:
  - Obs.: O arquivo nginx.conf é gerado dinamicamente, de acordo com as variáveis de ambiente, durante a fase de criação da imagem do servido de **frontend**.

```bash
docker compose build
```

- Execução dos containers:

```bash
docker compose up -d  # -d -> para executar em segundo plano
```

- Para atualizar basta executar os steps de build e excecução novamente, ou basta executar os dois em conjunto:

```bash
docker compose up --build
```

- Para parar os serviços:

```bash
docker compose stop
```

- Para parar e remover os containers:

```bash
docker compose down
```

- Para parar e remover os containers e volumes:

```bash
docker compose down -v
```

