FROM node:12.22.1-alpine3.11

RUN apk add --no-cache python2 build-base

WORKDIR /app
COPY . .
RUN yarn install --production

CMD ["node", "/app/src/index.js"]
