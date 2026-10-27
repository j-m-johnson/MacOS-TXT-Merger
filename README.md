# macOS TXT Merger

A lightweight Finder Quick Action for merging multiple `.txt` files into a single document, directly from macOS.

No external applications, online services, or dependencies required. Built with Automator, Zsh, and AppleScript.

### Features

- **Selection-order merging:** Merge files in the order they were Command-clicked in Finder (tested on macOS; behavior may vary).
- **Optional file headers:** Automatically insert the original filename before each file's contents.
- **Trim whitespace:** Remove unnecessary leading and trailing spaces.
- **Remove empty lines:** Optionally eliminate blank lines.
- **Custom output filename:** Choose the name of your merged file.
- **Overwrite protection:** Automatically generate a new filename if the output already exists.
- **100% local:** Your files never leave your computer.

### Use Cases

Ideal for combining lecture transcripts, meeting notes, logs, exported text documents, and other collections of plain-text files.

### How to Use

1. Select multiple `.txt` files in Finder, Command-clicking in your desired order.
2. Right-click and select **Quick Actions → Merge TXT Files**.
3. Choose your preferred formatting options.
4. Enter an output filename.
5. Find the merged document in Finder.

### Requirements

- macOS with Automator
- Zsh and AppleScript (included with macOS)
- Plain-text `.txt` files

No Python, Homebrew, or external dependencies required.

## Installation

1. Download [`Merge TXT Files.workflow.zip`](./Merge%20TXT%20Files.workflow.zip) from this repository.
2. Extract the ZIP archive.
3. Double-click `Merge TXT Files.workflow`.
4. Click **Install** when prompted by macOS.
5. Open Finder, select two or more `.txt` files, and right-click → **Quick Actions → Merge TXT Files**.

No additional dependencies are required.

### Manual Installation

If the workflow doesn't install automatically, copy `Merge TXT Files.workflow` into:

`~/Library/Services/`

You can open this directory in Finder using `Cmd + Shift + G`.

### Source Code

The underlying Zsh and AppleScript implementation is available in [`merge-txt.sh`](./merge-txt.sh).

**Note:** File merging follows the order Automator receives files from Finder. Command-click ordering was verified during development, but may vary across macOS versions or Finder configurations.
