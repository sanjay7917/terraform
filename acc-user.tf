resource "aws_iam_user_policy" "accounts_pol" {
  name = "bill_pol"
  user = aws_iam_user.accounts.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "billing:ListBillingViews",
          "billing:GetSellerOfRecord",
          "billing:GetBillingDetails",
          "billing:GetBillingNotifications",
          "billing:GetBillingPreferences",
          "billing:GetBillingData",
          "billing:GetIAMAccessPreference",
          "billing:GetContractInformation",
          "billing:GetCredits"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_user" "accounts" {
  name = "accounts"
}
