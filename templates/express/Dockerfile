FROM node:16-alpine as build

WORKDIR /build

COPY . .

RUN npm install && npm run build && npm prune --production

FROM node:16-alpine

RUN adduser --disabled-password service

USER service

WORKDIR /home/service

COPY --from=build /build/dist .
COPY --from=build /build/node_modules node_modules

CMD ["node", "./index.js"]
