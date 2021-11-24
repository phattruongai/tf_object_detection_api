docker build -t tf:2.7.0-gpu-od .
echo "Start test runs"
docker run -it --rm --gpus all tf:2.7.0-gpu-od python ../models/research/object_detection/builders/model_builder_tf2_test.py
echo "Finish test!"