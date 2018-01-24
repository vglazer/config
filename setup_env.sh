echo "Installing Anaconda..."
bash $HOME/Downloads/Anaconda3-5.0.1-MacOSX-x86_64.sh

echo "Installing TensorFlow..."
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.3.0-py3-none-any.whl

echo "Installing Keras..."
pip install keras

echo "Installing Gym..."
cd $HOME/repos
git clone https://github.com/openai/gym.git
cd gym
pip install -e .

echo "Installing Baselines..."
git clone https://github.com/openai/baselines.git
cd baselines
pip install -e .

echo "Installing OpenCV..."
pip install opencv-python

echo "Installing Box2D..."
cd $HOME/repos
git clone https://github.com/pybox2d/pybox2d pybox2d_dev
cd pybox2d_dev
python setup.py build
python setup.py install
python setup.py develop

echo "Installing pybullet..."
pip install pybullet

echo "Installing Bullet SDK..."
cd $HOME/repos
git clone https://github.com/bulletphysics/bullet3.git
cd bullet3
./build_cmake_pybullet_double.sh
cd build_cmake
make

echo "Installing PyTorch..."
pip install http://download.pytorch.org/whl/torch-0.2.0.post3-cp36-cp36m-macosx_10_7_x86_64.whl
pip install torchvision

