% input: number of end vertices and minimum and maximum path length
#const num_end_vertices = 5.
#const min_path_length = 5.
#const max_path_length = 10.
#const num_choice_vertices = (max_path_length + min_path_length) / 2 * 4.  % average path length * number of choices

start_vertex(start).
choice_vertex(C) :- C = 1..num_choice_vertices.
end_vertex(end(E)) :- E = 1..num_end_vertices.
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

in_degree(V, N) :- choice_vertex(V), N = #count{X : edge(X, V)}.
in_degree(V, N) :- end_vertex(V), N = #count{X : edge(X, V)}.
:- in_degree(V, N), N > 4.
% achieved: choice vertices have no more incoming edges than outgoing edges

:- edge(E, _), end_vertex(E).
% achieved: end vertices have no outgoing edges

path(X, Y, 1) :- edge(X, Y).
path(X, Z, N+1) :- path(X, Y, N), edge(Y, Z), N < max_path_length.
% achieved: path is defined, including length; paths have a maximum length

:- path(X, Y, _), path(Y, X, _).
% achieved: the graph has no cycles

:- vertex(Y), not path(start, Y, _), Y != start.
% achieved: every vertex is reachable from the start vertex

end_path_length(E, N) :- path(start, E, N), end_vertex(E).
:- end_path_length(E, N), N < min_path_length.
% achieved: paths from start to end have a minimum length

#show end_path_length/2.
#show vertex/1.
#show edge/2.