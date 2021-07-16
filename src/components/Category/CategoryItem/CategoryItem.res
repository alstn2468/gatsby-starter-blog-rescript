@react.component
let make = (
  ~title: string,
  ~selectedCategory: string,
  ~onClick: string => unit,
  ~scrollToCenter: React.ref<Js.Nullable.t<'a>> => unit,
) => {
  let liElementRef = React.useRef(Js.Nullable.null)

  let handleClick = (_: ReactEvent.Mouse.t) => {
    onClick(title)
  }

  React.useEffect2(() => {
    if selectedCategory === title {
      scrollToCenter(liElementRef)
    }

    None
  }, (selectedCategory, liElementRef))

  <li
    ref={ReactDOM.Ref.domRef(liElementRef)}
    className="category-item"
    role="tab"
    ariaSelected={selectedCategory === title}>
    <div onClick={handleClick}> {React.string(title)} </div>
  </li>
}

let defulat = make
