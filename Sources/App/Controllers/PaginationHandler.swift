//
//  PagenationHandler.swift
//
//  Created by Yu-Sung Loyi Hsu on 27/08/2021.
//

import Foundation

class PaginationHandler {
    let sheets = GetGoogleSheets(rawUrl: csvUrl)
    let timer: DispatchSourceTimer
    let itemCount = 24
    var bookcount = 0

    var pages = [String]()

    init() {
        self.timer = DispatchSource.makeTimerSource()
        self.startTimer()
        if let sheets = sheets {
            pages = processrResults(books: sheets.fetch())
        }

    }

    func startTimer() {
        timer.setEventHandler() {
            self.doTimerJob()
        }

        timer.schedule(deadline: .now() + .seconds(5), repeating: .seconds(5*60), leeway: .seconds(10))
        if #available(OSX 10.14.3,  *) {
            timer.activate()
        }
    }

    func doTimerJob() {
        if let sheets = sheets {
            pages = processrResults(books: sheets.fetch())
        }
        print("Updated: \(Date())")
    }

    func processrResults(books: [Book]) -> [String] {
        var temp = "" , idx = 0, output = [String]()
        bookcount = books.count
        for book in books {
            var str = "<div class=\"card\">\n<div class=\"card-body\">"
            str += "<h4 class=\"card-title\">" + book.title + "</h4>"
            str += "<p class=\"card-text\">" + book.author + "</p>"
            str += "</div></div>"
            temp += str

            if (idx + 1) % itemCount == 0 {
                output.append(temp)
                temp = ""
            }

            idx += 1
        }
        return output
    }
}
