module Fragments = {
  %graphql(`
    fragment GatsbyImageSharpFixed on ImageSharpFixed {
      base64
      width
      height
      src
      srcSet
    }
  `)
}

type fixed

external gatsbyImageSharpFixed: Fragments.GatsbyImageSharpFixed.t => fixed = "%identity"

@module("gatsby-image") @react.component
external make: (
  ~fixed: Fragments.GatsbyImageSharpFixed.Raw.t=?,
  ~fluid: Js.Json.t=?,
  ~objectFit: string=?,
  ~objectPosition: string=?,
  ~alt: string=?,
  ~title: string=?,
  ~className: string=?,
  ~style: Js.Json.t=?,
  ~imgStyle: Js.Json.t=?,
  ~placeholderStyle: Js.Json.t=?,
  ~placeholderClassName: string=?,
  ~draggable: bool=?,
) => React.element = "default"
