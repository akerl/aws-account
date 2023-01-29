resource "aws_iam_role" "vantage_cross_account_connection" {
  name = "vantage_cross_account_connection"

  assume_role_policy = data.aws_iam_policy_document.vantage_assume_role.json

  inline_policy {
    name   = "VantageCostandUsageReportRetrieval"
    policy = data.aws_iam_policy_document.vantage_cur_retrieval.json
  }


  inline_policy {
    name = "root"

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "budgets:Describe*",
        "budgets:View*",
        "ce:Get*",
        "ce:Describe*",
        "ce:List*",
        "cur:Describe*",
        "pricing:*",
        "organizations:Describe*",
        "organizations:List*",
        "savingsplans:Describe*"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VantageBillingReadOnly"
    }
  ]
}
      EOF
  }


  inline_policy {
    name = "VantageCloudWatchMetricsReadOnly"

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:List*",
        "logs:Describe*",
        "logs:StartQuery",
        "logs:StopQuery",
        "logs:Filter*",
        "logs:Get*"
      ],
      "Resource": "arn:aws:logs:*:*:log-group:/aws/containerinsights/*",
      "Effect": "Allow",
      "Sid": "VantageContainerInsightsReadOnly"
    },
    {
      "Action": [
        "logs:GetQueryResults",
        "logs:DescribeLogGroups"
      ],
      "Resource": "arn:aws:logs:*:*:log-group::log-stream:*",
      "Effect": "Allow",
      "Sid": "VantageContainerInsightsLogStream"
    },
    {
      "Action": [
        "autoscaling:Describe*",
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VantageContainerMetricsAccess"
    }
  ]
}
      EOF
  }


  inline_policy {
    name = "VantageAdditionalResourceReadOnly"

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": "*",
      "Action": [
        "a4b:List*",
        "a4b:Search*",
        "acm:Describe*",
        "acm:List*",
        "acm-pca:Describe*",
        "acm-pca:List*",
        "amplify:ListApps",
        "amplify:ListBranches",
        "amplify:ListDomainAssociations",
        "amplify:ListJobs",
        "application-autoscaling:Describe*",
        "applicationinsights:Describe*",
        "applicationinsights:List*",
        "appmesh:Describe*",
        "appmesh:List*",
        "appstream:Describe*",
        "appstream:List*",
        "appsync:List*",
        "autoscaling-plans:Describe*",
        "athena:Batch*",
        "backup:Describe*",
        "backup:List*",
        "batch:List*",
        "batch:Describe*",
        "budgets:Describe*",
        "budgets:View*",
        "ce:Get*",
        "chatbot:Describe*",
        "chime:List*",
        "chime:Retrieve*",
        "chime:Search*",
        "chime:Validate*",
        "cloud9:Describe*",
        "cloud9:List*",
        "clouddirectory:List*",
        "cloudformation:Describe*",
        "cloudhsm:List*",
        "cloudhsm:Describe*",
        "cloudsearch:Describe*",
        "cloudtrail:Describe*",
        "cloudtrail:Get*",
        "cloudtrail:List*",
        "cloudwatch:Describe*",
        "codeartifact:DescribeDomain",
        "codeartifact:DescribePackageVersion",
        "codeartifact:DescribeRepository",
        "codeartifact:ListDomains",
        "codeartifact:ListPackages",
        "codeartifact:ListPackageVersionAssets",
        "codeartifact:ListPackageVersionDependencies",
        "codeartifact:ListPackageVersions",
        "codeartifact:ListRepositories",
        "codeartifact:ListRepositoriesInDomain",
        "codebuild:DescribeCodeCoverages",
        "codebuild:DescribeTestCases",
        "codebuild:Get*",
        "codebuild:List*",
        "codebuild:BatchGetBuilds",
        "codebuild:BatchGetProjects",
        "codecommit:Describe*",
        "codeguru-profiler:Describe*",
        "codeguru-profiler:List*",
        "codeguru-reviewer:Describe*",
        "codeguru-reviewer:List*",
        "codepipeline:List*",
        "codepipeline:Get*",
        "codestar:Describe*",
        "connect:Describe*",
        "dataexchange:List*",
        "datasync:Describe*",
        "datasync:List*",
        "datapipeline:Describe*",
        "datapipeline:List*",
        "detective:List*",
        "discovery:Describe*",
        "dms:Describe*",
        "ds:Check*",
        "ds:Describe*",
        "ds:List*",
        "dynamodb:Describe*",
        "dynamodb:List*",
        "ec2:Describe*",
        "ec2:GetCapacityReservationUsage",
        "ec2:GetEbsEncryptionByDefault",
        "ec2:SearchTransitGatewayRoutes",
        "ecr:BatchCheck*",
        "ecr:BatchGet*",
        "ecr:Describe*",
        "ecr:List*",
        "eks:DescribeCluster",
        "eks:DescribeUpdate",
        "eks:Describe*",
        "eks:ListClusters",
        "eks:ListUpdates",
        "eks:List*",
        "elasticache:List*",
        "elasticbeanstalk:Check*",
        "elasticbeanstalk:Describe*",
        "elasticbeanstalk:List*",
        "elasticbeanstalk:Request*",
        "elasticbeanstalk:Retrieve*",
        "elasticbeanstalk:Validate*",
        "elasticfilesystem:Describe*",
        "elasticloadbalancing:Describe*",
        "elasticmapreduce:Describe*",
        "elasticmapreduce:View*",
        "elemental-appliances-software:List*",
        "es:Describe*",
        "es:List*",
        "events:Describe*",
        "events:List*",
        "events:Test*",
        "firehose:Describe*",
        "fsx:Describe*",
        "fsx:List*",
        "freertos:Describe*",
        "freertos:List*",
        "glacier:Describe*",
        "globalaccelerator:Describe*",
        "globalaccelerator:List*",
        "glue:ListCrawlers",
        "glue:ListDevEndpoints",
        "glue:ListJobs",
        "glue:ListMLTransforms",
        "glue:ListTriggers",
        "glue:ListWorkflows",
        "guardduty:List*",
        "health:Describe*",
        "iam:Get*",
        "imagebuilder:List*",
        "importexport:List*",
        "inspector:Describe*",
        "inspector:Preview*",
        "iot:Describe*",
        "iotanalytics:Describe*",
        "iotanalytics:List*",
        "iotsitewise:Describe*",
        "iotsitewise:List*",
        "kafka:Describe*",
        "kafka:List*",
        "kinesisanalytics:Describe*",
        "kinesisanalytics:Discover*",
        "kinesisanalytics:List*",
        "kinesisvideo:Describe*",
        "kinesisvideo:List*",
        "kinesis:Describe*",
        "kinesis:List*",
        "kms:Describe*",
        "kms:List*",
        "license-manager:List*",
        "logs:ListTagsLogGroup",
        "logs:TestMetricFilter",
        "mediaconvert:DescribeEndpoints",
        "mediaconvert:List*",
        "mediapackage:List*",
        "mediapackage:Describe*",
        "medialive:List*",
        "medialive:Describe*",
        "mediaconnect:List*",
        "mediaconnect:Describe*",
        "mediapackage-vod:List*",
        "mediapackage-vod:Describe*",
        "mediastore:List*",
        "mediastore:Describe*",
        "mediatailor:List*",
        "mediatailor:Describe*",
        "mgh:Describe*",
        "mgh:List*",
        "mobilehub:Describe*",
        "mobilehub:List*",
        "mobiletargeting:List*",
        "mq:Describe*",
        "mq:List*",
        "opsworks-cm:List*",
        "organizations:Describe*",
        "outposts:List*",
        "personalize:Describe*",
        "personalize:List*",
        "pi:DescribeDimensionKeys",
        "qldb:ListLedgers",
        "qldb:ListTagsForResource",
        "ram:List*",
        "rekognition:List*",
        "rds:List*",
        "redshift:Describe*",
        "redshift:View*",
        "resource-groups:Get*",
        "resource-groups:List*",
        "resource-groups:Search*",
        "robomaker:BatchDescribe*",
        "robomaker:Describe*",
        "robomaker:List*",
        "route53domains:Check*",
        "route53domains:Get*",
        "route53domains:View*",
        "s3:List*",
        "s3:GetBucketLocation",
        "s3:GetBucketTagging",
        "schemas:Describe*",
        "schemas:List*",
        "secretsmanager:List*",
        "secretsmanager:Describe*",
        "securityhub:Describe*",
        "securityhub:List*",
        "serverlessrepo:List*",
        "servicecatalog:Describe*",
        "servicediscovery:Get*",
        "servicediscovery:List*",
        "ses:Describe*",
        "shield:Describe*",
        "snowball:Describe*",
        "snowball:List*",
        "sqs:List*",
        "ssm:Describe*",
        "ssm:List*",
        "sso:Describe*",
        "sso:List*",
        "sso:Search*",
        "sso-directory:Describe*",
        "sso-directory:List*",
        "sso-directory:Search*",
        "states:List*",
        "states:Describe*",
        "storagegateway:Describe*",
        "storagegateway:List*",
        "sts:GetCallerIdentity",
        "sts:GetSessionToken",
        "swf:Describe*",
        "synthetics:Describe*",
        "synthetics:List*",
        "tag:Get*",
        "transfer:Describe*",
        "transfer:List*",
        "transcribe:List*",
        "wafv2:Describe*",
        "worklink:Describe*",
        "worklink:List*"
      ]
    }
  ]
}
      EOF
  }

}

resource "aws_iam_policy_attachment" "vantage_cross_account_connection" {
  name       = "vantage_cross_account_connection-view-only"
  roles      = [aws_iam_role.vantage_cross_account_connection.name]
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_cur_report_definition" "vantage_cost_and_usage_reports" {
  report_name                = "VantageReport-2fcedd1735"
  time_unit                  = "DAILY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = aws_s3_bucket.vantage_cost_and_usage_reports.id
  s3_region                  = "us-east-1"
  s3_prefix                  = "daily-v1"
  report_versioning          = "OVERWRITE_REPORT"
  refresh_closed_reports     = true
  depends_on = [
    aws_s3_bucket_policy.vantage_cost_and_usage_reports
  ]
}

resource "aws_s3_bucket" "vantage_cost_and_usage_reports" {
  bucket        = "vantage-cur-65298304-4712-4a16-8fd3-9bcb21e91d34-2fcedd1735"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "vantage_bucket_acl" {
  bucket = aws_s3_bucket.vantage_cost_and_usage_reports.id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "vantage_cost_and_usage_reports" {
  bucket = aws_s3_bucket.vantage_cost_and_usage_reports.id

  rule {
    id = "remove-old-reports"

    expiration {
      days = 200
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "vantage_cost_and_usage_reports" {
  bucket                  = aws_s3_bucket.vantage_cost_and_usage_reports.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_policy" "vantage_cost_and_usage_reports" {
  bucket = aws_s3_bucket.vantage_cost_and_usage_reports.id
  policy = data.aws_iam_policy_document.vantage_cur_access.json
  depends_on = [
    aws_s3_bucket_public_access_block.vantage_cost_and_usage_reports
  ]
}

resource "aws_s3_bucket_notification" "vantage_cost_and_usage_reports" {
  bucket = aws_s3_bucket.vantage_cost_and_usage_reports.id
  topic {
    topic_arn     = "arn:aws:sns:us-east-1:630399649041:cost-and-usage-report-uploaded"
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".csv.gz"
  }
  depends_on = [
    aws_s3_bucket.vantage_cost_and_usage_reports
  ]
}

data "aws_iam_policy_document" "vantage_cur_retrieval" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl"
    ]

    resources = [
      "${aws_s3_bucket.vantage_cost_and_usage_reports.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "vantage_cur_access" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy"
    ]
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }

    resources = [
      "${aws_s3_bucket.vantage_cost_and_usage_reports.arn}"
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject"
    ]
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }

    resources = [
      "${aws_s3_bucket.vantage_cost_and_usage_reports.arn}/*"
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl"
    ]
    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_role.vantage_cross_account_connection.arn}"]
    }

    resources = [
      "${aws_s3_bucket.vantage_cost_and_usage_reports.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "vantage_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::630399649041:role/vantage-account-sync-a70532e2-82ff-439b-9542-eb8d9331e137"]
    }
    condition {
      variable = "sts:ExternalId"
      test     = "StringEquals"
      values   = ["5yw80N4A_1FcKD5WRaJsLA"]
    }
  }
}

output "vantage_cross_account_arn" {
  value = aws_iam_role.vantage_cross_account_connection.arn
}

output "vantage_cost_and_usage_report_bucket" {
  value = aws_s3_bucket.vantage_cost_and_usage_reports.bucket
}
