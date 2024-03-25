# Basic REST Delivery Configuration Example

Configuration in this directory creates a [REST delivery point and child objects](https://docs.solace.com/API/REST/REST-Consumers.htm#_Toc433874658) on the PubSub+ event broker, with minimum configuration, leveraging the REST Delivery Terraform module.

## Module Configuration in the Example

### Required Inputs

* `msg_vpn_name` - set to `default` in the example
* `rest_delivery_point_name`
* `url` - set to `https://example.com/test` in the example. Note that it includes the endpoint path
* `queue_name` - `rdp_queue`, the queue that has been created to be used with the RDP

Important: The REST delivery point must have permission to consume messages from the queue — to achieve this, the queue’s owner must be set to `#rdp/<rest_delivery_point_name>` or the queue’s permissions for non-owner clients must be set to at least `consume` level access. Queue ingress and egress must also be enabled.

### Optional Inputs

Optional module input variables have the same name as the attributes of the underlying provider resource. If omitted then the default for the related resource attribute will be configured on the broker. For attributes and defaults, refer to the [documentation of "solacebroker_msg_vpn_rest_delivery_point_rest_consumer"](https://registry.terraform.io/providers/solaceproducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_rest_consumer#optional).

The module default for the `enabled` variable is true, which enables both the RDP and the REST consumer resources.

### Output

The module `rdp`, `consumer` and `queue_binding` outputs refer to the created REST delivery point, REST consumer and queue binding.

## Created resources

This example will create following resources:

* `solacebroker_msg_vpn_queue` (created before the module, as pre-requisite)
</br></br>
* `solacebroker_msg_vpn_rest_delivery_point`
* `solacebroker_msg_vpn_rest_delivery_point_rest_consumer`
* `solacebroker_msg_vpn_rest_delivery_point_queue_binding`

## Running the Example

### Access to a PubSub+ broker

If you don't already have access to a broker, refer to the [Developers page](https://www.solace.dev/) for options to get started.

### Sample source code

The sample is available from the module GitHub repo:

```bash
git clone https://github.com/SolaceProducts/terraform-solacebroker-rest-delivery.git
cd examples/basic
```

### Adjust Provider Configuration

Adjust the [provider parameters](https://registry.terraform.io/providers/solaceproducts/solacebroker/latest/docs#schema) in `main.tf` according to your broker. The example configuration shows settings for a local broker running in Docker.

### Create the resource

Hint: You can verify configuration changes on the broker, before and after, using the [PubSub+ Broker Manager Web UI](https://docs.solace.com/Admin/Broker-Manager/PubSub-Manager-Overview.htm)

Execute from this folder:

```bash
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` to clean up created resources when no longer needed.

## Additional Documentation

Refer to the [Managing REST Delivery Points](https://docs.solace.com/Services/Managing-RDPs.htm) section in the PubSub+ documentation.
