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
be a built library and header files for C++ or a PyPI package for Python.
It's most likely that as we add structure for more languages that they will
follow the C++/Python approach and not the go approach.

.. toctree::
   :maxdepth: 2

   install/index
   user/index
   reference/index
   contributor/index

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
