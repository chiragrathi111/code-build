# AWS CodePipeline Deployment Steps for the Student Project

This file explains the AWS setup for deploying the project using AWS CodePipeline, CodeBuild, and CodeDeploy.

## 1. Commit the new files

Make sure these files are in your repository root:
- `buildspec.yml`
- `appspec.yml`
- `scripts/stop_server.sh`
- `scripts/backup_existing.sh`
- `scripts/start_server.sh`

Then commit and push your changes:

```bash
git add buildspec.yml appspec.yml scripts/*.sh AWS_DEPLOYMENT_STEPS.md
git commit -m "Add AWS CodePipeline deployment templates"
git push
```

## 2. Configure the EC2 target environment

This template assumes you will deploy to an EC2 instance with Linux.

### On the EC2 instance:
1. Install Java 11 and the CodeDeploy agent.
2. Attach an IAM role to the instance with at least these permissions:
   - `AmazonS3ReadOnlyAccess`
   - `AWSCodeDeployRole`
   - `CloudWatchLogsFullAccess` (optional for logs)
3. Tag the instance so CodeDeploy can identify it, for example:
   - `Key=Name`, `Value=student-app`

## 3. Create IAM roles

### CodeBuild role
Give CodeBuild permission to:
- download source from your repository
- run build phases
- upload build artifacts to S3
- push logs to CloudWatch

A managed policy like `AWSCodeBuildDeveloperAccess` is a good starting point.

### CodeDeploy role
Give CodeDeploy permission to:
- deploy artifacts to EC2
- read from S3
- access CodeDeploy resources

Use the AWS managed policy `AWSCodeDeployRole` or `AWSCodeDeployFullAccess`.

## 4. Create the CodeBuild project

In the AWS Console:
1. Open **AWS CodeBuild**.
2. Create a new project.
3. For source, choose your repository provider (GitHub, CodeCommit, etc.).
4. For environment, choose a managed image and Java 11.
5. Use the existing `buildspec.yml` from the repository.
6. Set artifact type to **S3**, or leave default if using CodePipeline.

The buildspec will:
- run `mvn test`
- build `target/student-1.0-SNAPSHOT.jar`
- publish the artifact and `appspec.yml`

## 5. Create the CodeDeploy application and deployment group

In the AWS Console:
1. Open **AWS CodeDeploy**.
2. Create a new application.
   - Compute platform: `EC2/On-premises`
3. Create a deployment group.
   - Choose the EC2 instances by tag or auto scaling group.
   - Attach the CodeDeploy service role.
   - Configure deployment settings, such as deployment configuration and rollback.

## 6. Create the CodePipeline pipeline

In the AWS Console:
1. Open **AWS CodePipeline**.
2. Create a new pipeline.
3. Add a source stage using your Git repository.
4. Add a build stage using the CodeBuild project.
5. Add a deploy stage using the CodeDeploy application and deployment group.

## 7. How it works

- `buildspec.yml` tells CodeBuild how to build the project.
- The artifact includes `target/student-1.0-SNAPSHOT.jar`, `appspec.yml`, and `scripts/`.
- CodeDeploy reads `appspec.yml` and runs the hook scripts on the EC2 instance.

## 8. Verify deployment

After pipeline execution:
- check CodePipeline for pipeline status
- inspect CodeBuild logs if the build fails
- inspect CodeDeploy logs if deployment fails
- on the EC2 host, check `/home/ec2-user/student/student.log`

## 9. Notes and customization

- If your EC2 instance user is not `ec2-user`, update `appspec.yml` and the scripts.
- If you want to deploy to a different path, update the `destination` in `appspec.yml`.
- If you use a different Java version, update `buildspec.yml` accordingly.

## 10. Make scripts executable

Before pushing, ensure the scripts are executable:

```bash
chmod +x scripts/*.sh
```