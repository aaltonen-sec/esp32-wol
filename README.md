# Description
A bidirectional network monitoring architecture utilizing an ESP32 and a Windows machine. The ESP32 continuously polls the target machine via ICMP ping and broadcasts a Wake-on-LAN (WoL) magic packet if the system is unresponsive. Concurrently, a PowerShell script on the Windows machine polls the ESP32. If the ESP32 becomes unreachable (indicating isolated power loss or network failure) the Windows machine transmits an alert payload to a Discord webhook and initiates a forced self-shutdown to prevent data corruption.

# Requirements
Hardware:\
• ESP32 microcontroller.\
• Windows machine with Wake-on-LAN (WoL) enabled at the BIOS/UEFI level.\

Software:\
• Arduino IDE.\
• Arduino Libraries: ESPping, WakeOnLan.\
• Windows PowerShell.

# Deployment
ESP32 Execution:
1. Duplicate secrets.example.h and rename the copy to secrets.h.
2. Populate secrets.h with the local WLAN SSID, password, desired static IP configuration, and the target Windows machine's IP and MAC address.
3. Compile and flash wol.ino to the ESP32.

# Windows Execution:
1. Open autoshutdown.ps1.
2. Assign the ESP32's static IP to the $ESP_IP variable.
3. Replace the $WEBHOOK_URL placeholder with an active Discord webhook URL.
4. Configure Windows Task Scheduler to execute autoshutdown.ps1 automatically on system startup with administrative privileges.
