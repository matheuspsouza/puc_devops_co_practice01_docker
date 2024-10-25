# puc_devops_co_practice01_docker

## Descrição
Este projeto visa containerizar o projeto **GuessGame** e todas as suas dependências, criando uma imagem para o **Frontend** da aplicação, um para o **Backend** e um utilizando-se de uma imagem oficial para o database PostgreSQL.

## Estrutura
A estrutura básica do repositório consiste em:

    .
    ├── back
    │   ├── backend         # The backend application files
    │   └── Dockerfile      (backend Dockerfile)
    ├── front
    │   ├── Dockerfile      (frontend/nginx Dockerfile)
    │   ├── frontend        # The frontend application files
    │   └── nginx
    │       └── nginx.conf
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

- Build das imagens:

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

