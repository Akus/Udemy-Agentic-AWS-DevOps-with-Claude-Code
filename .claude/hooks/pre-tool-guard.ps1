# DO hook — blocks dangerous Bash commands before they execute

$json = [Console]::In.ReadToEnd() | ConvertFrom-Json
$cmd = $json.tool_input.command

if ($cmd -match "terraform destroy|terraform apply.*-auto-approve|aws s3 rm|aws s3 rb") {
    Write-Output '{"decision": "block", "reason": "Destructive command detected. Use /tf-destroy or /tf-apply commands for safety."}'
}
