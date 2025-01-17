# DevOps Project: Python API to AWS Kubernetes
This project walks you through building a Python API, containerizing it with Docker, and automating the CI/CD pipeline with GitHub Actions. You'll then provision infrastructure using Terraform on AWS, deploy the API on an EKS (Elastic Kubernetes Service) cluster, and set up monitoring with Prometheus and Grafana. This complete DevOps pipeline demonstrates key skills needed to land a job in DevOps and is a great addition to your portfolio.


## Python
```
python3 -m venv venv
source venv/bin/activate
python3 -m pip install -r requirements.txt
cd app
uvicorn main:app --host 0.0.0.0 --port 8080
```

## Docker
```
docker run -d --name devops-python -p 8080:80 devops-python
docker build -t devops-python .
```

Replace your github username in the github action variable [here](./.github/workflows/release.yaml)

### Required to Build
By default your action can't deploy to ghcr. Go to settings > actions > general > workflow permissions > Read and write permissions