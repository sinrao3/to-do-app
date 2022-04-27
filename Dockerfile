FROM node:8.16.1-alpine
WORKDIR /app
COPY package.json /app
RUN npm install
RUN npm install react-scripts@3.4.1
COPY . /app
EXPOSE 3000
CMD ["npm","run","start"]

