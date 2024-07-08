import clingo


def run_clingo_file(input_file: str, answer_set_number):
    """Use the Clingo to create the structure graph."""
    models = []

    def on_model(model):
        atoms = []
        for atom in model.symbols(shown=True):
            atoms.append(atom)
        models.append(atoms)

    control = clingo.Control()
    control.load(f"clingo/{input_file}")
    control.ground([("base", [])])
    control.configuration.solve.models = str(answer_set_number)
    control.solve(on_model=on_model)

    return models[-1]


def write_output_file(output_file: str, atoms: list, atoms_names_to_write: set[str]):
    with open(f"clingo/{output_file}", "w") as file:
        for atom in atoms:
            if atom.name in atoms_names_to_write:
                args = ', '.join(str(a) for a in atom.arguments)
                file.write(f"{atom.name}({args}).\n")


def main(input_file: str, output_file: str, atoms_names_to_write: set[str], answer_set_number=1):
    atoms = run_clingo_file(input_file, answer_set_number)
    write_output_file(output_file, atoms, atoms_names_to_write)


if __name__ == "__main__":
    atoms_names_to_write = {'start_state'}
    main('start_states.lp', 'static_start_states.lp', atoms_names_to_write)
