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
    appVersion = 2,
    appMarketingVersion = (defaultText = "0.0.2"),

    actions = [
      # Define your "new document" handlers here.
      ( title = (defaultText = "New WordPress Site"),
        command = .startCommand
      )
    ],

    continueCommand = .continueCommand
  ),

  sourceMap = (
    # Here we defined where to look for files to copy into your package. The
    # `spk dev` command actually figures out what files your app needs
    # automatically by running it on a FUSE filesystem. So, the mappings
    # here are only to tell it where to find files that the app wants.
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
  # `spk dev` will write a list of all the files your app uses to this file.
  # You should review it later, before shipping your app.

  alwaysInclude = ["wordpress-read-only"],

  bridgeConfig = (
    viewInfo = (
      permissions = [(name = "admin", title = (defaultText = "admin")),
                     (name = "editor", title = (defaultText = "editor")),
                     (name = "author", title = (defaultText = "author")),
                     (name = "contributor", title = (defaultText = "contributor")),
                     (name = "subscriber", title = (defaultText = "subscriber"))],
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
                verbPhrase = (defaultText = "can read"))]
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
