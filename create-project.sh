#! /bin/bash

echo "Script rodando no diretório: $(pwd)"

echo "Deseja continuar?"
read continu

if [ $continu = "no" ]; then
	exit
fi

echo "Digite o nome do projeto: "
read name_project

echo "O nome do projeto será: $name_project"

echo -e "\nDeseja iniciar o git no projeto?"
read set_git

echo -e "\nDeseja usar HTTP/2.0 no projeto?"
read set_http

echo -e "\nDeseja usar docker?"
read set_docker

echo -e "\nDeseja usar banco de dados?"
read set_database

echo -e "\nDeseja usar cloud?"
read set_cloud

if [ $set_cloud = 'yes' ]; then
	echo -e "\nQual cloud? (firebase/aws)"
	read set_cloud_name
fi
		
echo -e "\n Prepare uma xicará de café enquanto será configurado o projeto : )"

mkdir $name_project && cd $name_project

yarn init -y

if [ $set_cloud = 'yes' ]; then
	if [ $set_cloud_name = 'aws' ]; then
		yarn add aws-sdk
		yarn add @types/aws-sdk -D
	elif [ $set_cloud_name = 'firebase' ]; then
		yarn add firebase-admin @types/firebase-admin -D
	fi
fi

wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.editorconfig
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.gitignore
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/LICENSE
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/README-P.md
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/environment.d.ts
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/tsconfig.json
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.czrc
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/jest.config.ts
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/babel.config.js
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.eslintrc.json

mv README-P.md README.md 

if [ $set_docker = 'yes' ]; then
	mkdir docker && cd docker
	
	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/docker/node-dev.dockerfile
	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/docker/node.dockerfile
	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/docker/nginx.dockerfile
	
	mkdir settings && cd settings

	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/docker/settings/nginx.conf
	
	cd ../..

	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/docker-compose.yaml
	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/docker-compose-dev.yaml
	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.dockerignore

fi

if [ $set_database = 'yes' ]; then

	yarn add sequelize pg mongoose ioredis
	yarn add @types/sequelize @types/pg @types/ioredis -D

fi

yarn add express typescript compression cors jest axios dotenv express-rate-limit eslint
yarn add @types/express @types/compression @types/cors @types/jest nodemon ts-node @typescript-eslint/eslint-plugin @typescript-eslint/parser -D

mkdir src && cd src

if [ $set_http = "yes" ]; then

	yarn add spdy
	yarn add @types/spdy -D

	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/src/index-http2.ts

	mv index-http2.ts index.ts

	cd ..

	openssl req -x509 -sha256 -nodes -days 1 -newkey rsa:2048 -keyout server.key -out server.crt

	cd src

elif [ $set_http = "no" ]; then

	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/src/index.ts

fi


mkdir controllers
mkdir routes
mkdir models
mkdir settings
mkdir services
mkdir interfaces
mkdir __tests__
mkdir middlewares

cd ..

touch '.env'
touch '.env.example'

if [ $set_git = 'yes' ]; then
	echo -e "Digite o nome do repositório para adicionar no git: \n"
	read url_project_github

	git init .
	git remote add origin https://github.com/ramonpaolo/$url_project_github	
fi

echo -e "\n Pode abrir o projeto e programar : )"