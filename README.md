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
