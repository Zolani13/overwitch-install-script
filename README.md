# Overwitch Install Script

This is a simple Bash script for an easier install of [dagargo's JACK Client for Elektron devices](https://github.com/dagargo/overwitch) onto Ubuntu systems. 

(This script does not install the systemd service option.)


## How to Use
- Ensure you have git installed onto your computer
- Enable the ability to execute the script as a program in your File Manager.
- The script will clone the overwitch repository into whichever directory the script is downloaded into.
- Restart your system to ensure audio user group changes are made.

## After Installation Tip
- Go into QJackCTL -> Setup -> Misc -> "Start Jack Audio Server on Application Startup" and "Start Minimized on System Tray". This will ensure that the Jack server will run when you log into your computer. When running overwitch on Ubuntu related systems you must have the Jack Client running while overwitch is on. 


