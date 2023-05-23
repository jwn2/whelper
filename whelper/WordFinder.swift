//
//  WordFinder.swift
//  whelper
//
// The WordFinder struct is initialized with the contents of the dictionary of words to match the template supplied
// by the user. It contains isMatch and findMatches methods to compare the words in the dictionary against the template,
// returning a list of words that match the template.
// findMatches gets the template and the exclusion list as arguments and uses isMatch to filter the list of words in the
// the dictionary against them.
//
// caseCorrected deals with the ignore-case flag if the user invokes it.
//
//  Created by John W. Noerenberg II on 5/21/2023.
//

import Foundation

struct WordFinder {
    static let wildcard: Character = "."
    let wordList: [String]
    let ignoreCase: Bool
    
    init(wordListPath: String, ignoreCase: Bool) throws {
        let pathName = (wordListPath as NSString).expandingTildeInPath
        //convert wordListPath to an NSString so I can use .expandingTildeInPath
        let wordListContent = try String(contentsOfFile: pathName)
        wordList = wordListContent.components(separatedBy: .newlines)
        self.ignoreCase = ignoreCase
    }

    private func caseCorrected(_ value: String) -> String {
        ignoreCase ? value.lowercased() : value
    }
 
    //isMatch returns true if each character in the word argument matches the corresponding
    //character in the template argument, For wildcards in the template, the corresponding character in
    //word must not be on the exclusion list.
    //the predicate for .allSatisfy is where the match testing takes place.
    //isMatch is used as the filtering closure argument to .filter in findMatches
    private func isMatch(template: String, with word: String, exclude: String) -> Bool {
        guard template.count == word.count else { return false }
        
        // exclude is the string parsed as the arg to the -e option or a string containing a <sp> if no -e option is given
        // on the command line.
        return template.indices.allSatisfy {
            index in (template[index] == word[index] ||
                (template[index] == WordFinder.wildcard && !exclude.contains(word[index]))
                     )
        }
    }

    //findMatches runs wordList.filter with isMatch as the filter criterion for the
    //filtering operation.
        func findMatches(for template: String, exclude: String) -> [String] {
        return wordList.filter { candidate in
            isMatch(template: caseCorrected(template), with: caseCorrected(candidate), exclude: caseCorrected(exclude))
        }
    }
}
