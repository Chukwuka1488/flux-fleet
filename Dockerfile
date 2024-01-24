# Stage 1: Build the Next.js application
FROM node:latest as builder

WORKDIR /app

# Copy package.json and package-lock.json/yarn.lock files
COPY package*.json ./
COPY yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of your app's source code
COPY . .

# Build your Next.js application
RUN yarn build

# Stage 2: Setup the Nginx server
FROM nginx:alpine

# Copy the build output from the builder stage
COPY --from=builder /app/.next/static /usr/share/nginx/html/_next/static
COPY --from=builder /app/public /usr/share/nginx/html

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]