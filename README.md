## Design an Integer Linear Programming-based Scheme for Scheduling and Floor Planner on Heterogeneous System on Chip (SoC)

* Developed an ILP-based task scheduling and allocation routine to minimize total latency and energy for a task graph given different types of hardware resources, bandwidth constraints, memory and communication cost.

* Developed an ILP-based placement routine for a SoC both mesh and flexible topology to minimize total communication energy given the ILP-based task schedule, allocation and floor planning constraints.


#### Supporting Objective Functions
* Scheduler: execution energy cost and total latency.
* Mesh Topology (Floor Planner): communication energy cost only.
* Flexible Topology (Floor Planner): communication energy cost & total area.

#### Supporting Two Topologies in Floor Planner
* Mesh Topology: one mesh point can be occupied by two hardware blocks.
* Flexible Topology: both hard blocks and soft blocks are supported.

### Prerequisites

* For both Python and MATLAB versions, CPLEX is required to be installed.
* See also the install guidance [CPLEX](https://www.ibm.com/support/knowledgecenter/SSSA5P_12.6.3/ilog.odms.studio.help/pdf/gscplexmatlab.pdf) from IBM

### Running the Tests
Several test cases are provided and results are shown in the folder named **Results**.
All input files in Python version are removed due to privacy while basic input files are kept in MATLAB version.

### Authors

* **Manqing Mao,** maomanqing@gmail.com

<!-- See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project. -->
