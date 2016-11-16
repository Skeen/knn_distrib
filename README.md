# KNN-DTW distributed computation

The project distributes the heavy workload of computing knn-dtw onto multiple machines.

## Setup
### Server node
Run a single instance of the server;
```
server/index.js
```
In a centralized location, the server stores jobfiles and distributes workloads.

### Compute node
And multiple computation instances;
```
compute/index.js
```
Each of which will increase the computational power of the cloud.
They work by executing `./clf.run` on the provided datasets.

## Usage
Usage is simple, just invoke `./request.sh` with the appropriate parameters.
