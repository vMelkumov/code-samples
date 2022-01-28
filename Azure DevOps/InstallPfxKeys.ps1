# TODO: Add copyright notice.

$pfxFiles = Get-ChildItem -Path . *.pfx -Recurse
$keyFiles = Get-ChildItem -Path . *.Key.txt -Recurse

if ($keyFiles.Length -lt 0)
{
    throw "Key text file was not found."
}

$pass = [String](Get-Content $keyFiles[0].FullName)

foreach ($pfxFile in $pfxFiles)
{
    $isAlreadyInstalled = SnInstallPfx $pfxFile.FullName | Select-String -Pattern "Installed:" | %{$_.ToString().EndsWith("True")}

    if ($isAlreadyInstalled) {
        SnInstallPfx $pfxFile.FullName
    } else {
        SnInstallPfx $pfxFile.FullName $pass
    }
}