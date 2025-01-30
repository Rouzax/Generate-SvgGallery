param(
    [Parameter(Mandatory=$true)]
    [string]$SourceDirectory,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputFile = "index.html"
)

# Resolve the full path of the source directory (without trailing slash)
$sourcePath = (Resolve-Path $SourceDirectory).Path.TrimEnd('\')
if (-not (Test-Path $sourcePath)) {
    Write-Error "Source directory does not exist: $SourceDirectory"
    exit 1
}

# Combine the output path with the source directory
$outputPath = Join-Path $sourcePath $OutputFile

# Get all SVG files recursively from the specified directory
$svgFiles = Get-ChildItem -Path $sourcePath -Filter "*.svg" -Recurse

# Create HTML content
$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SVG Gallery</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .section {
            margin: 40px 0;
        }
        .section-header {
            background-color: #ffffff;
            padding: 15px 25px;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 1.2em;
            color: #333;
        }
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 15px;
            padding: 20px;
        }
        .image-container {
            background-color:rgb(238, 238, 238);
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        .svg-image {
            width: 100px;
            height: 100px;
            object-fit: contain;
            margin-bottom: 10px;
        }
        .filename {
            font-size: 12px;
            color: #333;
            word-break: break-all;
        }
    </style>
</head>
<body>
    <h1>SVG Gallery</h1>
"@

# Group files by directory
$groupedFiles = $svgFiles | Group-Object DirectoryName

foreach ($group in $groupedFiles) {
    # Get the relative path for the section header
    try {
        $sectionPath = $group.Name.Replace($sourcePath, "").TrimStart('\')
        if ([string]::IsNullOrEmpty($sectionPath)) { 
            $sectionPath = "Root Directory" 
        }
    } catch {
        $sectionPath = "Root Directory"
    }
    
    $htmlContent += @"
    <div class="section">
        <div class="section-header">$sectionPath</div>
        <div class="gallery">
"@

    foreach ($file in $group.Group) {
        try {
            # Convert the full path to a web-friendly relative path
            $relativePath = $file.FullName.Replace($sourcePath, "").TrimStart('\')
            # Replace backslashes with forward slashes for web URLs
            $relativePath = $relativePath.Replace("\", "/")
            
            $htmlContent += @"
            <div class="image-container">
                <img src="./$relativePath" class="svg-image" alt="$($file.Name)">
                <div class="filename">$($file.Name)</div>
            </div>
"@
        } catch {
            Write-Warning "Error processing file: $($file.FullName)"
        }
    }

    $htmlContent += @"
        </div>
    </div>
"@
}

# Close HTML tags
$htmlContent += @"
</body>
</html>
"@

# Save the HTML file to the source directory
$htmlContent | Out-File -FilePath $outputPath -Encoding UTF8

Write-Host "Gallery has been generated as '$outputPath'"
Write-Host "Found $($svgFiles.Count) SVG files in $($groupedFiles.Count) directories"