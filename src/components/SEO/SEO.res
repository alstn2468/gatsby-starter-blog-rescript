@react.component
let make = (~title: string, ~description: string) => {
  let siteMetadata = SiteMetadata.useSiteMetadata()
  <>
    <GatsbySEO.Helemt
      title={title}
      titleTemplate={`%s | ${siteMetadata.title}`}
      metaTags={[
        {
          name: "description",
          content: description,
        },
      ]}
      openGraph={{
        _type: "website",
        images: [
          {
            url: Js.String.concat("/og.png", siteMetadata.siteUrl),
            width: 1200,
            height: 630,
            alt: title,
          },
        ],
        title: title,
        site_name: title,
        url: siteMetadata.siteUrl,
        locale: "ko_kr",
      }}
      language="ko"
      canonical={siteMetadata.siteUrl}
    />
    <HelmetAsync.Helmet>
      <meta
        name="viewport"
        content={Js.Array.joinWith(
          ",",
          [
            "width=device-width",
            "initial-scale=1",
            "maximum-scale=1.0",
            "minimum-scale=1",
            "user-scalable=no",
          ],
        )}
      />
    </HelmetAsync.Helmet>
  </>
}

let default = make
