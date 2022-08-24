run:
	docker run --gpus=all -v ~/.huggingface/token:/root/.huggingface/token:ro -w /work -v $(CURDIR):/work yowatari/stable-diffusion python run.py

build:
	docker build -t yowatari/stable-diffusion .

shell:
	docker run -it --gpus=all -v ~/.huggingface/token:/root/.huggingface/token:ro -w /work -v $(CURDIR):/work yowatari/stable-diffusion
