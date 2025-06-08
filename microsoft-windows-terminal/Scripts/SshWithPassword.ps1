param(
    [Parameter(Mandatory = $true)]
    [string]$Username,

    [Parameter(Mandatory = $true)]
    [string]$HostnameBase,

    [Parameter(Mandatory = $true)]
    [string]$Password
)

# Resolve the IP address
$Ip = (Resolve-DnsName "$HostnameBase.local" -Type A).IPAddress

# Escape backslashes, quotes, and dollar signs for Bash + Expect
$EscapedPassword = $Password -replace '\\', '\\\\' -replace '"', '\"' -replace '\$', '\\$'

# Build the Expect script as a single string with single quotes inside double quotes
$ExpectCommand = "expect -c 'spawn ssh $Username@$Ip; expect `"password:`"; send `"$EscapedPassword`"; send `"\\r`"; interact'"

# Run the script via WSL
wsl bash -c "$ExpectCommand"
