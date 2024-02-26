resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_vol.id
  instance_id = aws_instance.server.id
}

resource "aws_ebs_volume" "ebs_vol" {
  availability_zone = var.availability_zone
  size = 1
}