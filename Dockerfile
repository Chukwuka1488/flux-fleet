# Use an official Node.js runtime as a parent image
FROM node:alpine as builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./
COPY yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code to the working directory
COPY . .

# Build the Next.js app
RUN yarn build

# Expose the port that Next.js will run on
EXPOSE 3000

# Define the command to run your application
CMD ["yarn", "start"]