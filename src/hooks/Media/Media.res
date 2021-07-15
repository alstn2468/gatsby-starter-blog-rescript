type t
type mediaQueryList = {matches: bool, media: string}

let getMatchMediaArray = (queries: array<string>): array<mediaQueryList> => {
  queries->Js.Array2.map(Global.window["matchMedia"])
}

let useMedia = (queries: array<string>, values: array<'a>, defaultValue: 'a): 'a => {
  let mediaQueryLists = queries->getMatchMediaArray
  let getMatches = (mediaQueryList: mediaQueryList) => mediaQueryList.matches
  try {
    values[mediaQueryLists->Js.Array2.findIndex(getMatches)]
  } catch {
  | _ => defaultValue
  }
}
