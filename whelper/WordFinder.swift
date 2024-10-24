//
//  WordFinder.swift
//  whelper
//
// The WordFinder struct is initialized with the contents of the dictionary of words to match the template supplied
// by the user. The dictionary is stored in the array wordList. It contains isMatch and findMatches methods to compare
// the words in the dictionary against the template, returning a list of words that match the template.
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
    let solutionsList: [String]
    let ignoreCase: Bool
    
    init(wordListPath: String, solutionsPath: String, ignoreCase: Bool) throws {
        var pathName = (wordListPath as NSString).expandingTildeInPath //convert wordListPath to an NSString so I can use .expandingTildeInPath
        var wordListContent = try String(contentsOfFile: pathName)
        wordList = wordListContent.components(separatedBy: .newlines)
        pathName = (solutionsPath as NSString).expandingTildeInPath
        wordListContent = try String(contentsOfFile: pathName)
        solutionsList = wordListContent.components(separatedBy: .newlines)
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

    // findMatches first filters the wordlist for any words matching the template, excluding letters we've eliminated
    // using isMatch. Then it filters out any known solutions from previous puzzles.
    // The resulting list are possible solutions that haven't previously solved Wordle.
    
        func findMatches(for template: String, exclude: String) -> [String] {
            let allMatches = wordList.filter { candidate in
                isMatch(template: caseCorrected(template), with: caseCorrected(candidate), exclude: caseCorrected(exclude))
            }
            return allMatches.filter { !solutionsList.contains($0)}
//        return wordList.filter { candidate in
//            isMatch(template: caseCorrected(template), with: caseCorrected(candidate), exclude: caseCorrected(exclude))
//        }
    }
}
