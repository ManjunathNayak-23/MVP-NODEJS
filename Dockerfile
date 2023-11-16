# Stage 1: Build the Angular app
FROM node:14.17.0 as build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the app source code
COPY . .

# Build the Angular app
RUN npm run build -- --configuration=production

# Stage 2: Create a lightweight server image
FROM node:14.17.0-alpine

WORKDIR /app

# Copy the built app from the previous stage
COPY --from=build /app/dist/mongo-dbangular13 .

# Expose the default HTTP port
EXPOSE 80

# Serve the Angular app using http-server
CMD ["npx", "http-server", "-p", "80", "-c-1", "."]
