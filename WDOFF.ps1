# Disable Windows Defender Script
powershell.exe -ExecutionPolicy Bypass -Command {
    # Disable Real-Time Monitoring
    Set-MpPreference -DisableRealtimeMonitoring $true

    # Disable Cloud-Based Protection
    Set-MpPreference -MAPSReporting 0

    # Disable Automatic Sample Submission
    Set-MpPreference -SubmitSamplesConsent 2

    # Disable Windows Defender Antivirus
    sc stop WinDefend
    sc config WinDefend start= disabled

    # Disable Windows Defender Firewall
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
}
