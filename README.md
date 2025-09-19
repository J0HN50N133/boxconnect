# ECNU VPN

使用 OpenConnect 连接华东师范大学 VPN 的容器化解决方案。

## 使用方法

1. 构建容器镜像：

```bash
make build
```

2. 启动一个连接了 VPN 的 Bash Shell（需要提供服务器地址、用户名和密码）, ：

```bash
make vpn SERVER=vpn.ecnu.edu.cn USERNAME=你的学号 PASSWORD=你的密码
```

**注意：** `make vpn` 命令会执行以下隐式操作：

- 自动检测系统中可用的容器运行时（Podman 或 Docker）
- 启动一个临时容器，运行后自动清理（--rm 参数）
- 以交互模式运行（-it 参数），允许用户输入和查看输出
- 挂载本地 SSH 密钥目录（~/.ssh）到容器中
- 授予容器网络管理权限（--cap-add=NET_ADMIN）
- 映射 TUN 设备（--device /dev/net/tun）用于 VPN 连接

## 环境变量

运行 `make vpn` 时必须提供以下环境变量：

- `SERVER`: VPN 服务器地址（例如：vpn.ecnu.edu.cn）
- `USERNAME`: VPN 用户名（通常为学号）
- `PASSWORD`: VPN 密码

## 依赖

需要安装 Podman 或 Docker 容器运行时：

- [Podman 安装指南](https://podman.io/getting-started/installation)
- [Docker 安装指南](https://docs.docker.com/get-docker/)
