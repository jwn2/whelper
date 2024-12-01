#  whelper
MacOS command-line utility to suggest solutions to a Wordle puzzle.

whelper compares its dictionary of possible wordle solutions against a template supplied by the user.
The template is a pattern of letters where a dot '.' represents any character. After finding possible
solutions, whelper compares that list to a dictionary of past solutions, eliminating words that have already
solved Worlde. As far as I know, the New York Times doesn't repeat solutions. See sample invocations
below. The utility has several options for its use,

    % whelper -h

or

    whelper --help

describe the options and how to use them.
## Installation
whelper is built with Xcode for MacOS. To build it,
1. Clone the project
2. Build it with the Xcode build command
3. Open the Build Products folder in the Finder
4. Copy 'Products/Release/whelper' to '~/bin/'
5. Copy wordle-La.txt to '~/bin/'
6. Copy wordle-Sa.txt to '~/bin/'
7. Create an alias in '.zshrc':
    "whelper='~/bin/whelper'"

## Sample invocations

    % whelper .east    
    Found 4 matches.
    beast
    feast
    least
    yeast

    % whelper .east --exclude bl
    Found 2 matches.
    feast
    yeast

    % whelper ..... -c 5 -e a
    Found 1407 matches; printing first 5
    beech
    beefy
    befit
    beget
    begin

## Possible improvements
1. A MVC redesign with a Swift UI view.
2. Keep of list of past solutions and eliminate them from the list returned.
   
## Acknowledgements
Thanks to Mikey Ward, author of *Swift Programming: The Big Nerd Ranch Guide*. whelper is based on
wordlasso from his book. Thanks to Garrett Sholtes who published a [wordle dictionary](https://gist.github.com/scholtes/94f3c0303ba6a7768b47583aff36654d). It
 is the basis for whelper's possible solutions dictionary. Thanks to the folks at [RockPaperShotgun](https://rockpapershotgun.com) who daily update the list of
 past solutions.
 
