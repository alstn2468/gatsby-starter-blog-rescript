[@react.component]
let make = () => {
  <div>
    <h1>{ReasonReact.string("404 Not Found")}</h1>
    <p>{ReasonReact.string("You just hit a route that doesn't exist... the sadness.")}</p>
  </div>
};

let default = make
