/*====
The VPC
======*/
## cidrsubnet(aws_vpc.app_vpc.cidr_block, 4, count.index) this creates /16

resource "aws_vpc" "vpc" {
  cidr_block = cidrsubnet("10.1.0.0/16", 4, var.region_number[data.aws_region.current.name])

  tags = {
    Name  = "${var.name}-vpc"
    Owner = var.owner
  }
}
# cidrsubnet(aws_vpc.app_vpc.cidr_block, 8, count.index) this creates /24 
resource "aws_subnet" "public_subnet" {
  count = var.enabled ? 1 : 0
  #count             = length(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index) #
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "public_subnet-${count.index}"
  }

}

###############################################################
/*====
Subnets
======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${var.name}-igw"
    Owner = var.owner
  }
}


/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${var.name}-public-route-table"
    Owner = var.owner
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}



/* Route table associations */

resource "aws_route_table_association" "public" {
  count = var.enabled ? 1 : 0
  # count          = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public.id
}


/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  count = var.enabled ? 1 : 0
  #count      = length(data.aws_availability_zones.available.names)
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name  = "${var.name}-nat-eip-${count.index}"
    Owner = var.owner
  }
}

/* NAT */
resource "aws_nat_gateway" "nat_gw" {
  count = var.enabled ? 1 : 0
  #count         = length(data.aws_availability_zones.available.names)
  allocation_id = aws_eip.nat_eip.*.id[count.index]
  subnet_id     = aws_subnet.public_subnet.*.id[count.index]
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name  = "${var.name}-nat-gw-${count.index}"
    Owner = var.owner
  }
}


