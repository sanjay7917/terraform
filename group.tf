resource "aws_iam_group" "developers" {
  name = "developers"
}
resource "aws_iam_group" "accounts" {
  name = "accounts"
}
resource "aws_iam_group" "testers" {
  name = "testers"
}
resource "aws_iam_group" "monitoring" {
  name = "monitoring"
}
