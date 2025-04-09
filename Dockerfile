FROM node:22-alpine

WORKDIR /app

# Set pnpm store directory
ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="${PATH}:${PNPM_HOME}"

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install dependencies including serve
RUN corepack enable && \
    corepack prepare pnpm@latest --activate && \
    pnpm install && \
    pnpm add serve

# Copy source files
COPY . .

# Build the app
RUN pnpm run build

# Expose the port the app runs on
EXPOSE 4000

# Serve the static files from dist directory using local serve
CMD ["./node_modules/.bin/serve", "-s", "dist", "-l", "4000"]
