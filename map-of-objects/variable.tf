variable "instances" {
    type = map(object({
     machine_type=string
     project_id=string
     zone= string
     image= string
     network=string 
    }))
  
}