FROM node:23-alpine

RUN apk add --no-cache openssl

WORKDIR /app

COPY --link package.json /app/

RUN npm install

COPY --link . /app

EXPOSE 3000

CMD ["npm", "start"] 




