@val external window: 'a = "window"

@val external document: 'a = "document"

@val @scope("document")
external body: 'a = "body"

@val @scope(("document", "documentElement"))
external offsetHeight: int = "offsetHeight"

@val @scope(("window", "location"))
external search: 'a = "search"

@val @scope(("window", "location"))
external pathname: string = "pathname"

@val @scope("window")
external scrollY: int = "scrollY"

@val @scope("window")
external scroll: 'a => unit = "scroll"

@val @scope("window")
external addEventListener: (string, 'a) => unit = "addEventListener"

@val @scope("window")
external removieEventListener: (string, 'a) => unit = "removieEventListener"

@val @scope(("window", "history"))
external historyPushState: ('a, string, string) => unit = "pushState"
