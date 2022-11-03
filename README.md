# PowerLaw

This is a python wrapper for the C++ implementation of the [[http://motion.cs.umn.edu/PowerLaw/][PowerLaw]] from the paper [[http://motion.cs.umn.edu/PowerLaw/KSG-PowerLaw.pdf][Universal Power Law Governing Pedestrian Interactions]]. It wraps the most basic functionality of the simulation.

## Installing
1. Clone the repository as a submodule into your project (`git submodule add git@github.com:AlexanderDavid/Powerlaw.git`)
2. Navigate to the Powerlaw directory (`cd Powerlaw`)
3. Execute the `setup.py` file to install the library (`python setup.py install`)
4. The powerlaw library is then installed under the alias `powerlaw`

## Example
The following example code simulates a singular agent starting in a hallway that blocks the straight line path to the hallway.

### Instantiate a Simulation Engine
The model revolves around a central engine (`PySimulationEngine`) that all agents and obstacles are a member of. The parameters of this engine are the x, and y size of the environment, the timestep, and the max number of frames. 

```python
from Powerlaw import PySimulationEngine

engine = PySimulationEngine(50, 50, 1 / 60., 50000)
```

### Add Agants to the model
Agents can be added to the model by explicitly specifying all information about the agent and parameters to be used in the underlying powerlaw equations. A more complex agent configuration is shown in `example.py`. 

```python
position = (0, 2.5)
goal = (10, 5)
velocity = (0.5, 0.5)
radius = 0.5
prefSpeed = 1.4
maxAcc = 20
goalRadius = 0.5
neighborDist = 10
k = 1.5
ksi = 0.54
m = 2
t0 = 3

agent = engine.addAgent(position, goal, velocity, radius, prefSpeed, maxAcc,
                goalRadius, neighborDist, k, ksi, m, t0)
```

### Query Agent State
Each agent's state can be queried through the simulation object using the agent's id returned by the `addAgent` function. Right now the getters implemented are radius, preferred velocity, current position, and current velocity.

```python
engine.getAgentPosition(agent) # (0, 2.5)
engine.getAgentPrefVelocity(agent) # (0.5, 0.5)
engine.getAgentRadius(agent) # 0.5
engine.getAgentVelocity(agent)
```

### Add obstacles to the model
The simulation also supports static obstacles defined by a line segment of two points. A more complex shape can be defined through stringing these line segments together.

```python
engine.addObstacle((0, 1.75), (5, 1.75))
engine.addObstacle((0, 3.25), (5, 3.25))
```

### Start the simulation
The simulation will continue execution so long as the simulation has not exceeded maximum frames and there are still agents who have not reached their goals[^1]. The `updateVisualisation` function prints information about the current status to `stdout`. For brevity only the first and last 2 lines of the simulation are included. As you can see from the simulation the agent progresses along the hallway until the exit and then straight to the goal.

```python
while not engine.endSimulation():
    engine.updateVisualisation()
    engine.updateSimulation()
```
```
Time: 0
0: (0,2.5)
Time: 0.005
0: (0.00251792,2.502)
.
.
.
Time: 7.69013
0: (9.55188,4.7643)
Time: 7.69513
0: (9.55809,4.76754)
```

[^1]: This simulation only stops when max frames are exceeded because of the `while not engine.endSimulation()` condition. The simulation will keep running after max frames are exceeded if the update functions are called again. 