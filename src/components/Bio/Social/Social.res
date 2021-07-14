@react.component
let make = (
  ~social: Js.Nullable.t<SiteMetadataBio.SiteMetadataBioQuery.Raw.t_site_siteMetadata_social>,
) => {
  <p className="author-socials">
    {switch Js.Nullable.toOption(social) {
    | Some(social) => <>
        <GithubLink githubId={social.github} />
        <InstagramLink instagramId={social.instagram} />
        <LinkedInLink linkedInId={social.linkedIn} />
        <FacebookLink facebookId={social.facebook} />
      </>
    | None => React.null
    }}
  </p>
}

let default = make
