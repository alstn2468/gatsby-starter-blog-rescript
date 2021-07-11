module Helmet = {
  @module("react-helmet-async") @react.component
  external make: (
    ~children: React.element,
  ) => React.element = "Helmet"
}
