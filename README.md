# Incapsula APIv1 OpenAPI Spec

Imperva APIv1 Spec

This contains the Imperva API v1 Spec intended to be consumed by the [OpenAPI Generator](https://openapi-generator.tech) project:

## Usage Examples

### Build PHP SDK

You can use the OpenAPI Generator CLI to generate a PHP sdk from this spec. In this example we will use the Docker image [openapitools/openapi-generator-cli](https://hub.docker.com/r/openapitools/openapi-generator-cli/) to generate the SDK.

```bash
$ docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli generate \
        --input-spec        https://raw.githubusercontent.com/brettt89/incapsula-api/master/IncapsulaAPIv1.yaml \
        --generator-name    php \
        --output            /local
```

Then run `composer install`

### Viewing API spec via Swagger-ui

[Swagger UI](https://swagger.io/tools/swagger-ui/) is a tool to visualize and interact with OpenAPI Specifications. This example will use the [swaggerapi/swagger-ui](https://hub.docker.com/r/swaggerapi/swagger-ui/) Docker image to generate the Swagger UI web interface.

```bash
$ docker run -d -p 80:8080 -e SWAGGER_JSON=/app/IncapsulaAPIv1.yaml -v ${PWD}:/app swaggerapi/swagger-ui
```

## Contribution

Contributions are welcome. Please ensure all contributions are created as pull-requests to be merged into `master`.

## Author

brett.tasker@gmail.com

