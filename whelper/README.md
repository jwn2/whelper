#  whelper
MacOS command-line utility to suggest solutions to a Wordle puzzle.

whelper searches its dictionary of possible wordle solutions to a template supplied by the user.
The template is a pattern of letters where a dot '.' represents any character. See sample invocations
below. whelper has several options for its use,
{
% whelper -h
}
or
{
whelper --help
}
describe the options and how to use them.
## Installation
whelper is built with Xcode for MacOS. To build it,
1. Clone the project
2. Build it with the Xcode build command
3. Open the Build Products folder in the Finder
4. Copy {Products/Release/whelper} to {~/bin/}
5. Copy wordle-La.txt to {~/bin/}
6. Create an alias in {.zshrc}:
    {whelper='~/bin/whelper'}

## Sample invocations

    % whelper .east    
    Found 4 matches.
    beast
    feast
    least
    yeast


{
% whelper .east -e bl
Found 2 matches.
feast
yeast
}

{
% whelper ..... -c 5
Found 2324 matches; printing first 5
aback
abase
abate
abbey
abbot
}
