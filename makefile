start-front-example:
	cd front-example && npm i && npm run dev

start-back:
	cd back && make start-global

start-backoffice:
	cd backoffice && npm i && npm run dev

start-front: start-front-example start-backoffice


clone: clone-back clone-backoffice clone-front-example clone-sdk

clone-back:
	git clone https://github.com/FantinPro/nest-js-analytics back

clone-backoffice:
	git clone https://github.com/omaziarz/backoffice backoffice

clone-front-example:
	git clone https://github.com/FantinPro/analytics_esgi front-example

clone-sdk:
	git clone https://github.com/omaziarz/esgi-sdk-front front-sdk