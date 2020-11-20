from Powerlaw import PySimulationEngine
import numpy as np

# Create the engine with a size of 50x50, time step of 0.005,
# and max of 5000 frames
engine = PySimulationEngine(50, 50, 0.005, 5000)

# Set up the default parameters
k = 1.5
ksi = 0.54
m = 2
t0 = 3
neighbordist = 10
maxacc = 20
radius = 0.5
goalradius = 0.5
prefspeed = 1.4

# Set the starting and ending positions
positions = [(10, 10), (10, 5), (1, 7.5)]
goals = [(1, 10), (1, 5), (10, 7.5)]

# Add all agents to the simulation
for position, goal in zip(positions, goals):
    engine.addAgent(
        position,
        goal,
        (0, 0),
        radius,
        prefspeed,
        maxacc,
        goalradius,
        neighbordist,
        k,
        ksi,
        m,
        t0,
    )

# Add an Obstacle through the middle
engine.addObstacle((0, 5), (5, 5))

# Loop the simulation
while not engine.endSimulation():
    engine.updateVisualisation()
    engine.updateSimulation()
