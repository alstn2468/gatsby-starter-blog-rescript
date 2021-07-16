%%raw("import './index.scss'")

@react.component
let make = (
  ~categories: array<string>,
  ~selectedCategory: string,
  ~selectCategory: string => unit,
) => {
  let ulElementRef = React.useRef(Js.Nullable.null)
  let scrollToCenter = ulElementRef->Scroll.scrollToCenterWithContainerRef

  let renderCategoryItem = (title: string) => {
    <CategoryItem
      key={`category-${title}`} title scrollToCenter selectedCategory onClick={selectCategory}
    />
  }

  <ul
    ref={ReactDOM.Ref.domRef(ulElementRef)}
    className="category-container"
    role="tablist"
    id="category">
    <CategoryItem title={"All"} onClick={selectCategory} selectedCategory scrollToCenter />
    {categories->Js.Array2.map(renderCategoryItem)->React.array}
  </ul>
}

let default = make
