//  Collect together all of the output variables needed to build to the final
//  inventory from the inventory template

data "template_file" "inventory" {
  template = "${file("${path.cwd}/inventory.template.cfg")}"
  vars = {}
}

//  Create the inventory.
resource "local_file" "inventory" {
  content     = "${data.template_file.inventory.rendered}"
  filename = "${path.cwd}/inventory.cfg"
}