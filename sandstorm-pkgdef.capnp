@0xaecd42915acc793f;

using Spk = import "/sandstorm/package.capnp";
# This imports:
#   $SANDSTORM_HOME/latest/usr/include/sandstorm/package.capnp
# Check out that file to see the full, documented package definition format.

const pkgdef :Spk.PackageDefinition = (
  # The package definition. Note that the spk tool looks specifically for the
  # "pkgdef" constant.

  id = "aax9j672p6z8n7nyupzvj2nmumeqd4upa0f7mgu8gprwmy53x04h",
  # Your app ID is actually its public key. The private key was placed in
  # your keyring. All updates must be signed with the same key.

  manifest = (
    appTitle = (defaultText = "WordPress"),
    appVersion = 4,
    appMarketingVersion = (defaultText = "2015.06.28--4.2.3-alpha"),

    actions = [
      ( title = (defaultText = "New WordPress Site"),
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
