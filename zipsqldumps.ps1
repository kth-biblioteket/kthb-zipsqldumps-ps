#
#Script som läser sql-dumpar rekursivt.
# Zippar dem och tar bort originalet
#
#
#
# Set variables
$FolderPath = "f:\mysqlbkps"
#$FolderPath = "f:\bkps1"
$ArchiveLimit = 7
$Logfile = "C:\Temp\ArchiveLog $(Get-Date -f yyyy-MM-dd).csv"
Write-Output $Logfile

Function LogWrite
{
  Param ([string]$logstring)

  Add-content $Logfile -value $logstring
}

# Loop 1
Get-ChildItem -Path $FolderPath -Directory -Recurse | ForEach-Object {
    # Loop 2 
    Get-ChildItem -Path $_.FullName -Recurse -Include dumpfile.sql | ForEach-Object {
       $_.FullName
       $zipfile = $_.DirectoryName + '\dumpfile.zip'
       Compress-Archive -Path $_.FullName -DestinationPath $zipfile
       Remove-Item $_.FullName
    }
}