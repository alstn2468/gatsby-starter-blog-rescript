@react.component
let make = (
  ~title: string,
  ~selectedCategory: string,
  ~onClick: string => unit,
  ~scrollToCenter: React.ref<Js.Nullable.t<'a>> => unit,
) => {
  let liElement = React.useRef(Js.Nullable.null)

  let handleClick = (_: ReactEvent.Mouse.t) => {
    scrollToCenter(liElement)
    onClick(title)
  }

  React.useEffect2(() => {
    if selectedCategory === title {
      scrollToCenter(liElement)
    }

    None
  }, (selectedCategory, liElement))

  <li
    ref={ReactDOM.Ref.domRef(liElement)}
    className="category-item"
    role="tab"
    ariaSelected={selectedCategory === title}>
    <div onClick={handleClick}> {React.string(title)} </div>
  </li>
}

let defulat = make
