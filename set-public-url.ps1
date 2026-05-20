param(
  [Parameter(Mandatory = $true)]
  [string]$PublicUrl
)

$ErrorActionPreference = "Stop"

function Set-FileUtf8NoBom {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [Parameter(Mandatory = $true)]
    [string]$Content
  )

  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Content, $utf8NoBom)
}

function Update-SharePage {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [Parameter(Mandatory = $true)]
    [string]$CanonicalUrl,
    [Parameter(Mandatory = $true)]
    [string]$PageUrl,
    [Parameter(Mandatory = $true)]
    [string]$ImageUrl
  )

  $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8

  $content = [regex]::Replace(
    $content,
    '<link rel="canonical" href="[^"]+">',
    '<link rel="canonical" href="' + $CanonicalUrl + '">'
  )

  $content = [regex]::Replace(
    $content,
    '<meta itemprop="url" content="[^"]+">',
    '<meta itemprop="url" content="' + $PageUrl + '">'
  )

  $content = [regex]::Replace(
    $content,
    '<meta property="og:url" content="[^"]+">',
    '<meta property="og:url" content="' + $PageUrl + '">'
  )

  $content = [regex]::Replace(
    $content,
    '(?s)<meta\s+itemprop="image"\s+content="[^"]+"\s*>',
    '<meta itemprop="image" content="' + $ImageUrl + '">'
  )

  $content = [regex]::Replace(
    $content,
    '(?s)<meta\s+property="og:image"\s+content="[^"]+"\s*>',
    '<meta property="og:image" content="' + $ImageUrl + '">'
  )

  $content = [regex]::Replace(
    $content,
    '(?s)<meta\s+property="og:image:secure_url"\s+content="[^"]+"\s*>',
    '<meta property="og:image:secure_url" content="' + $ImageUrl + '">'
  )

  $content = [regex]::Replace(
    $content,
    '(?s)<meta\s+name="twitter:image"\s+content="[^"]+"\s*>',
    '<meta name="twitter:image" content="' + $ImageUrl + '">'
  )

  Set-FileUtf8NoBom -Path $Path -Content $content
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$normalized = $PublicUrl.Trim().TrimEnd("/")

if (-not $normalized) {
  throw "PublicUrl must not be empty."
}

$imageUrl = ('{0}/share-cover.png' -f $normalized)

Update-SharePage -Path (Join-Path $root 'index.html') -CanonicalUrl ('{0}/' -f $normalized) -PageUrl ('{0}/' -f $normalized) -ImageUrl $imageUrl

Update-SharePage -Path (Join-Path $root 'share.html') -CanonicalUrl ('{0}/share.html' -f $normalized) -PageUrl ('{0}/share.html' -f $normalized) -ImageUrl $imageUrl

Update-SharePage -Path (Join-Path $root 'letter.html') -CanonicalUrl ('{0}/letter.html' -f $normalized) -PageUrl ('{0}/letter.html' -f $normalized) -ImageUrl $imageUrl

Write-Host "Updated public URL: $normalized"
Write-Host "If you changed the share-cover text, regenerate share-cover.png."
