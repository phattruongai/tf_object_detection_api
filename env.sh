echo "Start jupyter server"
docker run -it --gpus all --rm -p 8888:8888 -v $PWD:/home/tensorflow/serve tf:2.7.0-gpu-od jupyter notebook --no-browser --ip 0.0.0.0