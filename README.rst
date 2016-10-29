============
oaktreemodel
============

oaktree is a gRPC interface for interacting with OpenStack clouds that is
inherently interoperable and multi-cloud aware.

oaktreemodel is the protobuf definitions and the libraries and/or code
generated from that to make it possible for people of all languages to
interact with the gRPC system without developing a python dependency anywhere.

At start, go, C++ and python are supported.

With go, the generated files are checked in to the git repo, because that's
how go dependencies work.

With C++ and python, they are not, as we exepct the unit of consumption to
be a built library and header files for C++ or a PyPI package for Ruby. It's
the most likely that as we add structure for more languages that they will
follow the C++/Python approach and not the go approach - but the decision
will be made on a per-language basis and reported back here.

Note on API compat
------------------

tl;dr - Upgrading oaktree should NEVER negatively impact end users.

Until a 1.0.0 release is cut, please consider that literally everything in
this repo can change with no notice or consideration of breaking backwards
compat. This is a new approach to several things and it's entirely likely
we're going to get things wrong a few times.

Post 1.0.0 oaktree and oaktreemodel will be held to the same backwards-compat
promises as shade itself. That is - there will never be backwards-compat
breaking release, and it should _always_ be safe to deploy the latest release
in production. In fact, even for people running older stable releases of
OpenStack, the recommendation will be to run the latest oaktree, so that the
latest cross-compatibility changes can be picked up.

Note on Implementations
-----------------------

It is absolutely the intent of oaktreemodel that multiple implementations
based on the protobuf descriptions exist for the client interaction. In fact,
the code generated and published from this repo is fairly low-leve on a gRPC
basis, so it's almost certainly the case that each language will want to
consume this code in the context of some other library that has an end-user
focused UI.

It is absolutely NOT the intent that multiple implementations of the server
side exist.

The reason for that is that, at least as of now, the business logic in the
shade library is extensive and complex. It handles a million corner cases in
the underlying clouds. oaktree servers should all be able to talk not just
to the cloud they are deployed with, but also to other OpenStack clouds
either talking to the remote oaktree or directly to the remote OpenStack API.

The client interfaces in gRPC should be considered to be comprehensive and
as descriptive of the interface as possible. For people wanting an oaktree
server, please use actual oaktree.

Building
--------

First you need some dependencies:

.. code-block:: bash

  pip install bindep
  apt-get install $(bindep -b)
  pip install -f requirements.txt
  pip install grpcio-tools
  go get -u github.com/golang/protobuf/protoc-gen-go

Then you can build the code:

.. code-block:: bash

  autoreconf -fi
  ./configure
  make

* Source: http://git.openstack.org/cgit/openstack/oaktreemodel
* Bugs: http://storyboard.openstack.org
