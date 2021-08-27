//
//  GetGoogleSheets.swift
//
//  Created by Yu-Sung Loyi Hsu on 27/08/2021.
//

import Foundation
import SwiftCSV

class GetGoogleSheets {
    let url: URL

    init? (rawUrl: String) {
        guard let url = URL(string: rawUrl) else {
            return nil
        }
        self.url = url
    }

    public func fetch() -> [Book] {
        guard let result = try? CSV(url: url) else { return [] }
        let rows = result.namedRows
        var output = [Book]()
        for row in rows {
            if let title = row["書名"], let author = row["作者"] {
                output.append(Book(title: title, author: author))
            }
        }
        return output.sorted(by: {
            $0.author == $1.author ? $0.title < $1.title : $0.author < $1.author
        })
    }
}
