import Vapor

let sheets = GetGoogleSheets(rawUrl: csvUrl)

func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<View> in
        if let result = sheets, let items = processrResults(books: result.fetch()) {
            return req.view.render("showdata", ["title": "Readmoo 書單", "data": items])
        }
        return req.view.render("notfound", ["title": "Readmoo 書單"])
    }
}

let itemCount = 24

func processrResults(books: [Book]) -> String? {
    guard !books.isEmpty else { return nil }
    var output = "" //, idx = 0
    for book in books {
        var str = "<div class=\"card\">\n<div class=\"card-body\">"
        str += "<h4 class=\"card-title\">" + book.title + "</h4>"
        str += "<p class=\"card-text\">" + book.author + "</p>"
        str += "</div></div>"
        output += str
    }
    return output
}
