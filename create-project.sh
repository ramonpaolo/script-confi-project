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

echo -e "\nDeseja usar docker?"
read set_docker

echo -e "\nDeseja usar banco de dados?"
read set_database

echo -e "\nDeseja usar cloud?"
read set_cloud

if [ $set_cloud = 'yes' ]; then
	echo -e "\nQual cloud? (firebase/aws)"
	read set_cloud_name
	if [ $set_cloud_name = 'aws' ]; then
		yarn add aws-sdk
		yarn add @types/aws-sdk -D
	elif [ $set_cloud_name = 'firebase' ]; then
		yarn add firebase-admin @types/firebase-admin -D
	fi
fi
		
echo -e "\n Prepare uma xicará de café enquanto será configurado o projeto : )"

mkdir $name_project && cd $name_project

yarn init -y

wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.editorconfig
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.gitignore
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/LICENSE
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/README-P.md
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/environment.d.ts
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/tsconfig.json
wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.czrc

mv README-P.md README.md 

if [ $set_docker = 'yes' ]; then
	mkdir docker && cd docker
	mkdir settings
	cd ..
	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/docker-compose.yaml
	wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/.dockerignore
	#touch docker-compose.yaml
	#echo -e "/node_modules\n/dist\n.env" > .dockerignore 
	#echo 'version: "3.8"' > docker-compose.yaml
fi

if [ $set_database = 'yes' ]; then
	yarn add sequelize pg mongoose ioredis
	yarn add @types/sequelize @types/pg @types/ioredis -D
	echo -e "declare global {\nnamespace NodeJS{\ninterface ProcessEnv{\nPORT: number;\n REDIS_HOST: string;\n REDIS_PORT: number; \n REDIS_PASSWORD: string;\n MONGODB_PASSWORD: string;\n MONGODB_USERNAME: string;}}}\nexport {}" > environment.d.ts
elif [ $set_database = 'no' ]; then
	echo -e "declare global {\nnamespace NodeJS{\ninterface ProcessEnv{\nPORT: number;\n}}}\nexport {}" > environment.d.ts	
fi

yarn add express typescript compression cors jest axios dotenv
yarn add @types/express @types/compression @types/jest nodemon ts-node -D

mkdir src && cd src

wget https://raw.githubusercontent.com/ramonpaolo/default-files-script-automation/master/src/index.ts

mkdir controllers
mkdir routes
mkdir models
mkdir settings
mkdir services
mkdir interfaces
mkdir __tests__
mkdir middlewares

#touch index.ts

#echo -e "import express from 'express'\nimport compression from 'compression'\n\nconst app = express()\napp.use(compression())\n\nconst PORT = process.env.PORT || 3000\n\napp.listen(PORT)" > index.ts

cd ..

#touch README.md
#touch LICENSE
touch '.env'

#wget https://raw.githubusercontent.com/git/git-scm.com/main/MIT-LICENSE.txt

#cat MIT-LICENSE.txt > LICENSE

#rm MIT-LICENSE.txt

#yarn tsc --init

#echo -e '{\n "path": "cz-conventional-changelog"\n}' > .czrc

#echo -e "/node_modules\n/dist\n.env" > .gitignore 

if [ $set_git = 'yes' ]; then
	echo -e "Digite o caminho para adicionar no github: \n"
	read url_project_github

	git init .
	git remote add origin $url_project_github	

	# git add .

	# git commit -m "First commit"

	# git push -u origin master
fi

#echo "---Lembre-se de mudar o arquivo LICENSE---"

echo -e "\n Pode abrir o projeto e programar : )"
