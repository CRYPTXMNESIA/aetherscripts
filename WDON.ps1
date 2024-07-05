# Enable Windows Defender Script
powershell.exe -ExecutionPolicy Bypass -Command {
    # Enable Real-Time Monitoring
    Set-MpPreference -DisableRealtimeMonitoring $false

    # Enable Cloud-Based Protection
    Set-MpPreference -MAPSReporting 2

    # Enable Automatic Sample Submission
    Set-MpPreference -SubmitSamplesConsent 1

    # Enable Windows Defender Antivirus
    sc config WinDefend start= auto
    sc start WinDefend

    # Enable Windows Defender Firewall
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
}
