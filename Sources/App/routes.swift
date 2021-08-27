import Vapor

let pagination = PaginationHandler()

func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<View> in
        if !pagination.pages.isEmpty {
            return req.view.render("showdata", ["title": "Readmoo 書單", "data": pagination.pages[0],
                                                "pageidx": "1", "pagecount": "\(pagination.pages.count)",
                                                "nextlink": "/pages/2", "bookcount": "\(pagination.bookcount)"])
        }
        return req.view.render("notfound", ["title": "Readmoo 書單"])
    }

    app.get("pages", ":id") { req -> EventLoopFuture<View> in
        if !pagination.pages.isEmpty {
            if let id = Int(req.parameters.get("id") ?? "1") {
                if id > 0 && id < pagination.pages.count + 1 {
                    var previousLink: String?
                    if id > 1 {
                        if id == 2 {
                            previousLink = "/"
                        } else {
                            previousLink = "/pages/\(id-1)"
                        }
                    }
                    var nextLink: String?
                    if id < pagination.pages.count {
                        nextLink = "/pages/\(id+1)"
                    }

                    return req.view.render("showdata", ["title": "Readmoo 書單", "data": pagination.pages[id - 1],
                                                        "pageidx": "\(id)", "pagecount": "\(pagination.pages.count)",
                                                        "previouslink": previousLink, "nextlink": nextLink,
                                                        "bookcount": "\(pagination.bookcount)"])
                }
            }
        }
        return req.view.render("outofbound", ["title": "Readmoo 書單"])
    }
}

