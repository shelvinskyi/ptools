#!/usr/bin/env bash
cd $HOME/dev/outloud-orderflow/
conda activate orderflow
pytest
flake8 .
read -p "        ...cool cool cool"
