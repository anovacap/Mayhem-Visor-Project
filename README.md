# Mayhem-Visor-Project
---
## Description
Visor/Mayhem consulting project -
Complete the CICD pipeline by moving the Visor/Mayhem build
machine into the cloud and allow Concourse CI to send a command
to the build machine that triggers the build. The build commands
are in a powershell script.
## Use
* install Terraform  12 latest locally.
* terraform apply tf_plan | configures infrastructure on AWS
* Goto AWS Systems Manager on AWS console - Quick SetUp. Select Windows instance push setup - On Right side menu push Run Command -  Push orange "Run Command" and search for AWS-RunPowerShellScript.
## Files
---
File|Task
---|---
.gitignore | ignore these files 
mian.tf | start of the terraform run
outputs.tf | terraform output information
variables.tf | variable definitions for main.tf
versions.tf | declare terraform version
tf_plan | terraform apply plan
## Author
Damon Nyhan