FROM node:carbon as node

WORKDIR /app

COPY package*.json /app/

RUN npm install

COPY ./ /app/

ARG TARGET=ng-deploy-dev

RUN npm run ${TARGET}

FROM nginx:1.13

COPY --from=node ./dist /usr/share/nginx/html

COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
EXPOSE 80