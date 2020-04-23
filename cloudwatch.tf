resource "aws_cloudwatch_event_rule" "every_minute" {
    name = "every-minute"
    description = "Fires every minute"
    schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "start_stop_ec2_instance_every_minute" {
    rule = "${aws_cloudwatch_event_rule.every_minute.name}"
    target_id = "start_stop_ec2_instance"
    arn = "${aws_lambda_function.start_stop_ec2_instance.arn}"
    input= <<EOF
{
  "event": "stop",
}
EOF
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_stop_ec2_instance" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.start_stop_ec2_instance.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.every_minute.arn}"
}

