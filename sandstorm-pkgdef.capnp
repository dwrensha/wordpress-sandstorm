@0xaecd42915acc793f;

using Spk = import "/sandstorm/package.capnp";

const pkgdef :Spk.PackageDefinition = (
  id = "aax9j672p6z8n7nyupzvj2nmumeqd4upa0f7mgu8gprwmy53x04h",

  manifest = (
    appTitle = (defaultText = "WordPress"),
    appVersion = 10,
    appMarketingVersion = (defaultText = "2016.06.07 (4.4.2)"),

    metadata = (
      icons = (
        appGrid = (svg = embed "app-graphics/wordpress-128.svg"),
        grain = (svg = embed "app-graphics/wordpress-24.svg"),
        market = (svg = embed "app-graphics/wordpress-150.svg"),
       ),
       website = "https://wordpress.org/",
       codeUrl = "https://github.com/dwrensha/wordpress-sandstorm",
       license = (openSource = gpl2),
       categories = [webPublishing,],
       author = (
         upstreamAuthor = "WordPress Project",
         contactEmail = "david@sandstorm.io",
         pgpSignature = embed "pgp-signature",
       ),
       pgpKeyring = embed "pgp-keyring",
       description = (defaultText = embed "description.md"),
       shortDescription = (defaultText = "Content management"),
       screenshots = [(width = 448, height = 346, png = embed "screenshot1.png"),
                      (width = 448, height = 348, png = embed "screenshot2.png")],
       changeLog = (defaultText = embed "changeLog.md"),
     ),



    actions = [
      ( title = (defaultText = "New site"),
        nounPhrase = (defaultText = "site"),
        command = .startCommand
      )
    ],

    continueCommand = .continueCommand
  ),

  sourceMap = (
    searchPath = [
      ( sourcePath = "."),  # Search this directory first.
      ( sourcePath = "/",    # Then search the system root directory.
        hidePaths = [ "home", "proc", "sys",
                      "etc/nsswitch.conf", "etc/localtime",
                      "etc/host.conf", "etc/resolv.conf"]
      )
    ]
  ),

  fileList = "sandstorm-files.list",

  alwaysInclude = ["wordpress-read-only", "read-only-plugins"],

  bridgeConfig = (
    viewInfo = (
      permissions = [(name = "admin", title = (defaultText = "admin"),
                      description = (defaultText = "allows administrative actions")),
                     (name = "editor", title = (defaultText = "editor"),
                      description = (defaultText = "allows publishing of posts of others")),
                     (name = "author", title = (defaultText = "author"),
                      description = (defaultText = "allows publishing of own posts")),
                     (name = "contributor", title = (defaultText = "contributor"),
                      description = (defaultText = "allows writing of posts")),
                     (name = "subscriber", title = (defaultText = "subscriber"),
                      description = (defaultText = "allows profile customization"))],
      roles = [(title = (defaultText = "admin"),
                permissions = [true, true, true, true, true],
                verbPhrase = (defaultText = "can do anything")),
               (title = (defaultText = "editor"),
                permissions = [false, true, true, true, true],
                verbPhrase = (defaultText = "can publish posts of others")),
               (title = (defaultText = "author"),
                permissions = [false, false, true, true, true],
                verbPhrase = (defaultText = "can publish own posts")),
               (title = (defaultText = "contributor"),
                permissions = [false, false, false, true, true],
                verbPhrase = (defaultText = "can write posts"),
                default = true),
                (title = (defaultText = "subscriber"),
                permissions = [false, false, false, false, true],
                verbPhrase = (defaultText = "can customize profile"))]
    )
  )
);

const startCommand :Spk.Manifest.Command = (
  # Here we define the command used to start up your server.
  argv = ["/sandstorm-http-bridge", "10000", "--", "/start.sh"],
  environ = [
    # Note that this defines the *entire* environment seen by your app.
    (key = "PATH", value = "/usr/local/bin:/usr/bin:/bin")
  ]
);

const continueCommand :Spk.Manifest.Command = (
  argv = ["/sandstorm-http-bridge", "10000", "--", "/continue.sh"],
  environ = [
    (key = "PATH", value = "/usr/local/bin:/usr/bin:/bin")
  ]
);
