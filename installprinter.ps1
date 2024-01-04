# Information
$printerIPAddress = Read-Host "Please enter the printer's IP address"
$printerName = Read-Host "Please enter the printer's name"
$infFilePath = Read-Host "Please enter the path to the .inf file for installation (e.g., C:\Path\to\File.inf)"
$twoPorts = Read-Host "Should two ports for black/white and color be created? (Yes/No)"
# Add printer
Add-Printer -ConnectionName "\\$printerIPAddress" -Name $printerName -DriverName "Generic / Text Only" -PortName "IP_$printerIPAddress"
# Add .inf file to installation
Add-PrinterDriver -Name $printerName -InfPath $infFilePath
# Add ports for black/white and color if wanted
if ($twoPorts -eq "Yes") {
    Add-PrinterPort -Name "${printerName}_BW" -PrinterHostAddress $printerIPAddress -PortNumber 1
    Add-PrinterPort -Name "${printerName}_Color" -PrinterHostAddress $printerIPAddress -PortNumber 2
}
# Complete printer installation
Add-Printer -Name $printerName -PortName "IP_$printerIPAddress"
# Done
