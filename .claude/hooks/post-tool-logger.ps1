# LOG hook — records every terraform apply to the deploy log

$json = [Console]::In.ReadToEnd() | ConvertFrom-Json
$cmd = $json.tool_input.command

if ($cmd -match "terraform apply") {
    $timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    Add-Content -Path ".claude/deploy.log" -Value "[$timestamp] terraform apply executed"
}
