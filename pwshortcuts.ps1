function cmakeraw {cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc}
function buildraw {cmake --build build --parallel}
function histo {cat (Get-PSReadLineOption).HistorySavePath}
function which {param([string]$_) (get-command $_).source}
function sha {param([string]$_) (get-fileHash $_).hash.tolower()}
function hevc {
    [CmdletBinding()]
    param($p)
    process {
        if (-not ($p -is [System.IO.FileInfo])) {
            $pf = Get-Item -Path $p
        }
        $f = Get-Item -LiteralPath $pf
        $_ = "$($f.BaseName)_hevc"
        ffmpeg -hwaccel cuda -y -i "$f" -c:v hevc -pass 1 -x265-params preset=slow -an -f null NUL
        ffmpeg -hwaccel cuda -i "$f" -c:v hevc -pass 2 -x265-params preset=slow $_`.mp4
    }
}
function qhevc {
    [CmdletBinding()]
    param(
        $p
    )
    process {
        if (-not ($p -is [System.IO.FileInfo])) {
            $pf = Get-Item -Path $p
        }
        $f = Get-Item -LiteralPath $pf
        $_ = "$($f.BaseName)_hevc$($f.Extension)"
        ffmpeg -i $f.FullName -c:v hevc $_
    }
}
function full {
    param(
        [Path]$p
    )
    process {
        pwd
        ffmpeg -i $p what.mp4
    }
}
