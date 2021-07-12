@react.component
let make = (~title: string, ~description, ~url) => {
  <>
    <GatsbySEO.Helemt
      title={title}
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
            url: Js.String.concat("/og.png", url),
            width: 1200,
            height: 630,
            alt: title,
          },
        ],
        title: title,
        site_name: title,
        url: url,
        locale: "ko_kr",
      }}
      language="ko"
      canonical={url}
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
