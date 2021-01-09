FROM node:alpine 
# as builder (this doesn't work on AWS)
WORKDIR '/app'
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
# this is not read in dev but Elastic Beanstalk knows that this is the port that it needs to be mapped
EXPOSE 80 
COPY --from=0 /app/build /usr/share/nginx/html