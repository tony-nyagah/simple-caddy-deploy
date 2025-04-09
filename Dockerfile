FROM node:22-alpine

ADD package.json /tmp/package.json

RUN rm -rf dist

RUN corepack enable && corepack prepare pnpm@latest --activate

RUN cd /tmp && pnpm install -q

ADD ./ /src
RUN rm -rf /src/node_modules && cp -a /tmp/node_modules /src/

WORKDIR /src

RUN pnpm run build

CMD ["node", "dist/index.js"]
