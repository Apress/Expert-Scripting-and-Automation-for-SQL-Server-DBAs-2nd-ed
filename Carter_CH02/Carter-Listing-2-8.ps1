 for ($i=1; $i -le 3; $i++) {
    try {
      Get-Content c:\ExpertScripting.txt -ErrorAction Stop
          "Attempt " + $i + " Succeeded"
          break
    } catch {
        "Attempt " + $i + " Failed"
        Start-Sleep -s 30
    }
}
