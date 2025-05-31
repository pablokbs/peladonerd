FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# The default command will start the application
CMD ["npm", "start"]
