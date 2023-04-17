resource "aws_iam_user_policy" "dev_pol" {
  name = "s3_pol"
  user = aws_iam_user.dev.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObjectVersionTagging",
          "s3:GetStorageLensConfigurationTagging",
          "s3:GetObjectAcl",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetIntelligentTieringConfiguration",
          "s3:GetObjectVersionAcl",
          "s3:GetBucketPolicyStatus",
          "s3:GetAccessPointPolicy",
          "s3:GetObjectVersion"
        ],
        "Resource" : "arn:aws:s3:*:385685296160:accesspoint/*"
      }
    ]
  })
}

resource "aws_iam_user" "dev" {
  name = "dev"
}
