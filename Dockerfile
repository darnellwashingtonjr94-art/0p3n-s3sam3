# Step 1: Base image
FROM node:20-alpine AS base
WORKDIR /app

# Step 2: Build arguments & environment variables
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
ENV PORT=8080

# Step 3: Copy dependencies definition and install
COPY package*.json ./
RUN npm install --omit=dev

# Step 4: Copy source code
COPY . .

# Step 5: Security - Run as non-root user
USER node

# Step 6: Expose application port
EXPOSE 8080

# Step 7: Container healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

# Step 8: Default startup command
CMD ["node", "index.js"]
