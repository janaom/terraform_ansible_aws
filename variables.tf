variable vpc_cidr {
     type = string
     default = "10.0.0.0/24"
}

variable public_cidrs {
      type = list(strings)
      default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable private_cidrs {
      type = list(strings)
      default = ["10.0.3.0/24", "10.0.4.0/24"]
}
