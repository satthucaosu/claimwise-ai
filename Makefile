.PHONY: venv install test run-ui run-api format lint eval clean

venv:
	uv python pin 3.11
	uv venv

install:
	uv pip install -r requirements.txt

test:
	pytest

run-ui:
	streamlit run app/streamlit_app.py

run-api:
	uvicorn app.api:app --reload

format:
	ruff format .

lint:
	ruff check .

eval:
	python -m src.evaluation.run_ragas_eval

clean:
	python -c "import shutil, pathlib; [shutil.rmtree(p, ignore_errors=True) for p in pathlib.Path('.').rglob('__pycache__')]"
