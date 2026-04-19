# SAY hook — catches destructive intent in user prompts

$json = [Console]::In.ReadToEnd() | ConvertFrom-Json
$prompt = $json.prompt

if ($prompt -match "delete all|destroy|remove all|wipe|nuke|drop all") {
    Write-Output '{"decision": "block", "reason": "Destructive intent detected. Please use /tf-destroy for controlled infrastructure teardown."}'
}
