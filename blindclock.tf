resource "aws_sqs_queue" "blindclock" {
  name                       = "blindclock.fifo"
  fifo_queue                 = true
  visibility_timeout_seconds = 5
}

resource "aws_iam_user" "blindclock_reader" {
  name = "blindclock_reader"
}

resource "awscreds_iam_access_key" "blindclock_reader" {
  user = aws_iam_user.blindclock_reader.name
  file = "creds/${aws_iam_user.blindclock_reader.name}"
}

data "aws_iam_policy_document" "blindclock_reader" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:DeleteMessage",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
    ]
    resources = [aws_sqs_queue.blindclock.arn]
  }
}

resource "aws_iam_user_policy" "blindclock_reader" {
  name   = "blindclock_reader"
  user   = aws_iam_user.blindclock_reader.name
  policy = data.aws_iam_policy_document.blindclock_reader.json
}

resource "aws_iam_user" "blindclock_writer" {
  name = "blindclock_writer"
}

resource "awscreds_iam_access_key" "blindclock_writer" {
  user = aws_iam_user.blindclock_writer.name
  file = "creds/${aws_iam_user.blindclock_writer.name}"
}

data "aws_iam_policy_document" "blindclock_writer" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:GetQueueUrl",
      "sqs:SendMessage",
    ]
    resources = [aws_sqs_queue.blindclock.arn]
  }
}

resource "aws_iam_user_policy" "blindclock_writer" {
  name   = "blindclock_writer"
  user   = aws_iam_user.blindclock_writer.name
  policy = data.aws_iam_policy_document.blindclock_writer.json
}
