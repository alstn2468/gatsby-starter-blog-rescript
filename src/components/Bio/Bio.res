%%raw("import './index.scss'")

@react.component
let make = () => {
  let siteMetadataBio = SiteMetadataBio.useSiteMetadataBio()
  <section className="bio-container">
    <div className="bio">
      <ProfileImage author={siteMetadataBio.author} />
      <div className="author">
        <span className="author-name-prefix"> {React.string("Written by")} </span>
        <Author author={siteMetadataBio.author} />
        <Introduction introduction={siteMetadataBio.introduction} />
        <Social social={siteMetadataBio.social} />
      </div>
    </div>
  </section>
}

let default = make
