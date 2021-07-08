@react.component
let make = () => {
  <div>
    <h1> {React.string("Hi from the second page")} </h1>
    <p> {React.string("Welcome to page 2")} </p>
    <Gatsby.Link _to="/"> {React.string("Go back to the homepage")} </Gatsby.Link>
  </div>
}

@genType let default = make
