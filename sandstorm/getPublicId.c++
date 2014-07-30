// Sandstorm - Personal Cloud Sandbox
// Copyright (c) 2014 Sandstorm Development Group, Inc. and contributors
//

// Hack around stdlib bug with C++14.
#include <initializer_list> // force libstdc++ to include its config
#undef _GLIBCXX_HAVE_GETS // correct broken config
// End hack.

#include <kj/main.h>
#include <kj/debug.h>
#include <kj/async-io.h>
#include <kj/async-unix.h>
#include <kj/io.h>
#include <capnp/rpc-twoparty.h>
#include <capnp/rpc.capnp.h>
#include <capnp/ez-rpc.h>
#include <unistd.h>

#include <sandstorm/hack-session.capnp.h>

namespace sandstorm {

  class GetPublicIdMain {
  public:
    GetPublicIdMain(kj::ProcessContext& context): context(context) { }

    kj::MainFunc getMain() {
      return kj::MainBuilder(context, "GetPublicId version: 0.0.1",
                           "Runs the getPublicId command from hack-session.capnp. "
                             "Returns the ID and the host name as two lines on stdout.")
        .callAfterParsing(KJ_BIND_METHOD(*this, run))
        .build();
    }

    kj::MainBuilder::Validity run() {

      capnp::EzRpcClient client("unix:/tmp/sandstorm-api");
      HackSessionContext::Client session = client.importCap<HackSessionContext>("HackSessionContext");

      auto result = session.getPublicIdRequest().send().wait(client.getWaitScope());
      auto publicId = result.getPublicId();
      auto hostname = result.getHostname();
      auto autoUrl = result.getAutoUrl();
      auto isDemoUser = result.getIsDemoUser();
      kj::String msg = kj::str(publicId, "\n", hostname, "\n", autoUrl, "\n",
                               isDemoUser ? "true" : "false", "\n");
      kj::FdOutputStream(STDOUT_FILENO).write(msg.begin(), msg.size());

      return true;
    }

  private:
    kj::ProcessContext& context;
  };

} // namespace sandstorm

KJ_MAIN(sandstorm::GetPublicIdMain)

