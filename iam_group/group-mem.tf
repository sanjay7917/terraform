resource "aws_iam_group_membership" "dev_teams" {
  name = "dev-team-group-membership"

  users = [
    aws_iam_user.dev.name,
    aws_iam_user.test.name
  ]

  group = aws_iam_group.developers.name
}

resource "aws_iam_group_membership" "test_teams" {
  name = "test-team-group-membership"

  users = [
    aws_iam_user.dev.name,
    aws_iam_user.monitor.name,
    aws_iam_user.test.name
  ]

  group = aws_iam_group.testers.name
}

resource "aws_iam_group_membership" "moniter_teams" {
  name = "moniter-team-group-membership"

  users = [
    aws_iam_user.accounts.name,
    aws_iam_user.monitor.name,
    aws_iam_user.dev.name
  ]

  group = aws_iam_group.monitoring.name
}

resource "aws_iam_group_membership" "accounts_teams" {
  name = "account-team-group-membership"

  users = [
    aws_iam_user.accounts.name,
    aws_iam_user.monitor.name,
    aws_iam_user.dev.name,
    aws_iam_user.test.name
  ]

  group = aws_iam_group.accounts.name
}