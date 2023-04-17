resource "aws_iam_user_policy" "test_pol" {
  name = "ec2_pol"
  user = aws_iam_user.test.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:GetResourcePolicy",
          "ec2:GetManagedPrefixListEntries",
          "ec2:GetIpamResourceCidrs",
          "ec2:GetIpamPoolCidrs",
          "ec2:GetInstanceUefiData",
          "ec2:GetIpamDiscoveredResourceCidrs",
          "ec2:GetIpamDiscoveredAccounts"
        ],
        "Resource" : "arn:aws:ec2:*:385685296160:capacity-reservation/*"
      },
    ]
  })
}

resource "aws_iam_user" "test" {
  name = "test"
}
