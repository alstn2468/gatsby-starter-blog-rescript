%%raw("import './index.scss'")

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
          | Some(social) =>
            <p className="author-socials">
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
