CC = g++

default:
	$(CC) Example.cpp src/Agent.cpp src/LineObstacle.cpp src/lq2D.cpp src/SimulationEngine.cpp -o src/Example -I src/util/ -I src/proximitydatabase/ -I src/

example:
	./src/Example
