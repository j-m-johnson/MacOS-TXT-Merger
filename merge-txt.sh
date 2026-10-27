
#!/bin/zsh

# MERGE TXT FILES — Finder Quick Action
# Preserves the file order received from Finder.

# 1. Validate selected files
if (( $# < 2 )); then
  osascript -e 'display alert "Select at least two TXT files."'
  exit 1
fi

for file in "$@"; do
  if [[ ! -f "$file" || "${file:l}" != *.txt ]]; then
    osascript -e 'display alert "Please select only TXT files."'
    exit 1
  fi
done

# IMPORTANT:
# "$@" preserves Automator's input order.
# Do NOT alphabetically sort the files.

# 2. Choose merge settings
selection=$(osascript <<'APPLESCRIPT'
set choices to {"Add file headers", "Trim whitespace", "Remove empty lines"}

set picked to choose from list choices ¬
    with title "Merge TXT Settings" ¬
    with prompt "Select your merge options:" ¬
    default items {"Add file headers"} ¬
    with multiple selections allowed and empty selection allowed

if picked is false then
    return "CANCELLED"
end if

set AppleScript's text item delimiters to "|"
return picked as text
APPLESCRIPT
) || exit 1

[[ "$selection" == "CANCELLED" ]] && exit 0

headers=0
trim=0
remove_empty=0

[[ "$selection" == *"Add file headers"* ]] && headers=1
[[ "$selection" == *"Trim whitespace"* ]] && trim=1
[[ "$selection" == *"Remove empty lines"* ]] && remove_empty=1

# 3. Ask for output filename
name=$(osascript 2>/dev/null <<'APPLESCRIPT'
set dialogResult to display dialog ¬
    "Enter a name for the merged transcript:" ¬
    default answer "merged" ¬
    with title "Merge TXT Files" ¬
    buttons {"Cancel", "Merge"} ¬
    default button "Merge"

return text returned of dialogResult
APPLESCRIPT
) || exit 0

# Remove .txt extension if already entered
if [[ "${name:l}" == *.txt ]]; then
  name="${name[1,-5]}"
fi

# Validate filename
if [[ -z "$name" ||
      "$name" == *"/"* ||
      "$name" == *":"* ||
      "$name" == "." ||
      "$name" == ".." ]]; then
  osascript -e 'display alert "Invalid output filename."'
  exit 1
fi

# 4. Save next to the first selected file
folder="${1:h}"
output="$folder/$name.txt"

# Avoid overwriting existing files
counter=2
while [[ -e "$output" ]]; do
  output="$folder/$name-$counter.txt"
  ((counter++))
done

# 5. Merge in the received selection order
for file in "$@"; do

  # Add lecture filename header
  if (( headers )); then
    printf '===== %s =====\n\n' "${file:t}" >> "$output"
  fi

  # Process transcript
  awk -v trim="$trim" -v drop="$remove_empty" '
  {
    # Normalize Windows line endings
    sub(/\r$/, "")

    # Trim whitespace if enabled
    if (trim == 1) {
      gsub(/^[ \t]+|[ \t]+$/, "", $0)
    }

    # Remove empty lines if enabled
    if (drop == 1 && $0 ~ /^[ \t]*$/) {
      next
    }

    print
  }
  ' "$file" >> "$output"

  # Separate transcripts
  printf '\n\n' >> "$output"

done

# 6. Reveal merged file in Finder
open -R "$output"

exit 0
