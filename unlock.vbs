Set objShell = CreateObject("WScript.Shell")
Set objExec = objShell.Exec("manage-bde -status")

Do While Not objExec.StdOut.AtEndOfStream
    strLine = objExec.StdOut.ReadLine
    
    If InStr(strLine, "Volume") > 0 Then
        arrTokens = Split(strLine)
        drive = arrTokens(1)
        drive = Left(drive, 1)
        
        objShell.Run "manage-bde -unlock " & drive & ": -password"
        WScript.Sleep 1000
        objShell.SendKeys WScript.Arguments.Item(0)
        WScript.Sleep 1000
        objShell.SendKeys "{ENTER}"
    End If
Loop
