#you can tag with the following
FROM node:alpine as builder

WORKDIR '/app'

#copy just package.json file to WORKDIR
COPY package.json .
RUN npm install

#copy everything from host CWD to docker container WORKDIR
COPY . .

RUN npm run build

#our build folder in the container is 
# /app/build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html