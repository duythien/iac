resource "aws_subnet" "private" {
  count             = "3"
  availability_zone = element(data.aws_availability_zones.current.names, count.index)
  vpc_id            = aws_vpc.standard.id
  # https://www.terraform.io/docs/configuration/functions/cidrsubnet.html
  cidr_block = cidrsubnet("10.0.0.0/16", 3, count.index)
  tags = {
    Name = "private-${element(data.aws_availability_zones.current.names, count.index)}"
    Tier = "private"
  }
}

resource "aws_subnet" "public" {
  count             = "3"
  availability_zone = element(data.aws_availability_zones.current.names, count.index)
  vpc_id            = aws_vpc.standard.id
  # https://www.terraform.io/docs/configuration/functions/cidrsubnet.html
  cidr_block              = cidrsubnet("10.0.0.0/16", 3, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-${element(data.aws_availability_zones.current.names, count.index)}"
    Tier = "public"
  }
}
