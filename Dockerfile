FROM node:latest as node
WORKDIR /app
COPY . .

ARG HOST_IP

RUN npm install --force
RUN npm install -g @angular/cli
RUN sed -i "s/localhost:9966/${HOST_IP}:9966/g" src/environments/environment.ts

CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "80"]