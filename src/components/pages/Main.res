@react.component
let make = () => {
  <div>
    <h1> {React.string("Hi people")} </h1>
    <p> {React.string("Welcome to your new Gatsby site.")} </p>
    <p> {React.string("Now go build something great.")} </p>
    <Gatsby.Link _to="/page-2/"> {React.string("Go to page 2")} </Gatsby.Link>
  </div>
}

@genType let default = make
