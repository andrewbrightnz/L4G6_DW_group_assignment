all: run_pipeline

run_pipeline:
	Rscript main.R

clean:
	powershell -Command "Remove-Item -Recurse -Force -ErrorAction SilentlyContinue data/intermediate/*, data/processed/*, output/figures/*, output/database/*"
	