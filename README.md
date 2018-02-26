# Gomeet's examples

The [gomeet-examples/*](https://github.com/gomeet-examples) repositories are an use case of [gomeet's generators](https://github.com/gomeet/gomeet)

- [infra](https://github.com/gomeet-examples/infra) - Infra hacks and documentation
- [svc-echo](https://github.com/gomeet-examples/svc-echo) - Simple echo service
- [svc-profile](https://github.com/gomeet-examples/svc-profile) - Profile example
- [svc-api-gateway](https://github.com/gomeet-examples/svc-api-gateway) - The api gateway

## Tutorial

1. Prerequisites

    - [golang](https://golang.org/doc/install)
    - [git flow](https://danielkummer.github.io/git-flow-cheatsheet/)
    - [docker](https://docs.docker.com/engine/installation/) (optional)
    - [docker-compose](https://docs.docker.com/compose/install/) (optional)

1. Install [gomeet](https://github.com/gomeet/gomeet)

    ```shell
    go get -u github.com/gomeet/gomeet/gomeet
    ```

1. Generate sub services

    ```shell
    $ gomeet new github.com/gomeet-examples/svc-echo
    ...SNIP...
    $ gomeet new github.com/gomeet-examples/svc-profile --db-types=mysql
    ...SNIP...
    ```

1. Push sub services repositories

    ```shell
    cd $GOPATH/src/github.com/gomeet-examples/svc-echo
    git remote add origin https://github.com/gomeet-examples/svc-echo.git
    git push -u origin master
    git push -u origin develop

    cd $GOPATH/src/github.com/gomeet-examples/svc-profile
    git remote add origin https://github.com/gomeet-examples/svc-profile.git
    git push -u origin master
    git push -u origin develop
    ```

1. Define your protocols

    - [svc-echo/pb/echo.proto](https://github.com/gomeet-examples/svc-echo/blob/develop/pb/echo.proto)
    - [svc-profile/pb/profile.proto](https://github.com/gomeet-examples/svc-profile/blob/develop/pb/profile.proto)

1. Implement yours gRPC services for each services

    - Implement gRPC svc-echo.Echo service see rev. [f45784b](https://github.com/gomeet-examples/svc-echo/commit/f45784b68bab0c165f9707f8d5ce677321f12de1)
        - [server implementation](https://github.com/gomeet-examples/svc-echo/blob/develop/service/grpc_echo.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-echo/blob/develop/service/grpc_echo_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-echo/blob/develop/cmd/functest/helpers_echo.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-echo/blob/develop/cmd/remotecli/cmd_echo.go) (if necessary)

    - The `svc-profile` service uses a MySQL databases so you need create them ([see documentation](https://github.com/gomeet-examples/svc-profile/tree/develop/docs/devel/working_with_the_sources#database-initialization)) and declare your [model](https://github.com/gomeet-examples/svc-profile/blob/develop/models/models.go) see rev. [417b16d](https://github.com/gomeet-examples/svc-profile/commit/417b16d21124e27efeb35868aa8738534f3f51f9). Next you can run the `migrate` command :

        ```shell
        make
        _build/svc-profile migrate --mysql-dsn "USERNAME:PASSWORD@tcp(HOSTNAME:3306)/DBNAME"
        _build/svc-profile migrate --mysql-dsn "USERNAME:PASSWORD@tcp(HOSTNAME:3306)/DBNAME_test"
        ```

    - Implement your models in [models/models.go](https://github.com/gomeet-examples/svc-profile/blob/develop/models/profile_queries.go) see rev. [417b16d](https://github.com/gomeet-examples/svc-profile/commit/417b16d21124e27efeb35868aa8738534f3f51f9) and rev. [72836ec](https://github.com/gomeet-examples/svc-profile/commit/72836ecbf91c238ad883f6b972c4f138fafa72ef)

    - Implement your database queries in [models/profile_queries.go](https://github.com/gomeet-examples/svc-profile/blob/develop/models/profile_queries.go) see rev. [b652018](https://github.com/gomeet-examples/svc-profile/commit/b6520186c70308e44d36b0a1965e5fe10ad5ef10)

    - Implement gRPC svc-profile.Create service see rev. [97683b0](https://github.com/gomeet-examples/svc-profile/commit/97683b053d3f976860c59402c752029e92c7ea62)
        - [server implementation](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_create.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_create_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/functest/helpers_create.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/remotecli/cmd_create.go) (if necessary)

    - Implement gRPC svc-profile.Read service see rev. [a8a8ae3](https://github.com/gomeet-examples/svc-profile/commit/a8a8ae3593e473213ba06ba69d5f4c28ae086153)
        - [server implementation](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_read.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_read_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/functest/helpers_read.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/remotecli/cmd_read.go) (if necessary)

    - Implement gRPC svc-profile.Update service see rev. [507dbf3](https://github.com/gomeet-examples/svc-profile/commit/507dbf337c1bc0e73dd1add0a193116b63a2c00a)
        - [server implementation](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_update.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_update_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/functest/helpers_update.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/remotecli/cmd_update.go) (if necessary)

    - Implement gRPC svc-profile.SoftDelete service see rev. [a4ee760](https://github.com/gomeet-examples/svc-profile/commit/a4ee760ae8fca8528a6948de5f383c5cc4c7e5a2)
        - [server implementation](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_soft_delete.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_soft_delete_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/functest/helpers_soft_delete.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/remotecli/cmd_soft_delete.go) (if necessary)

    - Implement gRPC svc-profile.HardDelete service see rev. [bf668c8](https://github.com/gomeet-examples/svc-profile/commit/bf668c87dc9a9bf60e3ffd79101e0bd00f361bcd)
        - [server implementation](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_hard_delete.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_hard_delete_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/functest/helpers_hard_delete.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/remotecli/cmd_hard_delete.go) (if necessary)

    - Implement gRPC svc-profile.List service see rev. [bf668c8](https://github.com/gomeet-examples/svc-profile/commit/bf668c87dc9a9bf60e3ffd79101e0bd00f361bcd)
        - [server implementation](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_list.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-profile/blob/develop/service/grpc_list_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/functest/helpers_list.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-profile/blob/develop/cmd/remotecli/cmd_list.go) (if necessary)

    - [service/helpers.go](https://github.com/gomeet-examples/svc-profile/blob/develop/service/helpers.go) and [service/helpers_test.go](https://github.com/gomeet-examples/svc-profile/blob/develop/service/helpers_test.go) helpers files have been created, rev. [2e5df1a](https://github.com/gomeet-examples/svc-profile/commit/2e5df1a5e165f7206e662979073f58bd702e1cff)

1. Generate the api gateway and push it to github

    ```shell
    $ gomeet new github.com/gomeet-examples/svc-api-gateway --sub-services=github.com/gomeet-examples/svc-echo,github.com/gomeet-examples/svc-profile
    ...SNIP...
    cd $GOPATH/github.com/gomeet-examples/svc-api-gateway
    git remote add origin https://github.com/gomeet-examples/svc-api-gateway.git
    git push -u origin master
    git push -u origin develop
    ```

1. Define api-gateway protocol see rev. [b5d6b71](https://github.com/gomeet-examples/svc-api-gateway/commit/b5d6b717dd2c0fcae009495cb96ebf37e63a603f)

    - [svc-api-gateway/pb/api-gateway.proto](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/pb/api-gateway.proto)

1. Implement yours gRPC services for each services

    - Implement gRPC svc-api-gateway.Echo proxy to svc-echo.Echo service see rev. [1790f28](https://github.com/gomeet-examples/svc-api-gateway/commit/1790f280c72e30229e24bc5b0d5cb1dd07c507cf)
        - [server implementation](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_echo.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_echo_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/functest/helpers_echo.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/remotecli/cmd_echo.go) (if necessary)

    - Implement gRPC svc-api-gateway.CreatedProfile proxy to svc-profile.Create service see rev. [3ef56eb](https://github.com/gomeet-examples/svc-api-gateway/commit/3ef56eb62a00e3e7c2b3f37291e6246c0fe609d8)
        - [server implementation](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_create_profile.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_create_profile_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/functest/helpers_create_profile.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/remotecli/cmd_create_profile.go) (if necessary)

    - Implement gRPC svc-api-gateway.ReadProfile proxy to svc-profile.Read service see rev. [3503038](https://github.com/gomeet-examples/svc-api-gateway/commit/3503038e116abaefa3e06516fa597ecd9940c208)
        - [server implementation](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_read_profile.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_read_profile_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/functest/helpers_read_profile.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/remotecli/cmd_read_profile.go) (if necessary)

    - Implement gRPC svc-api-gateway.UpdateProfile proxy to svc-profile.Update service see rev. [6b11127](https://github.com/gomeet-examples/svc-api-gateway/commit/6b1112723ad8d50cbe6f98dc8489ea74442ad28e)
        - [server implementation](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_update_profile.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_update_profile_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/functest/helpers_update_profile.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/remotecli/cmd_update_profile.go) (if necessary)

    - Implement gRPC svc-api-gateway.DeleteProfile proxy to svc-profile.SoftDelete service see rev. [8b57484](https://github.com/gomeet-examples/svc-api-gateway/commit/8b57484767650af291e8ff2978722506a29e29e2)
        - [server implementation](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_delete_profile.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_delete_profile_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/functest/helpers_delete_profile.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/remotecli/cmd_delete_profile.go) (if necessary)

    - Implement gRPC svc-api-gateway.ListProfile proxy to svc-profile.SoftList service see rev. [a6adf26](https://github.com/gomeet-examples/svc-api-gateway/commit/a6adf267054fa30695463bc3d287f2c1d2ae3184)
        - [server implementation](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_list_profile.go)
        - [server unit tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/service/grpc_list_profile_test.go)
        - [functional tests](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/functest/helpers_list_profile.go)
        - and [adapt the cli and console command](https://github.com/gomeet-examples/svc-api-gateway/blob/develop/cmd/remotecli/cmd_list_profile.go) (if necessary)

1. Run

    - in baremetal see [infra/hack/gomeet-run-dev](https://github.com/gomeet-examples/infra/blob/master/hack/gomeet-run-dev)
    - in docker-compose see [infra/docker-compose.yml](https://github.com/gomeet-examples/infra/blob/master/docker-compose.yml)

