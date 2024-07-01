import clingo
import networkx as nx
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
from networkx.drawing.nx_agraph import write_dot, graphviz_layout


def create_structure_graph(num_models=1):
    """Use the Clingo to create the structure graph."""

    graphs = []

    def on_model(model):
        graph_data = []
        for atom in model.symbols(shown=True):
            if atom.name == "edge" and len(atom.arguments) == 2:
                graph_data.append((str(atom.arguments[0]), str(atom.arguments[1])))
        graphs.append(graph_data)

    control = clingo.Control()
    control.load("clingo/structure_graph.lp")
    control.ground([("base", [])])
    control.configuration.solve.models = str(num_models)
    control.solve(on_model=on_model)

    print("Clingo Output:\n", control.statistics)  # This will print Clingo statistics

    return graphs[0]


def generate_dot(graph_data):
    G = nx.DiGraph()
    for edge in graph_data:
        start = 'S' if edge[0] == 'start' else edge[0]
        end = f'E{edge[1][-2]}' if edge[1].startswith('end') else edge[1]
        G.add_edge(start, end)

    write_dot(G, "output/graph.dot")
    pos = graphviz_layout(G, prog='dot')
    nx.draw(G, pos, with_labels=True, arrows=True, node_color='white', edgecolors='black', node_size=450)
    plt.savefig("output/graph.png")
    plt.show()


def main():
    graph_data = create_structure_graph()
    generate_dot(graph_data)


if __name__ == "__main__":
    main()
