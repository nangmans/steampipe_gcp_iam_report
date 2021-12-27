# GCP IAM Report

An GCP IAM best-practice compliances tool.

## Quick start

1) Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```shell
brew tap turbot/tap
brew install steampipe

steampipe -v
steampipe version 0.8.2
```

Install the GCP plugin
```shell
steampipe plugin install gcp
```

Clone this repo and move into the directory:
```sh
git clone https://github.com/nangmans/steampipe_gcp_iam_report.git
cd steampipe_gcp_iam_report
```

Run all benchmarks:
```shell
steampipe check all
```

![image](https://raw.githubusercontent.com/nangmans/steampipe_gcp_iam_report/main/docs/gcp_iam_report_console_graphic.png)

## Current GCP IAM Report Checks

- Do not grant basic roles unless there is no alternative.
- The best way to mitigate these threats is to avoid user-managed service account keys
- Ensure user-managed/external keys for service accounts are rotated every 90 days or less
- Use logs from Cloud Audit Logs to regularly audit changes to your IAM policy
- Manage access to logs using Logging roles.
- Grant roles to a Google group instead of individual users when possible
- Avoid using groups for granting service accounts access to resources

**Use introspection to view the available controls:**:
```
steampipe query "select resource_name from steampipe_control;"
```

**Prerequisites**:
- [Steampipe installed](https://steampipe.io/downloads)
- Steampipe GCP plugin installed (see above)

**Fork**:
Click on the GitHub Fork Widget. (Don't forget to :star: the repo!)

**Clone**:

1. Change the current working directory to the location where you want to put the cloned directory on your local filesystem.
2. Type the clone command below inserting your GitHub username instead of `YOUR-USERNAME`:

```sh
git clone git@github.com:YOUR-USERNAME/steampipe_gcp_iam_report.git
cd ssteampipe_gcp_iam_report
```

