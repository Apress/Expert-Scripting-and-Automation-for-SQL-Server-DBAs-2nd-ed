# dot source the configuration file
. C:\Scripts\WindowsConfig.ps1 

# compile the modffile
WindowsConfig -Edition Developer -SqlInstanceName 'DSCInstance2'

# apply the configuration
Start-DscConfiguration -Path "C:\Scripts\WindowsConfig" -Verbose -Wait
