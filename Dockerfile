# Use node Docker image, version 16-alpine
FROM quay.io/upslopeio/node-alpine

# From the documentation, "The WORKDIR instruction sets the working directory for any
# RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile"
WORKDIR /usr/src/app

# COPY package.json and package-lock.json into root of WORKDIR
COPY package*.json ./

# Clean install to install all dependencies
RUN npm ci

# Copies files from source to destination, in this case the root of the build context
# into the root of the WORKDIR
COPY . .

# Document that this container exposes something on port 3000
EXPOSE 3000

# Build production build for npm start
RUN npm run build

# Command to use for starting the application
CMD ["npm", "start"]
