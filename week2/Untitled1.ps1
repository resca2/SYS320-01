
Get-Service | Where-Object {$_.Status -eq "Stopped"} | `
    Sort-Object name | Export-Csv -Path "C:\Users\champuser\SYS320-01\week2\stopped_services.csv" 
