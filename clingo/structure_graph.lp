% input: number of end vertices and choice vertices
#const num_end_vertices = 8.
#const num_choice_vertices = 32.

start_vertex(start).
choice_vertex(C) :- C = 1..num_choice_vertices.
end_vertex(E) :- E = num_choice_vertices+1..num_choice_vertices+num_end_vertices.
% achieved: the correct number of vertices is created based on the input

vertex(V) :- start_vertex(V).
vertex(V) :- choice_vertex(V).
vertex(V) :- end_vertex(V).
% achieved: the 3 vertex types are subtypes of vertex

{edge(start, Y) : vertex(Y)} = 4 :- start_vertex(start).
:- edge(Y, start).
% achieved: the start vertex has 4 outgoing edges and no incoming edges

{edge(C, Y) : vertex(Y)} = 4 :- choice_vertex(C).
% achieved: each choice vertex has 4 outgoing edges

:- edge(E, _), end_vertex(E).
% achieved: end vertices have no outgoing edges

% Define reachability and ensure no cycles
path(X, Y) :- edge(X, Y).
path(X, Z) :- path(X, Y), edge(Y, Z).
:- path(X, Y), path(Y, X).
% achieved: path is defined and the graph has no cycles

:- vertex(Y), not path(start, Y), Y != start.
% achieved: every vertex is reachable from the start vertex

% Since there are no cycles, and every choice-vertex has 4 outgoing edges,
% and every end-vertex is reachable from the start,
% this implies that every choice-vertex reaches at least 1 end-vertex.

#show path/2.

#show edge/2.

