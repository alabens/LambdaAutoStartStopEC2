resource "aws_iam_role" "StartStopInstance" {
  name               = "StartStopInstance"
  assume_role_policy = "${data.aws_iam_policy_document.StartStopInstance.json}"
}

data "aws_iam_policy_document" "StartStopInstance" {
  statement {
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role_policy" "StartStopInstance-policy" {
  name   = "StartStopInstance-policy"
  role   = "${aws_iam_role.StartStopInstance.id}"
  policy = "${data.aws_iam_policy_document.StartStopInstance-policy.json}"
}

data "aws_iam_policy_document" "StartStopInstance-policy" {
  statement {
    effect    = "Allow"
    actions   = [
      "ec2:*",
    ]
    resources = [
      "*",
    ]
  }
}


resource "aws_lambda_function" "start_stop_ec2_instance" {
  filename      = "LambdaFunction/StartStopEC2Instances.zip"
  function_name = "StartStopEC2Instances"
  role          = "${aws_iam_role.StartStopInstance.arn}"
  handler       = "StartStopEC2Instances.lambda_handler"
  timeout= "5"
  source_code_hash = "${filebase64sha256("LambdaFunction/StartStopEC2Instances.zip")}"
  runtime = "python3.7"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
