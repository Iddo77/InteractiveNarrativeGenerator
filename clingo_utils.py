import subprocess


def run_clingo_file(filename):
    """Run Clingo as a subprocess with the specified filename for validation."""
    file_path = f"clingo/{filename}"
    result = subprocess.run(
        ["clingo", "--verbose=2", file_path],
        capture_output=True,
        text=True
    )
    print("Clingo Output for Validation:\n", result.stdout)
    if result.stderr:
        print("Clingo Errors:\n", result.stderr)


if __name__ == "__main__":
    run_clingo_file('structure_graph.lp')
