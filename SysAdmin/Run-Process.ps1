#source https://github.com/warferik/WindowsTLS12/blob/master/WinRM-Mem.ps1


Function Run-Process($executable, $arguments) {
    $process = New-Object -TypeName System.Diagnostics.Process
    $psi = $process.StartInfo
    $psi.FileName = $executable
    $psi.Arguments = $arguments
    Write-Verbose -Message "starting new process '$executable $arguments'"
    $process.Start() | Out-Null

    $process.WaitForExit() | Out-Null
    $exit_code = $process.ExitCode
    Write-Verbose -Message "process completed with exit code '$exit_code'"

    return $exit_code
}

