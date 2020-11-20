/*
 *  Example.cpp
 *
 *
 *  All rights are retained by the authors and the University of Minnesota.
 *  Please contact sjguy@cs.umn.edu for licensing inquiries.
 *
 *  Authors: Ioannis Karamouzas, Brian Skinner, and Stephen J. Guy
 *  Contact: ioannis@cs.umn.edu
 */

/*!
 *  @file       Example.cpp
 *  @brief      An example of how to use this library.
 */
#include "SimulationEngine.h"
#include "Vector2D.h"
#include <iomanip>
#include <iostream>

/* #include "conio.h" */
using namespace TTC;

SimulationEngine *_engine = 0;

void destroy() {
  delete _engine;
  _engine = 0x0;
}

void setupScenario() {

  // initialize the engine, given the dimensions of the environment
  _engine->init(50, 50);

  // Specify the default parameters for agents that are subsequently added.
  AgentInitialParameters par;

  par.k = 1.5f;
  par.ksi = 0.54f;
  par.m = 2.0f;
  par.t0 = 3.f;
  par.neighborDist = 10.f;
  par.maxAccel = 20.f;
  par.radius = 0.5f;
  par.prefSpeed = 1.4f;
  par.goalRadius = 0.5f;

  // Add two agents vs 1 agent
  par.position = Vector2D(10, 10);
  par.goal = Vector2D(1, 10);
  par.velocity = Vector2D();

  _engine->addAgent(par);

  par.position = Vector2D(10, 5);
  par.goal = Vector2D(1, 5);
  par.velocity = Vector2D();

  _engine->addAgent(par);

  par.position = Vector2D(1, 7.5);
  par.goal = Vector2D(10, 7.5);
  par.velocity = Vector2D();

  _engine->addAgent(par);

  // Add an obstacle through the middle
  _engine->addObstacle(std::make_pair(Vector2D(0, 5), Vector2D(5, 5)));
}

int main(int argc, char **argv) {
  // default parameters
  int numFrames = 5000;
  float dt = 0.005f;

  // load the engine
  _engine = new SimulationEngine();
  _engine->setTimeStep(dt);
  _engine->setMaxSteps(numFrames);

  // setup the scenario
  setupScenario();

  // Run the scenario
  do {
    _engine->updateVisualisation();
    _engine->updateSimulation();
  } while (!_engine->endSimulation());

  // destroy the environment
  destroy();

  return 0;
}
