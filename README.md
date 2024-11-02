# DevOpsTest

DevOpsTest is a sample Go application designed to demonstrate a CI/CD pipeline with Jenkins and Docker. The project builds, tests, and deploys a Docker containerized application to a Linux VPS.

## Project Structure

- **Jenkinsfile**: Defines the Jenkins CI/CD pipeline.
- **Dockerfile**: Sets up a multi-stage Docker build to compile and run the Go application.
- **go.mod & go.sum**: Manage the Go module and dependencies.

## Requirements

- **Docker**: To containerize the application.
- **Jenkins**: For continuous integration and deployment.
- **VPS**: A Linux server for deploying the Docker container.

## CI/CD Pipeline Overview

The Jenkins pipeline performs the following steps:

1. **Checkout**: Retrieves the latest code from the GitHub repository.
2. **Build**: Creates a Docker image for the application.
3. **Test**: Runs Go tests to ensure the application’s stability.
4. **Push to DockerHub**: (Optional) Pushes the Docker image to DockerHub.
5. **Deploy**: Connects to a VPS and deploys the updated Docker container.

## Deployment

After each successful build, Jenkins updates the application on the VPS by pulling the latest Docker image and restarting the container.

## Usage

To use or modify this pipeline:

1. Clone the repository.
2. Update `Jenkinsfile` with your DockerHub and VPS credentials.
3. Configure a Jenkins job to run the pipeline.

## License

This project is licensed under the MIT License.
