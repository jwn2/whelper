//
//  main.swift
//  whelper - wordle helper
//  whelper searches a dictionary of words for that match a wordle guess plus wildcard characters.
//  whelper takes a single argument, a template. It has 4 options: ignore-case, dictionary, count
//  and exclude. The template is a string consisting of letters or a wildcard character (.). For
//  example: ".ras." has two wildcard characters, one each at the beginning and end, and "ras"
//  in the center 3 characters.
//  The options:
//  ignore-case - matches are case-insensitive
//  dictionary - path name of a dictionary, one word per line. The default dictionary is the list
//  of words considered to be wordle solutions
//  count <n> - print only the first <n> matches. Reports total if more than <n> exist.
//  exclude  <excludeList> - <excludeList> won't match wildcard matches.
//  A sample invocation:
//  whelper .ras. -i -e s
//  will return words from the dictionary that begin and end with any letter except "s",
//  ignoring case
//
//  Created by John W. Noerenberg II on 5/21/23.
//
//  whelper borrows liberally from the wordlasso program from Chapter 27 of Mikey Ward's book,
//  Swift Programming: The Big Nerd Ranch Guide. My thanks to Mikey for an excellent text.

import Foundation
import ArgumentParser
struct WordleHelper: ParsableCommand {
    // -h --help
    @Argument (help:"""
Search pattern to match. \"\(WordFinder.wildcard)\"'s in pattern match any character not in the exclude list. <ret> for interactive mode
""")
    var template: String?           // the search pattern to match

    // -i --ignore-case
    @Flag (name: .shortAndLong, help: "for case-insensitive matching.")
    var ignoreCase: Bool  = false   // assume case matters
    
    // --dictionary
    @Option(name: .customLong("dictionary"),
            help: """
Path name for user-specified dictionary.
Dictionary is newline separated list of words.
""")
    var wordListPath = "~/bin/wordle-La.txt"
    
    // -c --count <n>
    // prints first <n> matches. If more match, also prints the total number of matches
    @Option(name: .shortAndLong, help: "print no more than <n> matches.")
    var count: Int = 0  // default is to print them all.
    
    // -e --exclude <excludeList>
    // <excludeList> is a string of letters disallowed from wildcard matches.
    // It defaults to a <sp>. No words can contain spaces. We don't want the string to be
    // empty. But we want a non-empty string to compare. A space will allow wildcards to
    // match on any letter. See the isMatch method for details.
    @Option( name: .shortAndLong, help: "Wildcard letters will not match any letters to the exclude option.")
    var exclude = " "       // default to an non-empty string containing a <sp> character
    
        
    mutating func run() throws {
        let wordFinder = try WordFinder(wordListPath: wordListPath, ignoreCase: ignoreCase)
        let args = CommandLine.arguments
        if let template = template {
            getAndPrint(for: template, using: wordFinder, limit:count, exclude: exclude)
        } else {
            while true {
                print ("Search pattern", terminator: ": ")
                template = readLine() ?? ""
                if template == nil {
                    fatalError("How can pattern be nil here? Unexpected exit.")
                } else {
                    if template!.isEmpty {return}
                    getAndPrint(for: template!, using: wordFinder, limit: count, exclude: exclude)
                }
            }
        }
    }
}

private func getAndPrint(for template: String, using wordFinder: WordFinder, limit: Int, exclude: String) {
    
}

WordleHelper.main()
