
The Matlab file implementation of the proposed Boolean factor graph 
network model for biological sytems.

The source codes are available freely and can be distributed and modified 
for research and academic purposes.

Data

cellcycle.csv: gene-expression data for the 11 genes in the network. Data obtained from 
  Many Microbe Microarrays Database [reference 47]. Rows represents the observations and colums the gene
  nodes in the following order: Cln3, MBF, SBF, Cln1,2, Cdh1, Swi5, Cdc20, Clb5, Sic1, Clb2, Mcm1.

attractor_data.csv: simulation data obtained from global attractor identification in a 
  10-node random networks. 
 -Column 1 represents the average node connectivity.
 -Column 2 denotes the total number of attractors identified.

nEdges_complx_data.csv : simulation data obtained from global attractor identification in a 
  10-node random networks to evaluate the computation cost
  data obtained from the matlab file computation_cost.m
 -Column 1 represents the total number of edges in a network.
 -Column 2 denotes the total number of attractors identified.
 -Column 3 denotes the time to search the global attractors in seconds

Main Files

cellcycle.m 
- Is a main file for searching the global attractor of the network by 
  employing our propose Boolean factor graph model.
- This file is used as well to implement the network consistency. Identify 
  global attractors from real gene-expression data

geneKO_analysis.m
- Is a main file for implementing gene deletion simulations. 
- Nodes in the sample network (Li et al.) are given node ID as follows:
  	1=Cln3, 2=MBF, 3=SBF, 4=Cln1,2, 5=Cdh1, 6=Swi5, 7=Cdc20, 
 	8=Clb5, 9=Sic1, 10=Clb2, 11=Mcm1
- Use the numerical numbers to select a node for deletion. 
- Multiple nodes can be deleted as follow: Example in deletine nodes 2 and 4
   >> 2 4

GMM_fit_test.m
- Is a main file for implementing fit test of the gene-expression data to 2 mixtures of Gaussaian

computation_cost.m
- Is a main file to evaluate the model complexity in identifying network attractors.