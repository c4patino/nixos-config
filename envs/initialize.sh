#!/usr/bin/env bash
#SBATCH --job-name=devshell-init
#SBATCH --output=/mnt/syncthing/shared/devshell-init_%A_%a.out
#SBATCH --error=/mnt/syncthing/shared/devshell-init_%A_%a.err
#SBATCH --partition=extended
#SBATCH --exclusive

non_cuda_shells=(
    "c-dev"
    "cpp-dev"
	"csharp-dev"
    "go-dev"
    "java-dev"
    "js-dev"
    "lua-dev"
    "nix-dev"
    "python311-dev"
    "python312-dev"
	"racket-dev"
    "rust-dev"
	"zig-dev"
)

cuda_shells=(
    "rust-cuda-dev"
    "python311-cuda-dev"
	"python312-cuda-dev"
)

# Function to check if CUDA is available
check_cuda() {
    if command -v nvidia-smi &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Initialize devshells based on CUDA availability
initialize_shells() {
    if check_cuda; then
        echo "CUDA is available. Initializing CUDA-compatible and non-CUDA-compatible shells."
        shells_to_initialize=("${non_cuda_shells[@]}" "${cuda_shells[@]}")
    else
        echo "CUDA is not available. Initializing only non-CUDA-compatible shells."
        shells_to_initialize=("${non_cuda_shells[@]}")
    fi

    # Initialize each shell and exit immediately afterward
    for shell_name in "${shells_to_initialize[@]}"; do
        echo "Pre-installing packages in $shell_name..."
        nom develop ~/dotfiles#"$shell_name" --command "true"
    done
}

# Run the initialization
initialize_shells

