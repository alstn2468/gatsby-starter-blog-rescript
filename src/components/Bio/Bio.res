%%raw("import './index.scss'")

module Author = {
  @react.component
  let make = (~author: Js.Nullable.t<string>) => {
    switch Js.Nullable.toOption(author) {
    | Some(author) =>
      <div className="author-name-content"> <span> {React.string(`@${author}`)} </span> </div>
    | None => React.null
    }
  }
  let default = make
}

module Introduction = {
  @react.component
  let make = (~introduction: Js.Nullable.t<string>) => {
    switch Js.Nullable.toOption(introduction) {
    | Some(introduction) =>
      <div className="author-introduction"> {React.string(introduction)} </div>
    | None => React.null
    }
  }
}

@react.component
let make = () => {
  let siteMetadataBio = SiteMetadataBio.useSiteMetadataBio()
  <div className="bio">
    <div className="author">
      <div className="author-description">
        <img className="author-image" />
        <div className="author-name">
          <span className="author-name-prefix"> {React.string("Written by")} </span>
          <Author author={siteMetadataBio.author} />
          <Introduction introduction={siteMetadataBio.introduction} />
          {switch Js.Nullable.toOption(siteMetadataBio.social) {
          | Some(social) => <p className="author-socials">
              <GithubLink githubId={social.github} />
              <InstagramLink instagramId={social.instagram} />
              <LinkedInLink linkedInId={social.twitter} />
              <FacebookLink facebookId={social.facebook} />
            </p>
          | None => React.null
          }}
        </div>
      </div>
    </div>
  </div>
}

let default = make
