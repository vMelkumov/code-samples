$buildNumber = $env:Build_BuildNumber
$pattern = '\[assembly: AssemblyFileVersion\("(.*)"\)\]'
$assemblyFiles = Get-ChildItem . AssemblyInfo.cs -rec

foreach ($file in $assemblyFiles)
{
    $fileContent = Get-Content $file.PSPath

    $lineIndex = 0;
    for(<# empty #>; $lineIndex -lt $fileContent.Length; $lineIndex++) {
        $line = $fileContent[$lineIndex]
        if ($line -match $pattern) {
            $splittedLine = $line -split "\."
            $splittedLine[2] = $buildNumber
            $fileContent[$lineIndex] = $splittedLine -join "."
            break
        }
    }
        
    Set-Content -Path $file.PSPath -Value $fileContent
}