# ELK-Stack-Project1
Configuration of an ELK stack server in order to set up a cloud monitoring system 
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.


![image diagram](https://user-images.githubusercontent.com/104738434/166611035-55494954-d86b-4d8b-8337-6aa501e5d7c7.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML files may be used to install only certain pieces of it, such as Metricbeat and Filebeat.

- Filebeat-config.yml
- Filebeat-playbook.yml
- Install-elk.yml
- Metricbeat-config.yml
- Metricbeat-playbook.yml
- pentest.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available and reliable, in addition to restricting access to the network.
- What aspect of security do load balancers protect? 

A load balancer distributes traffic from clients across the use of multiple servers. It provides additional security as it is between the client and the server. Load balancing protects applications from emerging threats through the use of a Web Application Firewall. This helps to protect the website which the client is using from potential hackers. Load balancers can also request a username and password before granting access to a website which protects against unwanted login attempts. They can also help to protect against DDos attacks. 


- What is the advantage of a jump box?
A jump box is a system that manages devices in a separate security zone. By doing so, it provides controlled access between the two. A jump box connects to other Azure virtual machines through a dynamic IP. This is advantageous as it prevents all of the VM’s from being publicly exposed, and is able to restrict which IP addresses are able to connect and communicate with the jump box making it more secure. It essentially serves as a bridgeway between network zones. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file systems and system logs.
- What does Filebeat watch for?
Filebeat plays the part of the logging agent by generating, tailing and shipping log files. It does this in a lightweight way.  
-  What does Metricbeat record?
Similarly metricbeat is a lightweight shipper that collects metrics from the operating system. Metricbeat records the metrics and statistics and ships it to a specified output. 

The configuration details of each machine may be found below:

| **Name** | **Function** | **IP Address** | **Operating System** |
|----------|--------------|----------------|----------------------|
| JumpBox  | Gateway      | 10.0.0.4       | Linux                |
| Web-1    | Web-server   | 10.0.0.6       | Linux                |
| Web-2    | Web-server   | 10.0.0.7       | Linux                |
| Elk-VM   | Monitoring   | 10.1.0.5       | Linux                |


### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the JumpBox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- My computer's public IP address of 96.240.138.68

Machines within the network can only be accessed through SSHing from the JumpBox.
- Which machine did you allow to access your ELK VM? What was its IP address? I allowed the Jump-Box VM to access the ELK VM which has an IP of 10.0.0.4 and public IP of 20.210.91.34. Also allowed to connect through TCP 5601 which is how we connected to Kibana. 

A summary of the access policies in place can be found in the table below.
| **Name** | **Publicly Accessible** | **Allowed IP Address**     |
|----------|-------------------------|----------------------------|
| JumpBox  | Yes                     | 10.0.0.4                   |
| Web-1    | No                      | 10.0.0.4                   |
| Web-2    | No                      | 10.0.0.4                   |
| Elk-VM   | No                      | 10.0.0.4 and TCP with 5601 |

Web-1, Web-2, and Elk-VM allowed says 10.0.0.4 as this is IP of jumpbox provisioner. 


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because Ansible can quickly and easily configure and deploy new machines on multiple servers simultaneously. 
: What is the main advantage of automating configuration with Ansible? The automation of ansible simplifies complex tasks and allows developers to focus attention on something less efficient. 

The playbook implements the following tasks:
- # Elk Configuration:
Firstly, I created a new Vnet in the same resource group that I had been using

![elk](https://user-images.githubusercontent.com/104738434/166584396-e732945d-9b2b-4744-99e3-2272d7dcfe7b.jpg)

I then created a peer connection between my vNets. This will allow traffic to pass between the VNets and regions. This peer connection will make both a connection from the first vNet to the second Vnet and a reverse connection from the second vNet back to the first vNet, thus allowing traffic to pass in both directions. 
![Red Team net peer ](https://user-images.githubusercontent.com/104738434/166584704-c42ddfdd-796f-4618-b030-77ba654cfe77.jpg)


![Elk Vnet peer](https://user-images.githubusercontent.com/104738434/166584982-226a1315-65b7-445b-adf4-134472e2ddeb.jpg)

Next, I created a new virtual machine named Elk-VM. Once created, I opened up a terminal and SSH into the jumpbox. From the jumpbox login shell I ran the required Docker commands to start and attach to my ansible container. (sudo docker start –name of container- && sudo docker attach –name of container–). I then used cat command to retrieve my public ssh key. 

I verified the new VM in Azure was working by connecting via SSH from the Ansible container onto my jumbox VM.

From my ansible container I added the new VM to the Ansible’s hosts file, created a playbook that installs Docker and configures the container, and ran the playbook to launch the container. 

![_etc_ansible_hosts](https://user-images.githubusercontent.com/104738434/166585191-94b5c8bd-5b48-42df-86c0-c00bd1a277a9.jpg)

After the playbook was completed, I used the command line to SSH into the ELK server and ensure that the sebp/elk: 761 container was running. 
The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.


![docker ps](https://user-images.githubusercontent.com/104738434/166523037-35cba19b-0936-43aa-8d26-867052f8467b.jpg)

Lastly, I opened my virtual network's existing NSG and created an incoming rule for my security group that allows TCP traffic over port 5601 from my public IP address. I verified that I was able to access the server by navigating to http://[my.ELK-VM.External.IP]:5601/app/kibana. 

![Observeability ](https://user-images.githubusercontent.com/104738434/166585488-29f134f4-d51b-4a2b-a60b-f25e3ed497ea.jpg)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
Web 1: 10.0.0.6
Web 2: 10.0.0.7


We have installed the following Beats on these machines:
Filebeat
Metricbeat

These Beats allow us to collect the following information from each machine:
Filebeat allows us to monitor Elasticsearch log files, collect log events and ship them to a monitoring cluster. We can then use Kibana to visualize data. Metricbeat can be used to collect data from servers such as CPU or memory. Metricbeat allows us to learn how to connect, how often to collect metrics, and specifically which metrics to collect. 

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- Copy the Filebeat configuration file from the Ansible container to Web VMs where you installed Filebeat. run : 
- filebeat modules enable system
- filebeat setup
- service filebeat start

These commands will enable the system. 

- Update the Ansible Playbook file to include the Filebeat .deb file, Update and copy the provided Filebeat config file, run the filebeat modules enable docker command, run the filebeat setup command, run the filebeat -e command, and enable the Filebeat service on boot.

![filebeat config yml](https://user-images.githubusercontent.com/104738434/166585689-703cd123-c3fa-4d61-b367-1763ef20f3ad.jpg)


- Run the playbook, and navigate to http://[your.VM.IP]:5601/app/kibana. Use the public IP address of the ELK server that you created. Navigate back to the Filebeat installation page on the ELK server GUI.On the same page, scroll to Step 5: Module Status and click Check Data. Scroll to the bottom of the page and click Verify Incoming Data.It should look like this 

![proving](https://user-images.githubusercontent.com/104738434/166585903-ecba3dc0-b7d0-43ba-b3c0-72b49ecdb5b8.jpg)



- Similarly, do the same for Metricbeat. 

