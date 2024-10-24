# Use Node.js image for the Express server
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN npm install

# Expose port 3001
EXPOSE 3001

# Run the server
CMD ["node", "server.js"]



