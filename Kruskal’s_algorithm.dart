import "dart:math";

class Edge {
  int src, dest, weight;

  Edge(this.src, this.dest, this.weight);
}

class Graph {
  int vertices;
  List<Edge> edges = [];

  Graph(this.vertices) {
    edges = [];
  }

  void addEdge(int src, int dest, int weight) {
    edges.add(Edge(src, dest, weight));
  }

  int find(List<int> parent, int i) {
    if (parent[i] != i) {
      parent[i] = find(parent, parent[i]); // Path compression
    }
    return parent[i];
  }

  void union(List<int> parent, List<int> rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);

    if (rootX != rootY) {
      if (rank[rootX] > rank[rootY]) {
        parent[rootY] = rootX;
      } else if (rank[rootX] < rank[rootY]) {
        parent[rootX] = rootY;
      } else {
        parent[rootY] = rootX;
        rank[rootX]++;
      }
    }
  }

  void kruskalMST() {
    List<Edge> result = []; // Stores the MST edges
    edges.sort((a, b) => a.weight.compareTo(b.weight)); // Sort edges by weight

    List<int> parent = List<int>.generate(vertices, (i) => i);
    List<int> rank = List<int>.filled(vertices, 0);

    int e = 0; // Number of edges in MST
    int i = 0; // Index variable for sorted edges

    while (e < vertices - 1 && i < edges.length) {
      Edge nextEdge = edges[i++];
      int x = find(parent, nextEdge.src);
      int y = find(parent, nextEdge.dest);

      if (x != y) {
        result.add(nextEdge);
        union(parent, rank, x, y);
        e++;
      }
    }

    print("Edges in MST:");
    for (Edge edge in result) {
      print("${edge.src} -- ${edge.dest} == ${edge.weight}");
    }
  }
}

void main() {
  Graph graph = Graph(4);
  graph.addEdge(0, 1, 10);
  graph.addEdge(0, 2, 6);
  graph.addEdge(0, 3, 5);
  graph.addEdge(1, 3, 15);
  graph.addEdge(2, 3, 4);

  graph.kruskalMST();
}
