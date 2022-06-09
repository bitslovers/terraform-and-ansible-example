resource "aws_iam_role" "iam_role" {
  name               = "bits-iam_profile"
  assume_role_policy = "${file("${path.module}/role.json")}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = "bits-iam_profile"
  role = "${aws_iam_role.iam_role.name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_policy" "policy" {
  name        = "bits-policy"
  description = "IAM Policy"
  policy      = "${file("${path.module}/policy.json")}"
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "bits-policy"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}
