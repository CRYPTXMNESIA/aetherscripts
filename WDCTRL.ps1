# Windows Defender Management Script
powershell.exe -ExecutionPolicy Bypass -Command {
    function Disable-WindowsDefender {
        Write-Host "Disabling Windows Defender..."

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

        Write-Host "Windows Defender has been disabled."
    }

    function Enable-WindowsDefender {
        Write-Host "Enabling Windows Defender..."

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

        Write-Host "Windows Defender has been enabled."
    }

    while ($true) {
        Write-Host "0: Windows Defender OFF"
        Write-Host "1: Windows Defender ON"
        Write-Host ""

        $option = Read-Host ">"

        if ($option -eq '0') {
            Disable-WindowsDefender
            break
        } elseif ($option -eq '1') {
            Enable-WindowsDefender
            break
        } else {
            Write-Host "Invalid option. Please enter 0 or 1."
        }
    }
}
