resource "google_cloud_run_v2_job" "job" {
  for_each = try(local.assets.jobs, {})
  name     = each.key
  location = each.value.location

  template {
    template {
      containers {
        image = each.value.container_image
        resources {
          limits = {
            cpu    = "1"
            memory = "2Gi"
                  }
                }
        env {
          name = each.value.env[0].name
          value = each.value.env[1].value
        }
        env {
          name = try(each.value.env_1[0].name, "TEST")
          value = try(each.value.env_1[1].value, "teste1")
        }
      }
      timeout     = try(each.value.timeout, "900s")
      max_retries = try(each.value.max_retries, 0)
    
    }
  }
}
