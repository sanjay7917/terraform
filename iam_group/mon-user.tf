resource "aws_iam_user_policy" "monitor_pol" {
  name = "cloud_pol"
  user = aws_iam_user.monitor.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : [
        "cloudwatch:DescribeAlarmHistory",
        "cloudwatch:GetDashboard",
        "cloudwatch:GetInsightRuleReport",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:GetMetricStream"
      ],
      "Resource" : "arn:aws:cloudwatch:*:385685296160:alarm:*"
      }
    ]
  })
}

resource "aws_iam_user" "monitor" {
  name = "monitor"
}
