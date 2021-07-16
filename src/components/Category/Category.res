%%raw("import './index.scss'")

@react.component
let make = (
  ~categories: array<string>,
  ~selectedCategory: string,
  ~selectCategory: string => unit,
) => {
  let ulElementRef = React.useRef(Js.Nullable.null)

  let renderCategoryItem = (title: string) => {
    <CategoryItem
      key={`category-${title}`} title selectedCategory onClick={selectCategory}
    />
  }

  <ul
    ref={ReactDOM.Ref.domRef(ulElementRef)}
    className="category-container"
    role="tablist"
    id="category">
    <CategoryItem title={"All"} onClick={selectCategory} selectedCategory />
    {categories->Js.Array2.map(renderCategoryItem)->React.array}
  </ul>
}

let default = make
