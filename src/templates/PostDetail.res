type pageContext = { slug: string }

@react.component
let make = (~data as rawData, ~pageContext: pageContext) => {
  Js.log(rawData);
  Js.log(pageContext);

  <div>
    <h1> {React.string("Detail Page")} </h1>
  </div>
}

@genType let default = make
