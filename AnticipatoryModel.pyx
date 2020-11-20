cdef extern from "util/Vector2D.h" namespace "TTC":
    cdef cppclass Vector2D:
        Vector2D()
        Vector2D(float x, float y)

cdef extern from "Agent.cpp":
    pass
cdef extern from "Agent.h" namespace "TTC":
    cdef cppclass Agent:
        Agent()
        init(Vector2D position, Vector2D goal, Vector2D vel, float radius, float prefspeed, float maxacc, float goalradius, float neighbordist, float k, float ksi, float m, float t0)

cdef extern from "SimulationEngine.cpp":
    pass

cdef extern from "SimulationEngine.h" namespace "TTC":
    cdef cppclass SimulationEngine:
        SimulationEngine()
        init(float xRange, float yRange)
        updateSimulation()
        endSimulation()
        updateVisualization()
        addAgent()

cdef class PySimulationEngine:
    cdef SimulationEngine *thisptr

    def __cinit(self):
        self.thisptr = new SimulationEngine()

    def addAgent(self, tuple pos, tuple goal, tuple vel,
                 float radius, float prefSpeed,
                 float maxAccel, float goalRadius,
                 float neighborDist, float k,
                 float m, float t0):
        cdef Agent to_add = Agent()
        to_add.init(Vector2D(0, 0), Vector2D(0, 0), Vector2D(0, 0), 0, 0, 0, 0, 0, 0, 0, 0, 0)
