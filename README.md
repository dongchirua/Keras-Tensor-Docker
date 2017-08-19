# Keras-Tensor-Docker
Facilitate Keras with Docker on MacOS

I modified the [source](https://github.com/fchollet/keras/tree/master/docker) to my purpose

usage: control `GPU` flag, unset or `0` will use `docker` instead

	$ make notebook GPU=0
	$ make ipython