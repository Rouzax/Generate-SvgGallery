# SVG Gallery Generator

A PowerShell script that generates a clean, responsive HTML gallery from a directory of SVG files. The gallery organizes SVGs by folder structure and displays them in a grid layout with their filenames.

## Features

- Recursively scans directories for SVG files
- Creates a responsive grid layout
- Organizes SVGs by folder structure with section headers
- Displays SVG filename underneath each image
- Mobile-friendly design
- Clean, modern interface with consistent styling

## Installation

1. Clone this repository or download the `Generate-SvgGallery.ps1` script
2. Ensure you have PowerShell installed on your system
3. No additional dependencies required

## Usage

Basic usage with default output filename (`index.html`):
```powershell
.\Generate-SvgGallery.ps1 -SourceDirectory "C:\Path\To\SVGs"
```

Specify a custom output filename:
```powershell
.\Generate-SvgGallery.ps1 -SourceDirectory "C:\Path\To\SVGs" -OutputFile "my-gallery.html"
```

### Parameters

- `SourceDirectory` (Mandatory): The directory containing your SVG files
- `OutputFile` (Optional): The name of the output HTML file (defaults to "index.html")

## Output

The script generates an HTML file with the following features:
- Section headers based on folder structure
- 100x100px SVG previews
- Responsive grid layout
- Light gray backgrounds for better SVG visibility
- Hover effects on containers
- Mobile-friendly design

## Example Output Structure

```
SVG Gallery
├── Folder 1
│   ├── icon1.svg
│   └── icon2.svg
├── Folder 2
│   ├── Subfolder 1
│   │   └── icon3.svg
│   └── icon4.svg
└── Root Directory
    └── icon5.svg
```

## Contributing

Feel free to open issues or submit pull requests with improvements.

## License

MIT License - feel free to use this in your own projects!