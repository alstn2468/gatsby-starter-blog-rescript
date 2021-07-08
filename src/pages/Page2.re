[@react.component]
let make = () => {
  <div>
    <h1>{ReasonReact.string("Hi from the second page")}</h1>
    <p>{ReasonReact.string("Welcome to page 2")}</p>
    <Gatsby.Link _to="/">{ReasonReact.string("Go back to the homepage")}</Gatsby.Link>
  </div>
};

let default = make
