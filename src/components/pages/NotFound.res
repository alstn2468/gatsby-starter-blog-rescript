@react.component
let make = () => {
  <div>
    <h1> {React.string("404 Not Found")} </h1>
    <p> {React.string("You just hit a route that doesn't exist... the sadness.")} </p>
  </div>
}

@genType let default = make
