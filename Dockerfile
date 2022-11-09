FROM node:alpine as installer
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


FROM node:alpine
WORKDIR /app
COPY --from=installer /app/.next ./.next
COPY --from=installer /app/package.json .
RUN npm install --omit=dev
EXPOSE 3000
CMD [ "npm", "start" ]

