[@react.component]
let make = () => {
  <div>
    <h1>{ReasonReact.string("Hi people")}</h1>
    <p>{ReasonReact.string("Welcome to your new Gatsby site.")}</p>
    <p>{ReasonReact.string("Now go build something great.")}</p>
    <Gatsby.Link _to="/Page2/">
      {ReasonReact.string("Go to page 2")}
    </Gatsby.Link>
  </div>
};

let default = make
