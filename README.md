# Moolist-Vapor

This website is a list of books I bought from Readmoo, a Taiwanese ebook seller.

This was made with Meteor & get-sheet-done. However, the dependency breaks recently. Therefore, I rewrite the app in Vapor.

This app uses Google Forms & Google Sheets as a backend database. The middleware gets the published CSV, parses the file, and keeps a copy, which will get updated periodically. It will also be paginated and accessed through URL patterns.
