$SourcePath = Join-Path $PSScriptRoot -ChildPath '..\source'
$TargetPath = Join-Path $PSScriptRoot -ChildPath '..\dist'

Remove-Item $TargetPath -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item -Path $SourcePath -Destination $TargetPath -Recurse -Force

$Colours = @('red', 'green', 'purple', 'cyan', 'light_gray', 'gray', 'pink', 'lime', 'yellow', 'light_blue', 'magenta', 'orange', 'black', 'brown', 'blue', 'white')

Get-ChildItem -Path $TargetPath -Include '*.json' -Recurse | ForEach-Object {
    $FullPath = $_
    if ($FullPath -Match '{colour}') {
        $TargetDir = Split-Path -Path $FullPath -Parent
        $Filename = Split-Path -Path $FullPath -Leaf
        foreach ($Colour in $Colours) {
            $TargetFile = Join-Path -Path $TargetDir -ChildPath ($Filename -Replace '{colour}', $Colour)
            ((Get-Content -Path $FullPath) -Replace '{colour}', $Colour) | Set-Content -Path $TargetFile
        }
        Remove-Item -Path $FullPath
    }
}