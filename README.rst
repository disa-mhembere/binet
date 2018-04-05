binet
=====

binet is a Deep Learning library for Python that was developed by
`Thomas Unterthiner <http://www.bioinf.jku.at/people/unterthiner/>`_
at the `Institute of Bioinformatics <http://www.bioinf.jku.at>`_
of the `Johannes Kepler University Linz <http://www.jku.at>`_.

binet can seamlessly and transparently switch between running on the CPU and
on the GPU, using PyCUDA and scikits-cuda. It supports dense as well as
sparse input data.

The library was written with the goal of easily experimenting with new
ideas regarding neural nets. While it is written with high performance
in mind, ease of extensibility and to internal net state was the main
stated design goal. As a result binet is fast, super flexible and yet also
a bit hackish :)


Examples
--------

A simple neural network on MNIST with 2 hidden layers::


    import os
    from binet import *

    op.init_gpu(0)   #  OPTIONAL: initializes first GPU in the system

    from binet.util import train
    dataset = load_dataset("mnist")

    n_inputs = dataset[0].shape[1]
    layers = (256, 256, dataset[1].shape[1])
    net = NeuralNet(n_inputs, layers, max_iter=10, learning_rate=0.1, verbose=True, \
        activation="relu", shuffle_data=False, dropout=0.5, \
        input_dropout=0.2)
    net = train(net, dataset, use_gpu=True, skip_output=1)



Installation
------------
binet requires:

* numpy
* scipy
* pandas
* cffi
* Cython
* h5py (optionally, for ``load_dataset``)
* PyCUDA
* scikits.cuda
* GNU Scientific Library

Docker
------

A quick way to setup binet without local installation is to use docker. We
provide a Dockerfile.

To build the image. From the root directory of the repo::

    docker build -t binet .

To run the container with example jupyter notebooks we forward port (8888) of
container to a host port (in this case 8888)::

     docker run -p 8888:8888 -it binet

To run the jupyter notebooks that are stored within the `examples` directory, use::

    jupyter notebook --ip=0.0.0.0 --no-browser


Citation
--------

If you use binet in a publication and found it useful, please cite

    T Unterthiner, A Mayr, G Klambauer, M Steijaert, J Wegner, H Ceulemans, S Hochreiter
    "Deep Learning as an Opportunity in Virtual Screening"
    Deep Learning and Representation Learning Workshop (NIPS 2014)




License
-------
binet is licensed under the
`General Public License (GPL) Version 2 or higher <http://www.gnu.org/licenses/gpl-2.0.html>`_.
See ``License.rst`` for the full, gory details.
