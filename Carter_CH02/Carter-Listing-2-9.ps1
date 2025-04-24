$i = 0
while ($true) {
    try {
        $i++
        Get-Content c:\ExpertScripting.txt -ErrorAction Stop
        "Attempt " + $i + " Succeeded"
        break
    } catch {
        "Attempt " + $i + " Failed"
        Start-Sleep -s 30
    }
}
