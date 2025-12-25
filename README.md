# 🐳 Docker en Producción — Arquitectura Web con Nginx, PHP y MariaDB

Proyecto práctico orientado a **Administración Linux / SRE / DevOps junior**, diseñado para simular un entorno **real de producción con Docker**.

El objetivo es demostrar:
- Diseño de servicios desacoplados
- Persistencia de datos
- Reverse proxy
- Logs
- Backups automáticos
- Resiliencia y buenas prácticas

---

## 🏗️ Arquitectura

Internet
│
▼
Nginx (Reverse Proxy)
│
├── App Web (PHP + Apache)
│
└── Base de Datos (MariaDB)

Volúmenes persistentes
Logs en host
Backups automáticos (systemd timer)


---

## 📦 Servicios

### 🔹 Nginx
- Reverse proxy
- Proxy hacia la app
- Logs persistentes
- Healthcheck activo

### 🔹 App Web
- PHP + Apache
- Conexión a MariaDB mediante variables de entorno
- Logs persistentes
- Healthcheck activo

### 🔹 Base de Datos
- MariaDB 10.11
- Usuario no root
- Password por variables
- Volumen persistente
- Healthcheck activo

---

## 🔁 Resiliencia
- `restart: unless-stopped`
- `depends_on`
- Healthchecks en todos los servicios

---

## 💾 Persistencia

Volúmenes Docker montados en el host:
- `./db` → Datos MariaDB
- `./logs/nginx`
- `./logs/apache`
- `./logs/mariadb`

---

## 📜 Logs

Los logs son accesibles desde el host:
- Nginx
- Apache
- MariaDB

Ejemplo:
tail -f logs/apache/error.log

💾 Backups automáticos

Script Bash que realiza:

Backup de MariaDB con mysqldump

Rotación automática (7 días)

Ejecución mediante systemd timer (nivel producción).
systemctl list-timers | grep docker-db-backup

🔒 Seguridad

Usuario no root en la base de datos

Variables de entorno

Puertos mínimos expuestos

Redes Docker separadas (frontend / backend)

🚀 Puesta en marcha
docker compose up -d
Comprobación:
docker compose ps
