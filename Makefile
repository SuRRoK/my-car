export red=`tput setaf 1`
export green=`tput setaf 2`
export yellow=`tput setaf 3`
export blue=`tput setaf 4`
export magenta=`tput setaf 5`
export cyan=`tput setaf 6`
export white=`tput setaf 7`
export reset=`tput sgr0`

APP_CONTAINER_NAME = php

about:
	@echo -e "${cyan}Привет!)${reset} Это мэйкфайл для удобной работы с командами ${cyan};)${reset}  \
     \n Выполняйте нужные действия с помощью ${yellow}make <имякоманды>${reset}, доступные команды: \
     \n ${green}init${reset} - Инициализирует бэкенд (для локальной разработки) \
     \n ${green}docker-start${reset} - Запуск контейнеров \
     \n ${green}docker-stop${reset} - Остановка контейнеров \
     \n ${green}docker-build${reset} - Пересборка контейнеров \
     \n ${green}lint${reset} - Проверка линтером и кодстайла \
     \n ${green}cs-fix${reset} - Правка кодстайла \
     \n ${green}composer-install${reset} - Установка зависимостей composer \
     \n ${green}composer-update${reset} - Обновление зависимостей composer \
     \n ${green}make-migration${reset} - Генерация миграции на основе различий\
     \n ${green}migrate${reset} - Применит миграции\
     \n ${green}frontend${reset} - Установит фронт пакеты и будет смотреть файлы\
     "

show_local_urls:
	@echo " "
	@echo  "Локальное приложение ${cyan}MyCar${reset}: http://localhost:54080"
	@echo  "Локальная ${cyan}Почта${reset}: http://localhost:54025"

bash:
	docker-compose run --rm $(APP_CONTAINER_NAME) sh

docker-start:
	docker-compose up -d
	@make -s show_local_urls

docker-stop:
	docker-compose down --remove-orphans

docker-build:
	docker-compose build

init: docker-stop docker-start composer-install permissions migrate assets-install show_local_urls

lint:
	docker-compose run --rm $(APP_CONTAINER_NAME) composer lint
	docker-compose run --rm $(APP_CONTAINER_NAME) composer php-cs-fixer fix -- --dry-run --diff

cs-fix:
	docker-compose run --rm $(APP_CONTAINER_NAME) composer php-cs-fixer fix

composer-install:
	docker-compose exec $(APP_CONTAINER_NAME) composer install

composer-update:
	docker-compose exec $(APP_CONTAINER_NAME) composer update

migrate:
	docker-compose exec $(APP_CONTAINER_NAME) bin/console doctrine:migrations:migrate -n

make-migration:
	@echo  "${yellow}Генерируем миграцию...${reset}"
	docker-compose exec $(APP_CONTAINER_NAME) bin/console doctrine:migrations:diff

fixtures:
	docker-compose run --rm $(APP_CONTAINER_NAME) bin/console doctrine:fixtures:load -n

shell.php-fpm:
	docker-compose exec $(APP_CONTAINER_NAME) sh

shell.nginx:
	docker-compose exec nginx sh

permissions:
	docker run --rm -v ${PWD}/:/srv/sylius -w /srv/sylius alpine chmod 777 var/cache var/log

frontend:
	yarn
	yarn watch

git-commit-back:
	 git reset --soft HEAD^
