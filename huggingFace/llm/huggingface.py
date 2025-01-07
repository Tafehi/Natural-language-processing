from pathlib import Path

import torch
from transformers import Pipeline, pipeline
from sagemaker_huggingface_inference_toolkit import transformers_utils, serving




def _get_pipeline(task: str, device: int, model_dir: Path, **kwargs) -> Pipeline:
    return pipeline(model=model_dir, device_map="auto", model_kwargs={"torch_dtype": torch.bfloat16})

transformers_utils.get_pipeline = _get_pipeline


if __name__ == "__main__":
    serving.main()