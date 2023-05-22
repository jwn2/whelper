//
//  WordFinder.swift
//  wordlasso
//
//  Created by John W. Noerenberg II on 12/28/22.
//

import Foundation

struct WordFinder {
    static let wildcard: Character = "."
    let wordList: [String]
    let ignoreCase: Bool
    
    init(wordListPath: String, ignoreCase: Bool) throws {
        let wordListContent = try String(contentsOfFile: wordListPath)
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
