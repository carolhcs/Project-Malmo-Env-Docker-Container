
# Project Malmo Docker Environments

This is a compilation of ready-made Project Malmo environments to run on Docker, in addition to presenting the development of our own environment.

## Official environments

[Project Malmo](https://github.com/Microsoft/malmo)

[Using the prebuilt Docker image](https://github.com/Microsoft/malmo/blob/master/scripts/python-wheel/README.md#using-the-prebuilt-docker-image)

[Malmo Challenge](https://github.com/microsoft/malmo-challenge/tree/master)

[Malmo Challenge Docker](https://github.com/Microsoft/malmo-challenge/tree/master/docker)

### Limitations of the official docker environment

- Fixed test environments aimed at using computer vision
- Only supports python which would require a RESTful interface for communication, or translating the project to python

## Non-official environments

[**minecraft-rl-on-ray-cluster**](https://github.com/tsmatz/minecraft-rl-on-ray-cluster/blob/master/Readme.md)

Integration of Project MalmO with Ray (a framework for distributed computing). It shows how to configure and run distributed reinforcement learning algorithms on a Ray cluster using Minecraft as a simulation environment.

This project is written in Python and includes detailed instructions on how to set up the environment, install dependencies, and run training scripts. There is no explicit support for Java.

[Image on docker hub](https://hub.docker.com/r/tsmatz/malmo-maze)

[**Docker Container for Microsoft/Malmo by tnarik**](https://hub.docker.com/r/tnarik/malmo)

This environment seems closer to the original, I couldn't identify if it allows the use of Java, because in its files I didn't see anything related to installing Java, only python.

[**andkram/malmo_build_headless_0_35_6**](https://hub.docker.com/r/andkram/malmo_build_headless_0_35_6)

This is a version of Project Malmo configured to run in headless mode, that is, without a graphical interface, which is useful for running on servers or distributed computing environments. This image is primarily aimed at Python, but perhaps can be reconfigured to include Java support, although this may require additional adjustments to the Dockerfile.

## Developing environment
### Malmo Java Libraries for Ubuntu
https://github.com/carolhcs/malmo-java-libs-ubuntu
https://github.com/Microsoft/malmo

### Java Kernel for Jupyter Notebook
In order to run our Java experiments on the Malmo project using Docker, we are trying the approach using the Jupyter notebook that is in the official Malmo project image. But to be able to use Java on Jupyter it is necessary to configure a Java kernel.

[**IJava**](https://github.com/SpencerPark/IJava)

[**Jupyter for Java Assets**](https://github.com/jupyter-java)

**Videos Guides and Tutorials:**

[A better Jupyter Experience for Java Developers - JTaccuino unveiled by Jose Pereda, Sven Reimers](https://www.youtube.com/watch?v=SMD5g0Fqn34&t=23s)

[Java in Jupyter Notebooks -- Part 1: Introduction to Java Programming in Jupyter Notebook](https://www.youtube.com/watch?v=UKT6t9R5RHA)

[13 A Jupyter kernel for executing Java code - Introduction to Google Colab for Research](https://www.youtube.com/watch?v=nOoXZlHmF5o&t=29s)


## Result
<details>
<summary> Result Run </summary>

I find a functional and official Docker Image with VNC [here](https://github.com/Microsoft/malmo/blob/master/scripts/python-wheel/README.md#using-the-prebuilt-docker-image)

![image](https://github.com/carolhcs/Project-Malmo-Env-Docker-Container/assets/14095834/03d6c11b-c8aa-455b-a48f-e2feed59f26c)

![image](https://github.com/carolhcs/Project-Malmo-Env-Docker-Container/assets/14095834/ac253aa2-75a4-4f88-8b04-03a0aebf82a1)


</details>

### Try Ubuntu container with noVNC

[**u1ih**](https://hub.docker.com/r/u1ih/ubuntu-novnc)

[**u1ih - github**](https://github.com/u1i/ubuntu-novnc)

[**abhishekranaa**](https://hub.docker.com/r/abhishekranaa/ubuntu-novnc-docker)

![image](https://github.com/user-attachments/assets/f0f15fe4-8c8c-42a1-bd1c-667a0b0c6c5b)


[**accetto**](https://hub.docker.com/r/accetto/xubuntu-vnc-novnc)


