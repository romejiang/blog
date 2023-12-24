# Prometheus and Grafana

# **Docker部署**

```yaml
docker-compose.yml

version: '3'
services:
  prometheus:
    image: prom/prometheus
    container_name: prometheus
    user: root
    restart: always
    ports:
      - "9990:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    command:
      - "--config.file=/etc/prometheus/prometheus.yml"
      - "--web.enable-admin-api"
      - "--web.enable-lifecycle"

  grafana:
    image: grafana/grafana
    container_name: grafana
    user: root
    restart: always
    ports:
      - "9993:3000"

  pushgateway:
    image: prom/pushgateway
    container_name: pushgateway
    user: root
    ports:
      - "9991:9091"
```

### 配置文件，上面 docker-compose.yml 依赖

```yaml
prometheus.yml
global:
  scrape_interval: 5s
scrape_configs:
  - job_name: 'pushgateway'
    static_configs:
      - targets: ['pushgateway:9091']
```

## 删除数据的方法

```bash
// curl -v -X POST -g 'http://admin.yunduowa.com:9990/api/v1/admin/tsdb/delete_series?match[]=fwm_active_users&match[]=fwm_energy_total&match[]=fwm_energy_users&match[]=fwm_total_users&start=1634601600&end=1634643000'

// let start = Math.round(new Date('2021-10-19 08:00:00').getTime() / 1000)
// let end = Math.round(new Date('2021-10-19 19:30:00').getTime() / 1000)
```

# 参考文章

[https://codersociety.com/blog/articles/nodejs-application-monitoring-with-prometheus-and-grafana](https://codersociety.com/blog/articles/nodejs-application-monitoring-with-prometheus-and-grafana) 

删除数据

[https://sbcode.net/prometheus/delete-timeseries/](https://sbcode.net/prometheus/delete-timeseries/)[https://prometheus.io/docs/prometheus/latest/querying/api/](https://prometheus.io/docs/prometheus/latest/querying/api/)[https://www.shellhacks.com/prometheus-delete-time-series-metrics/](https://www.shellhacks.com/prometheus-delete-time-series-metrics/)

WMIC path win32_process get Caption,Processid,Commandline

WMIC /OUTPUT:C:\Process.txt path win32_process get Caption,Processid,Commandline

[https://rigorousthemes.com/blog/best-grafana-dashboard-examples/](https://rigorousthemes.com/blog/best-grafana-dashboard-examples/)