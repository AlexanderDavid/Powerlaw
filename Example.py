from Powerlaw import PySimulationEngine
import numpy as np

# Create the engine with a size of 50x50, time step of 0.005,
# and max of 5000 frames
engine = PySimulationEngine(50, 50, 0.033, 6000)

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

# Store all the agent numbers
agent_nums = []

# Add all agents to the simulation
for position, goal in zip(positions, goals):
    agent_nums.append(
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
                t0))


# Add an Obstacle through the middle
# engine.addObstacle((0, 5), (5, 5))


# Loop the simulation
i = 0
while not engine.endSimulation():
    # Calculatate goal velocity
    for agent, goal in zip(agent_nums, goals):
        np_goal = np.array(goal)
        np_pos = np.array(engine.getAgentPosition(agent))
        goal_vec = np_goal - np_pos
        if np.linalg.norm(goal_vec) > prefspeed:
            goal_vec = (goal_vec / np.linalg.norm(goal_vec)) * prefspeed

        # Set the agents goal velocity
        engine.setAgentPrefVelocity(agent_nums[-1], tuple(goal_vec))

    engine.updateVisualisation()
    engine.updateSimulation()
    i += 1



print("Final Positions")
# Report the location of all agents
for agent_num in agent_nums:
    print(f"{agent_num}: {engine.getAgentPosition(agent_num)}")
