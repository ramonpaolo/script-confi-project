#! /bin/bash

echo "script rodando no diretório: $(pwd)"

echo "deseja continuar?"
read continu


if [ $continu = "no" ]; then
	exit
fi


echo "Digite o nome do projeto: "
read name_project

echo "O nome do projeto será: $name_project"

echo -e "\n"

echo -e "\n Prepare uma xicará de café enquanto será configurado o projeto : )"

mkdir $name_project && cd $name_project

yarn init -y

yarn add express sequelize typescript pg mongoose compression jest axios dotenv ioredis
yarn add @types/express @types/sequelize @types/compression @types/jest @types/ioredis nodemon ts-node -D

mkdir docker && cd docker

mkdir settings

cd ..

mkdir src && cd src

mkdir controllers
mkdir routes
mkdir models
mkdir settings
mkdir services
mkdir interfaces
mkdir __tests__
mkdir middlewares

touch index.ts

echo -e "import express from 'express'\nimport compression from 'compression'\n\nconst app = express()\napp.use(compression())\n\nconst PORT = process.env.PORT || 3000\n\napp.listen(PORT)" > index.ts

cd ..

touch docker-compose.yaml
touch README.md
touch LICENSE
touch '.env'

wget https://raw.githubusercontent.com/git/git-scm.com/main/MIT-LICENSE.txt

cat MIT-LICENSE.txt > LICENSE

rm MIT-LICENSE.txt

yarn tsc --init

echo -e "Digite o caminho para adicionar no github: \n"
read url_project_github

git init .

git remote add origin $url_project_github

echo -e "/node_modules\n/dist\n.env" > .gitignore 
echo -e "declare global {\nnamespace NodeJS{\ninterface ProcessEnv{\nPORT: number;\n REDIS_HOST: string;\n REDIS_PORT: number; \n REDIS_PASSWORD: string;\n MONGODB_PASSWORD: string;\n MONGODB_USERNAME: string;}}}\nexport {}" > environment.d.ts

git add .

git commit -m "First commit"

git push -u origin master

echo -e "\n Pode abrir o projeto e programar : )"

code .
