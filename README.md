
# [Hidalgo] FabSim3 and MUSCLE3 tutorial webinar


## For Ubuntu based machines
Two different approaches are provided to install pre-requirement softwares and packages in your system. In first approach, you can install all dependencies in your local machine and then follow all instructions during the tutorial, or used the second approach which provides a docker image with pre-installed packages

### Solution 1: install all packages and software in your local Ubuntu based PC
- make sure you have python > 3.0 installed in your system
	```sh
	$ python --version
	Python 3.x
	```
	If you have python3 but it is not default, you can make it default by following instruction from [this link](https://unix.stackexchange.com/questions/410579/change-the-python3-default-version-in-ubuntu)
- Install openssh server
	```sh
	$ sudo apt-get install openssh-client openssh-server
	```
- Install MPi
	```sh
	$ sudo apt-get install -y openmpi-bin
	```
- You ONLY need to install [ruamel.yaml](https://pypi.org/project/ruamel.yaml) package, others will be installed by FabSim3. To install that python package, simply type
	```sh
	$ pip3 install ruamel.yaml
	```
- Additionally, for parallel FLEE, you need to install mpi4py package too
	```sh
	$ pip3 install mpi4py
	```
- Create a folder anywhere on your local machine. Let’s name it `HiDALGO_tutorial`
	```sh
	$ mkdir HiDALGO_tutorial
	```
- Go to `HiDALGO_tutorial` folder and clone FabSim3 from the GitHub repository
	```sh
	$ cd HiDALGO_tutorial
	[HiDALGO_tutorial]$ git clone https://github.com/djgroen/FabSim3.git
	[HiDALGO_tutorial]$ git clone https://github.com/djgroen/flee.git
	```
- To install all packages automatically and configure yml files, please go to your FabSim3 directory, and type
	```sh
	[HiDALGO_tutorial]$ cd FabSim3
	[HiDALGO_tutorial/FabSim3]$ python3 configure_fabsim.py
	``` 
- You can test the installation, by installing FabDummy plugin and test a dummy test
	```sh
	[HiDALGO_tutorial/FabSim3]$ fabsim localhost install_plugin:FabDummy
	[HiDALGO_tutorial/FabSim3]$ fabsim localhost dummy:dummy_test	
	``` 


### <a name="docker"></a>Solution 2: Using pre-configured Docker image
Make sure you have Docker installed on your PC. To install it, you can follow the instruction form : [https://docs.docker.com/engine/install/ubuntu](https://docs.docker.com/engine/install/ubuntu/)

- Create a folder anywhere on your local machine. Let’s name it `HiDALGO_tutorial`
	```sh
	$ mkdir HiDALGO_tutorial
	``` 
- Go to `HiDALGO_tutorial` folder and clone FabSim3 from the GitHub repository
	```sh
	$ cd HiDALGO_tutorial
	[HiDALGO_tutorial]$ git clone https://github.com/djgroen/FabSim3.git
	[HiDALGO_tutorial]$ git clone https://github.com/djgroen/flee.git
	```
- Config yml files
	* Goto `HiDALGO_tutorial/FabSim3/deploy` folder
	* make a copy of `machines_user_example.yml` file, and name it `machines_user.yml`
	* Replace localhost entry
		```yaml
		localhost:  
			username: "your-username"
		```
		with
		```yaml
		localhost:  
			local_results: "/FabSim3/results"
			local_configs: "/FabSim3/config_files"
			username: "root"
			flee_location: "/flee"
			home_path_template: "/FabSim3/localhost_exe"
			run_command: "mpirun --allow-run-as-root -np $cores"
		```
- To download the Docker image, you can use:
	```sh
	[HiDALGO_tutorial] $ docker pull ha3546/hidalgo_fabsim3_tutorial_webinar
	```
- Create a new file, named `hidalgo_fabsim3_tutorial.sh`, and fill is by
	```bash
		#!/bin/bash
		
		docker run --rm \  
		-v $PWD/flee:/flee \  
		-v $PWD/FabSim3:/FabSim3 \  
		-e USER=$USER -e USERID=$UID --hostname HiDALGO \  
		-ti ha3546/hidalgo_fabsim3_tutorial_webinar
	```
- Make that file executable
	```sh
	[HiDALGO_tutorial] $ chmod +x hidalgo_fabsim3_tutorial.sh
	```
- Now, you should be able to log-in to the docker image by
	```sh
	[HiDALGO_tutorial] $ ./hidalgo_fabsim3_tutorial.sh
	[HiDALGO FabSim3 tutorial] /FabSim3 $
	```
- You can test the installation, by installing FabDummy plugin and test a dummy test
	```sh
	[HiDALGO FabSim3 tutorial] /FabSim3 $ fabsim localhost install_plugin:FabDummy
	[HiDALGO FabSim3 tutorial] /FabSim3 $ fabsim localhost dummy:dummy_test	
	``` 



## For MacOSX based machines
Two different approaches are provided to install pre-requirement softwares and packages in your system. In first approach, you can install all dependencies in your local machine and then follow all instructions during the tutorial, or used the second approach which provides a docker image with pre-installed packages

### Solution 1: install all packages and software in your local MacOSX based machines
- make sure yomakeu have python > 3.0 installed in your system
	```sh
	$ python --version
	Python 3.x
	```
	If you have python3, but it is not default, on your system, please make it default python. For example, you can follow instructions from [this link](https://selenium-qa.com/2020/02/08/how-to-set-python3-as-default-on-your-macos/), or do a search on the internet :)
- Enable SSH login on macOS
	* OS X comes with sshd, you only need to enable it in System Preferences, under Sharing by clicking on Remote Login:

<center><img src="https://uca.edu/it/files/2017/10/remote_login.png" width="375" height="300"></center>


- Download and Install MPI on your Mac : [https://www.open-mpi.org/](https://www.open-mpi.org/)
- Create a folder anywhere on your local machine. Let’s name it `HiDALGO_tutorial`
	```sh
	$ mkdir HiDALGO_tutorial
	``` 
- You ONLY need to install [ruamel.yaml](https://pypi.org/project/ruamel.yaml) package, others will be installed by FabSim3. To install that python package, simply type
	```sh
	$ pip3 install ruamel.yaml
	```
- Additionally, for parallel FLEE, you need to install mpi4py package too
	```sh
	$ pip3 install mpi4py
	```
- Create a folder anywhere on your local machine. Let’s name it `HiDALGO_tutorial`
	```sh
	$ mkdir HiDALGO_tutorial
	```
- Go to `HiDALGO_tutorial` folder and clone FabSim3 from the GitHub repository
	```sh
	$ cd HiDALGO_tutorial
	[HiDALGO_tutorial]$ git clone https://github.com/djgroen/FabSim3.git
	[HiDALGO_tutorial]$ git clone https://github.com/djgroen/flee.git
	```
- To install all packages automatically and configure yml files, please go to your FabSim3 directory, and type
	```sh
	[HiDALGO_tutorial]$ cd FabSim3
	[HiDALGO_tutorial/FabSim3]$ python3 configure_fabsim.py
	``` 
- You can test the installation, by installing FabDummy plugin and test a dummy test
	```sh
	[HiDALGO_tutorial/FabSim3]$ fabsim localhost install_plugin:FabDummy
	[HiDALGO_tutorial/FabSim3]$ fabsim localhost dummy:dummy_test	
	``` 

### Solution 2: Using pre-configured Docker image
Make sure you have Docker installed on Mac machine. To install it, you can follow the institution form this website : [https://docs.docker.com/docker-for-mac/install/](https://docs.docker.com/docker-for-mac/install/)
 -   The rest of the configuration is the same as Ubuntu machines. Please follow instructions provided in [Solution 2 for Ubuntu machines](#docker)

## For Windows based machines
The suggested approach is installing Ubuntu in a VirtualBox VM. and follow the Ubuntu based machine instructions
