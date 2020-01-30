# Create SQL instance
resource "google_sql_database_instance" "prod-epmcseclab-db" {
 name    = "prod-epmcseclab-db-demo"
 project = "${var.project}"
 region  = "${var.region}"
 database_version = "MYSQL_5_7"

 

  settings {
    tier = "db-f1-micro"
    activation_policy = "ALWAYS"

 

    ip_configuration {
            ipv4_enabled    = "true"
            require_ssl     = "false"
            authorized_networks  {
                name = "All"
                value = "0.0.0.0/0"
            }
        }
    

 

    location_preference {
            zone = "${var.zone-1}"
        }
    backup_configuration {
           binary_log_enabled  = "true"
           enabled             = "true"
           start_time          = "12:00"
       }

 

       maintenance_window {
           day          = 1
           hour         = 2
           update_track = "stable"
    }
   }
}