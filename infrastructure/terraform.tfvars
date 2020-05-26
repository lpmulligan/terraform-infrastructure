### See variables.tf for configurable options

# Email address to send Azure Monitor alerts to
monitor_email = "lmulligan@10thmagnitude.com"

# Set to true to enable a Windows node pool
windows_enabled = true

location = "eastus2"

prefix="lpm"

tags = {
  owner        = "Lawrence Mulligan"
  organization = "Home"
}