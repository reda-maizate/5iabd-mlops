FROM public.ecr.aws/lambda/python:3.8
WORKDIR ${LAMBDA_TASK_ROOT}

RUN yum update -y

RUN pip3 install --upgrade pip

COPY main.py main.py

CMD ["main.lambda_handler"]