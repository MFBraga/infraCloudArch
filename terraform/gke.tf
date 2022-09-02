## CREATE GKE CLUSTER
resource "google_container_cluster" "gke_cluster" {
    name        = sensitive("${var.prefix}-gke-cluster")
    location    = "${var.gcp_region}"
    description = "Atividade - Aula 05"

    remove_default_node_pool = true
    initial_node_count       = 1

    cluster_autoscaling {
        enabled = false
    }

    addons_config {
        http_load_balancing {
            disabled = true
        }

        horizontal_pod_autoscaling {
            disabled = true
        }
    }

    networking_mode = "VPC_NATIVE"
    network         = google_compute_network.vpc.name
    subnetwork      = google_compute_subnetwork.subnet4.name

    # dns_config {
    #     cluster_dns = "CLOUD_DNS"
    #     cluster_dns_scope = "VPC_SCOPE"
    #     cluster_dns_domain = "${var.prefix}"
    # }

    ip_allocation_policy {
        cluster_ipv4_cidr_block  = "10.44.0.0/21"
        services_ipv4_cidr_block = "10.44.8.0/21"
    }

    resource_labels = {
        environment = "${var.tag_env}"
        automation  = "${var.tag_terraform}"
    }
}

## CREATE SEPARATELY MANAGED NODE POOL
resource "google_container_node_pool" "primary_nodes" {
    name       = sensitive("${google_container_cluster.gke_cluster.name}-node-pool")
    location   = "${var.gcp_region}"
    cluster    = google_container_cluster.gke_cluster.name
    node_count = "${var.gke_nodes}"

    node_config {
        preemptible  = true
        machine_type = "${var.machine}"
        
        metadata = {
            disable-legacy-endpoints = "true"
        }

        labels = {
            environment = "${var.tag_env}"
            automation  = "${var.tag_terraform}"
        }
    }
}


## CREATE VPC (1044)
resource "google_compute_network" "vpc" {
    name                    = sensitive("${var.prefix}-vpc")
    auto_create_subnetworks = "false"
}

## CREATE SUBNET FOR CLUSTER NODES (Virtual Machines)
resource "google_compute_subnetwork" "subnet4" {
    name          = sensitive("${var.prefix}-subnet4")
    region        = "${var.gcp_region}"
    network       = google_compute_network.vpc.id
    ip_cidr_range = "10.4.0.0/16"
}