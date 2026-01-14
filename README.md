# Position Helper

An interactive Typst package to make positioning elements (annotations, bars, etc.) easier in your documents.

# Typst Visual

![Demo](https://raw.githubusercontent.com/E-Paroxysme/Typst_Visual/Version_ok/Video/Video_demo-ezgif.com-video-to-gif-converter.gif)

## The problem

Precisely positioning an annotation on an image or a chart in Typst is often frustrating. You have to guess coordinates, compile, adjust, recompile…

## The solution

Position Helper displays a visual marker that you can move by typing commands. Thanks to Typst’s live preview, you can see the marker move in real time and get the exact coordinates to use with `place()`.

## Installation

### Local package

    # Create the directory
    mkdir -p ~/.local/share/typst/packages/local/position-helper/0.1.0

    # Copy the files
    cp -r src typst.toml ~/.local/share/typst/packages/local/position-helper/0.1.0/

Then in your documents:

    #import "@local/position-helper:0.1.0": ph

### Direct usage

If you are working inside the project directory:

    #import "src/lib.typ": ph

## Usage

    #import "@local/position-helper:0.1.0": ph

    #show: ph("ddddzzzz")

    // Your normal content
    = My title
    #image("my-image.png")

The red marker is overlaid on top of your content. Modify the command string to move it.

## Controls (ZQSD layout)

| Key | Action |
|-----|--------|
| `z` | Move up |
| `s` | Move down |
| `q` | Move left |
| `d` | Move right |
| `a` | Decrease step (-1pt) |
| `e` | Increase step (+1pt) |
| `r` | Reset position |

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `commands` | string | `""` | Command string (zqsd...) |
| `start-x` | length | `297.5pt` | Initial X position |
| `start-y` | length | `421pt` | Initial Y position |
| `step` | integer | `10` | Movement step (in pt) |
| `marker-size` | length | `8pt` | Marker size |
| `marker-color` | color | `red` | Marker color |
| `show-grid` | boolean | `false` | Show reference grid |
| `grid-step` | length | `50pt` | Grid spacing |
| `margin` | length | `2.5cm` | Page margin (used for coordinate calculation) |

## Workflow

1. Add `#show: ph("")` at the top of your document
2. Type commands in the string (e.g. `"ddddzzzz"`)
3. Watch the marker move in the preview
4. Note the displayed X and Y coordinates
5. Use these coordinates with `place()`:

    #place(
      top + left,
      dx: 150pt,
      dy: 80pt,
      [My annotation]
    )

6. Remove the `#show: ph(...)` line when you are done

## Examples

### Basic

    #import "@local/position-helper:0.1.0": ph

    #show: ph("ddddddddddssssssssss")

    = My Document
    #lorem(100)

### With grid

    #show: ph("dddddddddd", show-grid: true)

### Custom margins

If your document uses margins different from 2.5 cm:

    #set page(margin: 1cm)
    #show: ph("dddddddddd", margin: 1cm)

### Custom start position

    #show: ph("", start-x: 100pt, start-y: 100pt)

## License

MIT
