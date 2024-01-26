Questions
1. SetUp of Application
- Add app files to repo
- Test if the application is working locally

2. How do you use a kubeconfig file to gain access to a cluster?
- Download kube config file
- export KUBECONFIG=/path/to/Cohort0/kubeconfig
- kubectl config get-contexts   => to check for the contexts
- kubectl config use-context waltcohort => to select contexts
- kubectl get nodes  

3. Create a Dockerfile
- This setup uses Nginx to serve static files and handle requests. - - The Next.js server is not used in this configuration.
- The Nginx server is set to listen on port 80. You can change this to another port if needed.
- The nginx.conf provided is a basic configuration. Depending on your application's needs, you might need to customize it further.
- This approach is suitable for fully static Next.js sites. If your Next.js application requires server-side rendering for each request, you'll need to modify this approach to serve dynamic content.

######################### NGINX OR NOT ################
Deciding whether to use Nginx or serve your Next.js application directly depends on several factors, including your application's architecture, performance requirements, and hosting environment. Here are some considerations to help you make an informed decision:

### Using Nginx for Static Serving:
- **Performance**: Nginx is highly efficient at serving static files and can handle a large number of requests with low latency, which is beneficial for performance.
- **Caching**: Nginx provides robust caching mechanisms which can significantly improve load times for static content.
- **Reverse Proxy**: Nginx can act as a reverse proxy, providing additional layers of security and the ability to handle SSL/TLS termination.
- **Load Balancing**: If your application scales to multiple instances, Nginx can effectively distribute traffic across these instances.
- **Configuration Flexibility**: Nginx offers extensive configuration options for URL rewriting, redirects, custom error pages, and more.

### Serving Directly Without Nginx:
- **Simplicity**: For small applications or projects with minimal configuration, serving directly might be simpler as it involves fewer components and less setup.
- **Dynamic Content**: If your application heavily relies on server-side rendering or dynamic content generation, serving directly with Next.js might be more straightforward.
- **Development Environments**: In a development environment, where performance and scaling are less of a concern, directly serving the app is often more convenient.

### Considerations:
- **Application Needs**: If your Next.js application is mostly static, Nginx can be a great choice for its performance benefits. However, if your application requires a lot of dynamic rendering, using Next.js's built-in server might be more appropriate.
- **Infrastructure Complexity**: Adding Nginx adds an extra layer to your infrastructure, which can increase complexity in terms of setup, maintenance, and configuration.
- **Hosting Environment**: Some hosting platforms (like Vercel, specifically optimized for Next.js) handle optimizations, scaling, and serving automatically, which might negate the need for a separate Nginx setup.

### Conclusion:
- **For Static Sites**: If your site is static, or if you pre-render most of your pages and only have a few dynamic routes, using Nginx can provide performance advantages.
- **For Dynamic Sites**: If your site heavily relies on server-side rendering or needs to handle dynamic requests frequently, it might be more straightforward to serve it directly using Next.js.

Ultimately, the "better" choice depends on your specific use case, the nature of your application, your technical requirements, and your hosting environment. In many cases, a combination of both (serving dynamic content directly through Next.js and static content through Nginx) might be the optimal solution.

Deploying a Next.js application on Kubernetes with Prometheus, Grafana, and Cert-Manager introduces a more complex and scalable infrastructure. In such a setup, the choice between using Nginx or serving directly from Next.js hinges on how you want to manage your traffic, performance optimizations, and the specific requirements of your application. Here are some considerations for both approaches in a Kubernetes environment:

### Using Nginx in Kubernetes:

1. **Load Balancing and Performance**: Nginx can efficiently handle static content and act as a reverse proxy, providing load balancing which is beneficial for distributing traffic among multiple pods.

2. **SSL/TLS with Cert-Manager**: Nginx works well with Cert-Manager for managing SSL/TLS certificates, which is crucial for secure HTTPS traffic.

3. **Caching and Compression**: Nginx excels in caching static content and compressing files, which can enhance the performance of your application.

4. **Integration with Prometheus and Grafana**: Nginx metrics can be exported to Prometheus, and you can visualize these metrics in Grafana for monitoring performance, traffic, and health of your application.

### Serving Directly from Next.js in Kubernetes:

1. **Simplified Stack**: Serving directly from Next.js simplifies your stack as it eliminates the need for an additional layer (Nginx), reducing complexity in deployment and configuration.

2. **Dynamic Content**: If your application heavily relies on server-side rendering or dynamic content, directly serving with Next.js can be more straightforward.

3. **Native Kubernetes Features**: Kubernetes provides load balancing, auto-scaling, and self-healing features. You can leverage Ingress controllers (which can include Nginx functionality) for SSL/TLS termination and routing.

4. **Monitoring with Prometheus and Grafana**: Regardless of whether you use Nginx or not, you can still monitor your Next.js application with Prometheus and Grafana.

### Additional Considerations:

- **Cert-Manager**: Cert-Manager can be used for certificate management irrespective of whether you use Nginx or serve directly. It automates the management and issuance of TLS certificates in Kubernetes.

- **Prometheus and Grafana**: These tools are primarily for monitoring and visualization. Their utility doesn't significantly depend on whether you use Nginx or not. They can collect metrics from both setups effectively.

- **Kubernetes Ingress**: If you decide not to use Nginx as a reverse proxy within your pods, consider using a Kubernetes Ingress controller (which can be based on Nginx) for routing external HTTP(S) traffic to your services.

### Conclusion:

- **Nginx**: For high traffic sites, or when you need advanced load balancing, caching, and performance optimization, Nginx is a better choice. It also integrates well with Kubernetes, Prometheus, Grafana, and Cert-Manager.

- **Direct Serving**: For simpler applications, especially those that require dynamic rendering, serving directly from Next.js can be more suitable. Kubernetes' native features can handle many of the tasks that Nginx would otherwise manage.

Ultimately, the decision depends on your specific application needs, traffic patterns, and how comfortable you are managing either setup. In a Kubernetes environment, both options are viable and can be integrated effectively with Prometheus, Grafana, and Cert-Manager.

civo kubernetes create civo-cluster -n 3 -s g4s.kube.medium --cluster-type k3s --create-firewall --firewall-rules "6443" --region NYC1 --wait --save --merge --switch

kubectl create secret docker-registry ghcr-credentials --docker-server=ghcr.io --docker-username=chukwuka1488 --docker-password=YOUR_GHCR_TOKEN