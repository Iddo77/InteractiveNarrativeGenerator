# Interactive Narrative Generator Project

This project aims to create an interactive narrative generator using Clingo and Python. This initial setup guide will help you install the necessary dependencies and set up your development environment.

## Step 1: Install Miniconda

1. Download and install Miniconda from the official website: [Miniconda Download](https://docs.conda.io/en/latest/miniconda.html)
2. Follow the installation instructions for your operating system.

## Step 2: Create and Activate the `narrativegenerator` Environment

1. Open a terminal or Anaconda Prompt.
2. Create a new Conda environment named `narrativegenerator` and install the dependencies from `requirements.txt`:

    ```sh
    conda create -n narrativegenerator -c conda-forge --file requirements.txt
    ```

3. Activate the newly created environment:

    ```sh
    conda activate narrativegenerator
    ```

## Running the Script

1. Ensure you are in the `narrativegenerator` environment:

    ```sh
    conda activate narrativegenerator
    ```

2. Run the Python script:

    ```sh
    python generate_graph.py
    ```

This will execute the Clingo program, generate the DOT file and PNG image of the graph, and save them in the `output` directory.
