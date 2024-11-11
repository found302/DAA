#include<stdio.h>
#include<stdlib.h>

int path[20]; // Array to store the path for minimum cost tour
int n; // Variable to store number of cities

// Function to find minimum cost path recursively
int g(int k, int v[n], int c[n][n]);

// Function to trace and store the path of the minimum cost tour
void trvpath(int k, int v[n], int c[n][n], int j);

void main() {
    int mcost; // Variable to store minimum cost
    path[0] = 1; // Start from city 1 (assuming cities are numbered from 1 to n)

    // Input number of cities
    printf("Enter value of n:\n");
    scanf("%d", &n);

    int c[n][n]; // Adjacency matrix to store travel costs between cities
    int v[n]; // Visited array to keep track of visited cities
    int j = 1; // Index for path tracking

    // Initialize visited array to 0 (no city visited initially)
    for(int i = 1; i <= n; i++)
        v[i] = 0;

    path[n] = 1; // Set last city in the path to 1, ensuring the path returns to the start

    // Input adjacency matrix for the travel costs
    printf("Enter Array Elements:\n");
    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= n; j++) {
            scanf("%d", &c[i][j]);
        }
    }

    // Print the adjacency matrix for verification
    printf("Adjacency Matrix:\n");
    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= n; j++) {
            printf("%d\t", c[i][j]);
        }
        printf("\n");
    }

    v[1] = 1; // Mark starting city (city 1) as visited

    // Calculate minimum cost starting from city 1
    mcost = g(1, v, c);

    // Reset visited array to find path
    for(int i = 1; i <= n; i++)
        v[i] = 0;
    v[1] = 1; // Mark starting city as visited again

    // Trace and store the minimum cost path
    trvpath(1, v, c, j);

    // Print the minimum cost
    printf("Minimum cost is : %d\n", mcost);

    // Print the path for minimum cost
    printf("Path :");
    for(int i = 0; i <= n; i++)
        printf("%d-", path[i]);
}

// Recursive function to calculate minimum cost
int g(int k, int v[n], int c[n][n]) {
    int min, temp, flag = 0;
    min = 999; // Set a high initial value for minimum cost

    // Check if all cities have been visited
    for(int i = 2; i <= n; i++) {
        if(v[i] == 0) // If any city is not visited
            flag = 1;
    }

    // If all cities are visited, return the cost to go back to the start city
    if(flag == 0) {
        return c[k][1];
    }

    // Try visiting all unvisited cities from current city k
    for(int i = 2; i <= n; i++) {
        if(v[i] == 0) { // If city i is unvisited
            v[i] = 1; // Mark city i as visited
            temp = c[k][i] + g(i, v, c); // Calculate cost to visit city i and continue the tour
            if(temp < min) { // If calculated cost is less than current min
                min = temp; // Update minimum cost
            }
            v[i] = 0; // Backtrack: mark city i as unvisited
        }
    }

    return min; // Return the minimum cost for the path from city k
}

// Function to trace the path that gives the minimum cost tour
void trvpath(int k, int v[n], int c[n][n], int j) {
    int temp, min = 999, t;
    int v1[n]; // Temporary array to copy visited status

    // If we haven't completed the path (j < n)
    if(j < n) {
        for(int i = 2; i <= n; i++) {
            if(v[i] == 0) { // If city i is unvisited
                v[i] = 1; // Mark city i as visited
                temp = c[k][i] + g(i, v, c); // Calculate cost including city i
                if(temp < min) { // If new cost is lower than min
                    min = temp; // Update minimum cost
                    t = i; // Store city i as the next city in path
                    for(int m = 1; m <= n; m++) // Copy visited status to temporary array
                        v1[m] = v[m];
                }
                v[i] = 0; // Backtrack: mark city i as unvisited
            }
        }
        path[j] = t; // Store city t in the path
        trvpath(t, v1, c, j + 1); // Recur with the next city in the path
    }
}
