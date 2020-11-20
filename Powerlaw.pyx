from libcpp cimport bool

cdef extern from "util/Vector2D.h" namespace "TTC":
    cdef cppclass Vector2D:
        float getX()
        float getY()
        Vector2D()
        Vector2D(float x, float y)

cdef extern from "Agent.cpp":
    pass
cdef extern from "Agent.h" namespace "TTC":
    cdef cppclass Agent:
        Agent()
        init(Vector2D position, Vector2D goal, Vector2D vel, float radius, float prefspeed, float maxacc, float goalradius, float neighbordist, float k, float ksi, float m, float t0)
        Vector2D position()
        Vector2D velocity()
        void setPreferredVelocity(const Vector2D vPref)
        float radius()

cdef extern from "SimulationEngine.cpp":
    pass

cdef extern from "SimulationEngine.h" namespace "TTC":
    cdef cppclass SimulationEngine:
        SimulationEngine()
        void init(float xRange, float yRange)
        void setTimeStep(float dt)
        void setMaxSteps(float maxSteps)
        void updateSimulation()
        bool endSimulation()
        void updateVisualisation()
        Agent* getAgent(int id)
        void addAgent(Vector2D position, Vector2D goal, Vector2D velocity,
                float radius, float prefspeed, float maxacc, float goalradius,
                float neighbordist, float k, float ksi, float m, float t0)


cdef class PySimulationEngine:
    cdef SimulationEngine* thisptr

    def __cinit__(self, float xRange, float yRange, float dt, float maxSteps):
        self.thisptr = new SimulationEngine()
        self.thisptr.init(xRange, yRange)
        self.thisptr.setTimeStep(dt)
        self.thisptr.setMaxSteps(maxSteps)

    def addAgent(self, tuple pos, tuple goal, tuple vel,
                 float radius, float prefSpeed,
                 float maxAccel, float goalRadius,
                 float neighborDist, float k, float ksi,
                 float m, float t0):
        self.thisptr.addAgent(Vector2D(pos[0], pos[1]), Vector2D(goal[0], goal[1]),
                              Vector2D(vel[0], vel[1]), radius, prefSpeed,
                              maxAccel, goalRadius, neighborDist, k, ksi, m, t0)

    def setAgentPrefVelocity(self, tuple vel):
        self.thisptr.getAgent(id).setPreferredVelocity(Vector2D(vel[0], vel[1]))

    def getAgentPosition(self, int id):
        cdef Vector2D position = self.thisptr.getAgent(id).position()
        return position.getX(), position.getY()

    def getAgentVelocity(self, int id):
        cdef Vector2D velocity = self.thisptr.getAgent(id).velocity()
        return velocity.getX(), velocity.getY()

    def getAgentRadius(self, int id):
        cdef float radius = self.thisptr.getAgent(id).radius()
        return radius

    def updateSimulation(self):
        self.thisptr.updateSimulation()

    def updateVisualisation(self):
        self.thisptr.updateVisualisation()

    def endSimulation(self):
        return self.thisptr.endSimulation()
