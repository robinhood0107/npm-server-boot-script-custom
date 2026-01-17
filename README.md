# npm-server-boot-script-custom
npm-server-boot-script-custom shell파일

## 요구사항
- Ubuntu 20.04 LTS 이상

## 사용법
- 인스턴스 생성 후, 터미널에 다음을 입력하고 실행

```sh
curl -fsSL https://raw.githubusercontent.com/robinhood0107/npm-server-boot-script-custom/refs/heads/main/npm-server-boot-script-custom.sh -o oci-boot-script.sh
sudo sh oci-boot-script.sh
```

## shell 실행시 설정하는 항목들
- apt update / upgrade
- Timezone: Asia/Seoul
- Virtual Memory: 4GB
- Port Open: 22, 80, 81, 443, 8000, 9443
- Docker
  - Docker-compose
  - Network: npmnetwork
  - Container
    - Nginx Proxy Manager
    - Portainer

## 도커 내부의 네트워크
- `npm-net` 네트워크로 **Nginx Proxy Manager**와 **Portainer**가 연결됩니다. **Nginx Proxy Manager**에서 새로운 컨테이너에 프록시 연결을 하려면 컨테이너 네트워크에 `npmnetwork`을 추가가 필요.
- `sudo docker network connect npmnetwork 컨테이너이름`
- 같은 네트워크에 있는 컨테이너는 **Nginx Proxy Manager**의 hostname/ip에 컨테이너 이름을 입력하여 편하게 프록시 연결할 수 있습니다.
