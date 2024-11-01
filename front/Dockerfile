# Stage 1: Building React app
FROM node:20-alpine AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY frontend/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY frontend/ ./

# Let the browser resolve the Backend API URL
ENV REACT_APP_BACKEND_URL=${BACKEND_PATH:-/api}

# Build the React app
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Install gettext to use envsubst
RUN apk add --no-cache gettext

# Copy the build output from the react-build stage to the Nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx configuration
COPY nginx/nginx.conf.template /etc/nginx/nginx.conf.template
COPY nginx/nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh

EXPOSE 80

# Start Nginx server using entrypoint script
CMD ["sh", "/usr/local/bin/nginx-entrypoint.sh"]