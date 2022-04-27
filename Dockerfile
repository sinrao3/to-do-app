FROM node:8.16.1-alpine
WORKDIR /app
COPY . /app
RUN NPM INSTALL
EXPOSE 3000
CMD node index.js

#ENTRYPOINT ["node", "index.js]
#COPY package.json /app