



# major cloud providers and their most popular services.


| Cloud Provider                              | Popular Compute Services      | Storage                      | Database                             | Serverless                 | Networking / CDN           | Other Popular Services                          |
| ------------------------------------------- | ----------------------------- | ---------------------------- | ------------------------------------ | -------------------------- | -------------------------- | ----------------------------------------------- |
| Amazon Web Services (AWS)                   | EC2                           | S3                           | RDS, DynamoDB                        | Lambda                     | CloudFront, VPC            | IAM, API Gateway, ECS, EKS, CloudWatch          |
| Google Cloud Platform (GCP)                 | Compute Engine                | Cloud Storage                | Cloud SQL, Firestore, BigQuery       | Cloud Functions, Cloud Run | Cloud CDN                  | IAM, Pub/Sub, GKE, Vertex AI                    |
| Microsoft Azure                             | Virtual Machines              | Blob Storage                 | Azure SQL Database, Cosmos DB        | Azure Functions            | Azure CDN, Virtual Network | Azure AD (Entra ID), Logic Apps, AKS            |
| Cloudflare                                  | Workers                       | R2 Object Storage            | D1                                   | Workers                    | CDN, DNS                   | Pages, Durable Objects, Zero Trust, Tunnel, WAF |
| Oracle Cloud Infrastructure (OCI)           | Compute Instances             | Object Storage               | Oracle Database, Autonomous Database | OCI Functions              | Load Balancer              | Identity, Container Engine, API Gateway         |
| IBM Cloud                                   | Virtual Servers               | Cloud Object Storage         | Db2, Cloud Databases                 | IBM Cloud Functions        | Load Balancer              | Kubernetes Service, Watson AI                   |
| Alibaba Group Cloud                         | Elastic Compute Service (ECS) | Object Storage Service (OSS) | ApsaraDB                             | Function Compute           | Alibaba Cloud CDN          | Container Service, API Gateway                  |
| DigitalOcean                                | Droplets                      | Spaces                       | Managed Databases                    | Functions                  | Load Balancer              | Kubernetes, App Platform, VPC                   |
| Akamai Technologies Cloud (formerly Linode) | Linode Compute Instances      | Object Storage               | Managed Databases                    | Functions                  | CDN                        | Kubernetes Engine, NodeBalancers                |



# FaaS 
With FaaS, you upload small backend functions to a cloud provider, and the cloud automatically runs the appropriate function whenever it's triggered, without you managing the underlying servers.

# BaaS
Backend as a Service (BaaS) provides ready-made backend services—such as authentication, databases, file storage, and notifications—so developers can build applications without implementing these common backend components themselves.


FaaS = You write the backend code.
BaaS = Someone else already wrote the backend features for you.


# Event-Driven Architecture
Event-Driven Architecture means the application waits for events, and whenever an event occurs, it automatically executes the appropriate action or function.


# API Gateway + Functions
An API Gateway acts like the front door for your APIs. It performs some of the same jobs as a web server (receiving HTTP requests), but it is specialized for managing API traffic rather than serving web pages.

# Serverless Microservices
One big backend becomes many small backend services, each responsible for a single feature and managed independently.

# Serverless Workflow / Orchestration
Serverless Workflow (Orchestration) is a service that coordinates multiple serverless functions, ensuring they execute in the correct order, handle failures, retries, and branching logic, to complete a complex business process.

# Serverless Data Processing
Serverless Data Processing is an architecture where data (such as files, images, videos, or logs) is automatically processed by serverless functions when it arrives, without requiring continuously running servers.

# Serverless Web Application
A Serverless Web Application is a web application where the frontend is served as static files (HTML, CSS, and JavaScript), while the backend functionality is provided by serverless functions that are invoked through an API Gateway and interact with databases or other services.



-----------------------------------------------------------------------------------------------------------------


# Cloud Benefits and Characteristics

- Scalability: Easily scale up or down as your application's needs change.
- On-demand self-service: Create or remove servers and storage instantly, without waiting for hardware.
- Pay only for what you use: You are charged based on usage, not upfront costs.
- Security: Cloud providers protect the infrastructure with strong security measures.
- High availability: Applications keep running even if part of the system fails.
- Global access: Your application can be accessed by users anywhere in the world.



# Types of Cloud (Deployment models)

- Public Cloud: Used by startups, websites, and global apps because it is affordable, easy to scale, and requires no infrastructure management. Public cloud services are preferable for nearly every use case.

- Private Cloud: Used by banks, healthcare, and government organizations because it offers greater control, customization, and compliance for sensitive data.

- Hybrid Cloud: Used by companies like e-commerce platforms that need to keep sensitive data private while still scaling publicly during high demand.



# main cloud service models:

  - Infrastructure as a Service (IaaS): You rent basic computing resources such as virtual servers, storage, and networking. You are responsible for managing the operating system and your application, while the provider manages the physical hardware.
    
  -  Platform as a Service (PaaS): The cloud provider manages the infrastructure and the operating system. You focus on building, deploying, and running your application without worrying about servers.
  - BaaS
  - FaaS
  
  - Software as a Service (SaaS): You use a complete application over the internet. The provider manages everything, and you access the software through a browser or app, for example, Gmail or Zoom.




# Key Terminology

Let's quickly review some concepts we learned in this room:

   - Public Cloud 
    Cloud services you access over the internet that many people and companies share.
    
   - Private Cloud 
    A cloud built just for one company, so they have more control and security.
    
   - Hybrid Cloud
    A mix of public and private clouds that can work together and share data.

   - IaaS
    A service where you rent basic computer parts like servers and storage from the cloud.

   - PaaS
   A service that gives you a ready-to-use environment to build and run apps without managing servers.
   
   - SaaS
    Software you use online without installing anything, like Gmail or Zoom.
   
   - EC2
    Amazon’s cloud computers that you can quickly create, use, and resize whenever you need them.


# We also concluded that the key benefits of cloud computing are:
    Scalability
    On-demand self-service
    Pay only for what you use
    Security
    High availability
    Global access
